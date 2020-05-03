//
//  PaymentSuccessViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 03/05/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

class PaymentSuccessViewController: PresentableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        let succesView = PaymentSuccessView()
        view.addSubview(succesView)
        
        succesView.anchor(
            top: closeButton.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 15, left: 0, bottom: 0, right: 0)
        )
    }

}
