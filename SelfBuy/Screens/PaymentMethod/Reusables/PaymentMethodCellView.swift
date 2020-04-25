//
//  CardCollectionViewCell.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 18/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

final class PaymentMethodCellView: UICollectionViewCell, ReusableView {
    
    private let cardNameLabel: UILabel = {
        let label = UILabel()
        label.setToMedium(size: 13)
        
        return label
    }()
    
    private let cardNumberLabel: UILabel = {
        let label = UILabel()
        label.setToMedium(size: 18)
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setToMedium(size: 15)
        
        return label
    }()
    
    private let expireTextLabel : UILabel = {
        let label = UILabel()
        label.setToLight(size: 11)
        label.text = "Expire le : "
        label.textColor = .gray
        
        return label
    }()
    
    private let expireDateLabel : UILabel = {
        let label = UILabel()
        label.setToMedium(size: 12)
        
        return label
    }()
    
    private let defaultCardLabel: UILabel = {
        let label = UILabel()
        label.setToLight(size: 11)
        label.text = "(Défaut)"
        label.textColor = .gray
        label.isHidden = true
        
        return label
    }()
    
    private let brandCardImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        applyShadow()
        applyCornerRadius()
        backgroundColor = .white
        
        self.addSubview(cardNumberLabel)
        self.addSubview(cardNameLabel)
        self.addSubview(expireTextLabel)
        self.addSubview(expireDateLabel)
        self.addSubview(titleLabel)
        self.addSubview(defaultCardLabel)
        self.addSubview(brandCardImage)
        
        titleLabel.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 20, left: 20, bottom: 0, right: 0)
        )
        
        defaultCardLabel.anchor(
            top: titleLabel.topAnchor,
            leading: titleLabel.trailingAnchor,
            bottom: titleLabel.bottomAnchor,
            trailing: nil,
            padding: .init(top: 0, left: 15, bottom: 0, right: 0)
        )
        
        brandCardImage.anchor(
            top: titleLabel.topAnchor,
            leading: nil,
            bottom: titleLabel.bottomAnchor,
            trailing: self.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 20),
            size: .init(width: 60, height: 37)
        )
        
        cardNumberLabel.anchor(
            top: titleLabel.bottomAnchor,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: self.trailingAnchor,
            padding: .init(top: 15, left: 20, bottom: 0, right: 20)
        )
        
        cardNameLabel.anchor(
            top: cardNumberLabel.bottomAnchor,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: self.trailingAnchor,
            padding: .init(top: 15, left: 20, bottom: 0, right: 20)
        )
        
        expireTextLabel.anchor(
            top: cardNameLabel.bottomAnchor,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 15, left: 20, bottom: 0, right: 0)
        )
        
        expireDateLabel.anchor(
            top: expireTextLabel.topAnchor,
            leading: expireTextLabel.trailingAnchor,
            bottom: expireTextLabel.bottomAnchor,
            trailing: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CardCellViewModelling, index: IndexPath) {
        cardNumberLabel.text = "**** **** **** \(viewModel.card.last4)"
        cardNameLabel.text = viewModel.card.name
        titleLabel.text = "Carte n°\(index.row + 1)"
        expireDateLabel.text = "\(viewModel.card.expMonth)/\(viewModel.card.expYear)"
        defaultCardLabel.isHidden = !viewModel.card.isDefaultCard
        
        switch viewModel.card.brand {
        case "Visa":
            brandCardImage.image = UIImage(named: "visa")
            break
        case "MasterCard":
            brandCardImage.image = UIImage(named: "mastercard")
            break
        case "American Express":
            brandCardImage.image = UIImage(named: "amex")
            break
        default:
            break
        }
    }
}
