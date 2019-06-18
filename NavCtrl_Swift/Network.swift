//
//  Network.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 1/22/19.
//  Copyright © 2019 turntotech. All rights reserved.
//

import Foundation

class Network {
    
    //    var companyVC : CompanyVC
    var delegate: StockDelegate?
    
    //    init(companyVC : CompanyVC) {
    //        self.companyVC = companyVC
    init() {
        start()
    }
    
    func start() {
        
       
        
        let symbols = DAO.share.companiesObject.map { $0.stockTicker!.uppercased() }
        
        for symbol in symbols {
            if symbol != "" {
                letPrice(symbol: symbol)
            }
        }
    }
    
    func letPrice(symbol: String) {
        let baseUrl = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=\(symbol)&apikey=9TGRNY2XC629OP3Q"
        
        guard let url = URL(string: baseUrl) else {
            print("ERROR: url is incorrect")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("request error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                guard let jsonObject = json?["Global Quote"] as? [String: Any] else {
                    return
                }
                let stock = try Stock(json: jsonObject)
                
                for (index, company) in DAO.share.companiesObject.enumerated() {
                    if stock.symbol == company.stockTicker {
                      //  print("here i get the price of \(DAO.share.companies[index].name)")
                        DAO.share.companiesObject[index].stockPrice = stock.price
                    }
                }
                DispatchQueue.main.async {
                  self.delegate?.updated()
                }
                print("\(stock.symbol) = \(stock.price)")
            }
            catch let serilizationError {
                print("Failed \(serilizationError.localizedDescription)")
            }
            
            } .resume()
        
    }
    
}

