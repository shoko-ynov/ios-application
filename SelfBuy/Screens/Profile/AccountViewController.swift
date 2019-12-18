//
//  AccountViewController.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 30/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    override func loadView() {
         super.loadView()
        

//        setHeaderImage()
        self.view.isOpaque = false
        self.view.alpha = 0.75
        let blurEffect = UIBlurEffect(style: .light)

        let blur = UIVisualEffectView(effect: blurEffect)
        blur.frame = self.view.bounds
        self.view.addSubview(blur)

        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = true


//        let profileTitle = UILabel()
//        profileTitle.text = "Title"
//        profileTitle.setToLight(size: 15.0)
//
//        profileTitle.anchor(
//            top: self.view.topAnchor,
//            leading: self.view.leadingAnchor,
//            bottom: nil,
//            trailing: self.view.trailingAnchor,
//            padding: .init(top: 200, left: 0, bottom: 0, right: 30)
//        )
        
        let profileLine = InfoLine(text: "Account")
        _ = setTitleLabel("Account")
        
        _ = "Zakarya TOLBA"
        

        self.view.addSubview(profileLine)
            profileLine.anchor(
                top: nil,
                leading: self.view.leadingAnchor,
                bottom: nil,
                trailing: self.view.trailingAnchor,
                padding: .init(top: 100, left: 0, bottom: 0, right: 0)
            )
            

    }
    
    
}
