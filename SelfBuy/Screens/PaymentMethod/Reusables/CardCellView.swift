//
//  CardCollectionViewCell.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 18/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

final class CardCellView: UICollectionViewCell, ReusableView {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.setToMedium(size: 13)
        
        return label
    }()
    
    private let cardNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.setToMedium(size: 13)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        applyShadow()
        applyCornerRadius()
        
        self.addSubview(cardNumberLabel)
        
        cardNumberLabel.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: self.trailingAnchor,
            padding: .init(top: 8, left: 8, bottom: 0, right: 8)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CardCellViewModelling) {
        cardNumberLabel.text = "**** **** **** \(viewModel.card.last4)"
    }
}
