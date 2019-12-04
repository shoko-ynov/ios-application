//
//  AboutUsViewController.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 30/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    override func loadView() {
        super.loadView()
  
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: nil, action: nil)
        
//        let backBTN = UIBarButtonItem(image: UIImage(named: "arrow_right.png"),
//                                      style: .plain,
//                                      target: navigationController,
//                                      action: #selector(UINavigationController.popViewController(animated:)))
//
//        navigationController?.navigationItem.leftBarButtonItem = backBTN
    }
}
