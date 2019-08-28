//
//  CompanyAddOn.swift
//  NavCtrl_Swift
//
//  Created by Kristina Neuwirth on 1/8/19.
//  Copyright © 2019 turntotech. All rights reserved.
//

import UIKit


class CompanyAddOn: UIView {
    
    @IBOutlet weak var companyBrandTitle: UILabel!
    @IBOutlet weak var companyView: UIView!
    @IBOutlet weak var addProductPressed: UIButton!
    @IBOutlet weak var productAddition: UILabel!
    @IBOutlet weak var brandImage: UIImageView!
 
    var companiesObject : CoreCompany?
    let dao = DAO.share
    
    override func awakeFromNib() {
        
    }
        
    func mainSet(){
        if let currentCompany = companiesObject {
            
            if let url = URL(string: currentCompany.imageUrl ?? "") {
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    brandImage.image = image
                }
            } else {
                if  currentCompany.imageUrl == "" {
                brandImage.image = UIImage(named: "Question Mark")
                } else {
                    brandImage.image = UIImage(named: currentCompany.imageUrl ?? "")
                }
            
            }
            
        }
        
    }

}







