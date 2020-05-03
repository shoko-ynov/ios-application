//
//  PaymentSuccessView.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 03/05/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

class PaymentSuccessView: UIView {

    let successImage: UIImageView = {
        let image = UIImage(named: "payment_success")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    let successLabel: UILabel = {
        let label = UILabel()
        label.text = "Votre commande a été effectuée avec succès !"
        label.setToBold(size: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(successImage)
        addSubview(successLabel)
        backgroundColor = .lightGray
        
        successImage.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 25, left: 15, bottom: 0, right: 15),
            size: .init(width: 0, height: 250)
        )
        
        successLabel.anchor(
            top: successImage.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 15, left: 30, bottom: 0, right: 30)
        )
    }

}
