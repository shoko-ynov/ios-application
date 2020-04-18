//
//  PaymentMethodViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 17/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class PaymentMethodViewController: UIViewController {
    
    let bag = DisposeBag()
    
    private let closeIcon : UIImage = {
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25.0, weight: .regular, scale: .large))?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal)
        return image!
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func loadView() {
        super.loadView()
        
        _ = setTitleLabel("Moyen de paiement", textColor: UIColor.black)
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(closeButton)
        
        closeButton.setImage(closeIcon, for: .normal)
        
        closeButton.anchor(
            top: self.view.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 25, left: 0, bottom: 0, right: 20)
        )
        
        closeButton
            .rx
            .tap
            .bind { [ weak self ] in
                self?.dismiss(animated: true, completion: nil)
        }.disposed(by: bag)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
