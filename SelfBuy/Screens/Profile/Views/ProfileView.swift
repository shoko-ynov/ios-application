//
//  ProfileView.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class ProfileView: UIView {


    var controller:ProfileViewController?
    
     let usernameLabel: UILabel = {
          let label = UILabel()
          label.text = "test"
          label.font = UIFont(name: "Helvetica", size: 22)
          label.textColor = .white
          return label
     }()
    
    func setupLayout(){
        addSubview(usernameLabel)
    }
    
}



