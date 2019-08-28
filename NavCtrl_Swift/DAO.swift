//
//  DAO.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 10/3/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DAO {
    
    static let share = DAO()
    
    
    static func readCompanies() -> [Company]? {
        // Retrieve all data from Core Data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<CoreCompany> = CoreCompany.fetchRequest()
        guard let companies = try? managedContext.fetch(fetchRequest) else { return nil }
        
        return companies.compactMap { Company(withCore: $0) }
    }
    
    func saveProductToCoreData(name: String, imageUrl: String, productURL: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let productsManaged = CoreProduct(context: managedContext)
        
        productsManaged.name = name
        productsManaged.imageUrl = imageUrl
        productsManaged.productURL = productURL
        // selectedCoreCompany!.addToProducts(productsManaged)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            
        }
    }
    
    func saveCompanyToCoreData(name: String, imageUrl: String?, stockTicker: String?, stockPrice: Stock?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let managedCompany = CoreCompany(context: managedContext)
        managedCompany.name = name
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func editCompany(coreCompany: CoreCompany, name: String, imageUrl: String?, stockTicker: String?){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        coreCompany.name = name
        coreCompany.imageUrl = imageUrl
        coreCompany.stockTicker = stockTicker

//        let fetchRequest : NSFetchRequest<CoreCompany> = CoreCompany.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
//        guard let companies = try? managedContext.fetch(fetchRequest) else { return }
//        companies[0].name = "Amazon1"
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not . \(error), \(error.userInfo)")
        }
        
        
        
      //  managedContext.fetch(fetchRequest)
        
        
//
//        let managedCompany = CoreCompany(context: updatedContext)
//        managedCompany.name = name
//
//        do {
//            try managedCompany.updatedObjects
//        } catch let error as NSError {
//            print("Could not edit. \(error), \(error.userInfo)")
//        }
    
    }
    
//    func editProduct(name: String, imageUrl: String?) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        let updatedProductContext = appDelegate.persistentContainer.viewContext
//        let updatedProduct = CoreProduct(context: updatedProductContext)
//        updatedProduct.name = name
//
//        do {
//            try updatedProductContext.updatedObjects
//        } catch let error as NSError {
//            print("Could not edit products. \(error), \(error.userInfo)")
//        }
//
//    }
    
    static func delete(company: Company) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        if let com = company.core {
            managedContext.delete(com)
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    func createCompany() {
        var apple = Company(name: "Apple Mobile Devices", imageUrl: "Apple Mobile Devices", stockTicker: "AAPL")
        
        let appleIPhone = Product(name: "Apple iPhone", imageUrl: "Apple iPhone", productURL: "https://www.apple.com/iphone/")
        let appleIPadPro = Product(name: "Apple iPad Pro", imageUrl: "Apple iPad Pro", productURL: "https://www.apple.com/ipad-pro/")
        let appleIPadTouch = Product(name: "Apple iPod Touch", imageUrl: "Apple iPod Touch", productURL: "https://www.apple.com/ipod-touch/")
        
        
        var samsung = Company(name: "Samsung Mobile Devices", imageUrl: "Samsung Mobile Devices", stockTicker: "SSNLF", products: [Product](), stockPrice: nil)
        
        let samsungGalaxyS = Product(name: "Samsung Galaxy S9", imageUrl: "Samsung Galaxy S9", productURL: "https://www.samsung.com/global/galaxy/galaxy-s9/")
        let samsungGalaxyTab = Product(name: "Samsung Galaxy Tab", imageUrl: "Samsung Galaxy Tab", productURL: "https://www.samsung.com/us/explore/tab-s4/?sem-mktg-pfs-tab-80118-22217")
        let samsungGalaxyNote = Product(name: "Samsung Galaxy Note", imageUrl: "Samsung Galaxy Note", productURL:"https://www.samsung.com/us/mobile/galaxy-note9/")
        
        var amazon = Company(name: "Amazon Mobile Devices", imageUrl: "Amazon Mobile Devices", stockTicker: "AMZN", products: [Product](), stockPrice: nil)
        
        let amazonEcho = Product(name: "Amazon Echo", imageUrl: "Amazon Echo", productURL:"https://www.amazon.com/dp/B07456BG8N?tag=googhydr-20&hvadid=%7Bcreative%7D&hvpos=%7Badposition%7D&hvnetw=%7Bnetwork%7D&hvrand=%7Brandom%7D&hvpone=%7Bparam1%7D&hvptwo=%7Bparam2%7D&hvqmt=%7Bmatchtype%7D&hvdev=%7Bdevice%7D&hvdvcmdl=%7Bdevicemodel%7D&hvlocint=%7Bloc_interest_ms%7D&hvlocphy=%7Bloc_physical_ms%7D&hvtargid=%7Btargetid%7D&ref=pd_sl_3g07419rwu_e")
        let amazonFireHD = Product(name: "Amazon Fire HD", imageUrl: "Amazon Fire HD", productURL:"https://www.amazon.com/dp/B01J6RPGKG")
        let amazonEchoDot = Product(name: "Amazon Echo Dot", imageUrl: "Amazon Echo Dot", productURL:"https://www.amazon.com/gp/product/B01DFKC2SO?ref=ODS_HA_B_surl&tag=googhydr-20&hvadid=243971412886&hvpos=1t1&hvnetw=g&hvrand=11251785959057900677&hvpone=&hvptwo=&hvqmt=b&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9067609&hvtargid=kwd-330765436234&ref=pd_sl_5dhcl9gqwz_e")
        
        
        var microsoft = Company(name: "Microsoft Mobile Devices", imageUrl: "Microsoft Mobile Devices", stockTicker: "MSFT", products: [Product](), stockPrice: nil)
        
        let microsoftNokiaLumia = Product(name: "Microsoft Nokia Lumia", imageUrl: "Microsoft Nokia Lumia", productURL:"https://www.microsoft.com/en-ww/mobile/phones/lumia")
        let windowsPhone = Product(name: "Windows Phone 8", imageUrl: "Windows Phone 8", productURL:"https://www.microsoft.com/en-us/store/b/mobile")
        let windowsSurface = Product(name: "Windows Surface", imageUrl: "Windows Surface", productURL:"https://www.microsoft.com/en-us/store/b/surface?invsrc=search&cl_vend=google&cl_ch=sem&cl_camp=907269320&cl_adg=47974157511&cl_crtv=284450611193&cl_kw=+surface&cl_pub=google.com&cl_place=&cl_dvt=c&cl_pos=1t1&cl_mt=b&cl_gtid=kwd-488544306872&cl_pltr=&cl_dim0=W5brhAAAAYkj87pa:20180910220908:s&OCID=AID695933_SEM_W5brhAAAAYkj87pa:20180910220908:s&s_kwcid=AL!4249!3!284450611193!b!!g!!%2Bsurface&ef_id=W5brhAAAAYkj87pa:20180910220908:s")
        
        
        apple.products?.append(appleIPhone)
        apple.products?.append(appleIPadPro)
        apple.products?.append(appleIPadTouch)
        
        samsung.products?.append(samsungGalaxyS)
        samsung.products?.append(samsungGalaxyTab)
        samsung.products?.append(samsungGalaxyNote)
        
        amazon.products?.append(amazonEcho)
        amazon.products?.append(amazonFireHD)
        amazon.products?.append(amazonEchoDot)
        
        microsoft.products?.append(microsoftNokiaLumia)
        microsoft.products?.append(windowsPhone)
        microsoft.products?.append(windowsSurface)
        
        
        
//        companies.append(apple)
//        companies.append(samsung)
//        companies.append(amazon)
//        companies.append(microsoft)
        
    }
    
    
    
}

