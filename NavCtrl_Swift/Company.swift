//
//  CompanyModel.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 10/1/18.
//  Copyright © 2018 turntotech. All rights reserved.
//

import Foundation

struct Company {
    
    var name: String
    var imageUrl: String
    var stockTicker: String
    var products: [Product]
    var stockPrice: Stock?
    
}
