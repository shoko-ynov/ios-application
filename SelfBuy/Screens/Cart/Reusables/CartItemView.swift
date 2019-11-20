//
//  CartItemView.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class CartItemView: UIView {

    private lazy var title: UILabel = {
        let label = UILabel()
        label.tintColor = .black
        //label.font = UIFont(name: <#T##String#>, size: <#T##CGFloat#>)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        applyShadow()
        applyCornerRadius()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CartItemViewModelling) {
        
    }

}
