//
//  CompanyTableViewCell.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 6/16/19.
//  Copyright © 2019 turntotech. All rights reserved.
//

import UIKit

final class CompanyTableViewCell: UITableViewCell, ReusableView {
    
  //Joel's code
  //  var onTap: (() -> Void)?
    
    private let button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        selectionStyle = .none
        
        //view code lives here
    }
    
    func setup(with company: Company) {
        textLabel?.text = company.name
        detailTextLabel?.text = company.stockPrice?.price ?? ""
    }
}
    
    // Joel's code
//    func buttonWasTapped() {
//        onTap?()
//        doShit(string: "some string")
    
//    }
//
//    private func doShit(string: String) {
//
//    }

