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
    
    
    var companyList: Company?
    let dao = DAO.share
    
    override func awakeFromNib() {
        
//        addProductPressed.addTarget(self,  action: #selector(toggleAdd), for: .touchUpInside)
        
    }
        
//    @objc func toggleAdd(vc: UIViewController) {
//
//        let addProductVC = AddProductVC()
//        vc.navigationController?.pushViewController(addProductVC, animated: true)
//    }

//    func imageView(_ imageView: UIImageView, indexPath: IndexPath) {
    func mainSet(){
        if let currentCompany = companyList {
            
            if let url = URL(string: currentCompany.imageUrl) {
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    brandImage.image = image
                }
            } else {
                if  currentCompany.imageUrl == "" {
                brandImage.image = UIImage(named: "Question Mark")
                } else {
                    brandImage.image = UIImage(named: currentCompany.imageUrl)
                }
            
            }
            
        }
        
    }

}







