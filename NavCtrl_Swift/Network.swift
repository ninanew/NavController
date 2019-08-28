//
//  Network.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 1/22/19.
//  Copyright © 2019 turntotech. All rights reserved.
//

import Foundation

class Network {
    
    var stockUpdated: ((Stock) -> Void)?
    init() {
        start()
    }
    
    func start() {
       let symbols = DAO.readCompanies()?.compactMap { $0.stockTicker.uppercased() }
    
        symbols?.forEach { symbol in
            letPrice(symbol: symbol)
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
                
//                for (index, company) in DAO.share.companiesObject.enumerated() {
//                    if stock.symbol == company.stockTicker {
//                        DAO.share.companiesObject[index].stockPrice = stock.price
//                    }
//                }
                DispatchQueue.main.async { [weak self] in
                    self?.stockUpdated?(stock)
                }
                print("\(stock.symbol) = \(stock.price)")
            }
            catch let serilizationError {
                print("Failed \(serilizationError.localizedDescription)")
            }
            
            }.resume()
    }
}

