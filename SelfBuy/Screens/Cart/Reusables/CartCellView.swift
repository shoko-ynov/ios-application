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
        label.tintColor = .black
        label.setToBold(size: 16)
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(itemTitle)
        
        itemTitle.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: self.trailingAnchor,
            padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
