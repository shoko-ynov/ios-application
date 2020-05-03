//
//  CartRecapCellView.swift
//  SelfBuy
//
//  Created by Zakarya Tolba on 03/05/2020
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class CartRecapCellView: UICollectionViewCell, ReusableView {
    
    private let itemNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setToBold(size: 16)
        label.numberOfLines = 3
        
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.setToMedium(size: 15)
        
        return label
    }()
    
    private let productFirstImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.applyShadow()
        view.applyCornerRadius()
        
        return view
    }()
    
    
    private var viewModel: CartCellViewModelling?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(view)
        
        view.addSubview(itemNameLabel)
        view.addSubview(priceLabel)
        view.addSubview(productFirstImage)
        
        view.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor
        )
        
        productFirstImage.anchor(
            top: view.topAnchor,
            leading: nil,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 10, left: 0, bottom: 10, right: 10)
        )
        productFirstImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        itemNameLabel.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 20)
        )
        
        priceLabel.anchor(
            top: itemNameLabel.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 5, left: 20, bottom: 0, right: 0)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with setupModel: CartCellViewModelling) {
        viewModel = setupModel
        
        let price = setupModel.cartItem.product.price * Float(setupModel.cartItem.quantity)
        
        itemNameLabel.text = setupModel.cartItem.product.name
        priceLabel.text = "\(price) €"
        
        if (setupModel.cartItem.product.images.count > 0) {
            let url = URL(string: setupModel.cartItem.product.images.first!)
            
            if let safeUrl = url {
                productFirstImage.load(url: safeUrl)
            }
        }
    }
    
}
