//
//  OrdersViewController.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 30/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit


class OrdersViewController: UIViewController {
    
    override func loadView() {
         super.loadView()
        
        _ = setTitleLabel("Orders")
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = true
    }
    

}
