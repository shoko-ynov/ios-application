//
//  CartCellView.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 23/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class CartCellView: UICollectionViewCell, ReusableView {
    
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
    
    func configure(with setupModel: CartCellViewModelling) {
        self.itemTitle.text = setupModel.cartItem.product.name
    }
    
}
