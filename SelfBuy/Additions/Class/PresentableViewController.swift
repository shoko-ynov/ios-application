//
//  PresentableViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 19/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class PresentableViewController: UIViewController {
    
    let bag: DisposeBag = DisposeBag()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .gray
        
        let icon = UIImage(
            systemName: "xmark.circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 25.0, weight: .regular, scale: .large)
        )
        
        guard let strongIcon = icon else { return button }
        button.setImage(icon, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(closeButton)
        
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
    
}
