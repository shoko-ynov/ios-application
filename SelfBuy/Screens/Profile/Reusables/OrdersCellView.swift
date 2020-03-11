//
//  OrdersCellView.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 10/01/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

class OrdersCellView: UICollectionViewCell, ReusableView {
    
    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setToBold(size: 16)
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(itemTitle)
        
        itemTitle.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: nil,
            trailing: contentView.trailingAnchor,
            padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0)
        )
        
        backgroundColor = .white
        applyShadow()
        applyCornerRadius()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with setupModel: OrdersCellViewModelling) {
        self.itemTitle.text = setupModel.cartItem.product.name
    }
    
}
