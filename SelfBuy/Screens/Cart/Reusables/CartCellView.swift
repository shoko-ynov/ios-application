//
//  CartCellView.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 23/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class CartCellView: UICollectionViewCell, ReusableView {
    
    private let itemNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setToBold(size: 20)
        label.numberOfLines = 3
        
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setToBold(size: 18)
        
        return label
    }()
    
    private let productFirstImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private var quantityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.setToMedium(size: 15)
        
        return label
    }()
    
    var quantity: Int
    
    private let deletableView = DeletableItemView()
    
    private var viewModel: CartCellViewModelling?
    
    override init(frame: CGRect) {
        self.quantity = 0
        
        super.init(frame: frame)
        
        addSubview(deletableView)
        
        deletableView.container.addSubview(itemNameLabel)
        deletableView.container.addSubview(priceLabel)
        deletableView.container.addSubview(productFirstImage)
        deletableView.container.addSubview(quantityLabel)
        
        deletableView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor
        )
        
        productFirstImage.anchor(
            top: deletableView.container.topAnchor,
            leading: deletableView.container.leadingAnchor,
            bottom: deletableView.container.bottomAnchor,
            trailing: nil,
            padding: .init(top: 20, left: 10, bottom: 20, right: 0)
        )
        productFirstImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        itemNameLabel.anchor(
            top: deletableView.container.topAnchor,
            leading: productFirstImage.trailingAnchor,
            bottom: nil,
            trailing: deletableView.container.trailingAnchor,
            padding: UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 20)
        )
        
        priceLabel.anchor(
            top: itemNameLabel.bottomAnchor,
            leading: nil,
            bottom: nil,
            trailing: deletableView.container.trailingAnchor,
            padding: .init(top: 10, left: 0, bottom: 0, right: 20)
        )
        
        quantityLabel.anchor(
            top: itemNameLabel.bottomAnchor,
            leading: productFirstImage.trailingAnchor,
            bottom: nil,
            trailing: deletableView.container.trailingAnchor,
            padding: .init(top: 10, left: 10, bottom: 0, right: 190)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with setupModel: CartCellViewModelling) {
        viewModel = setupModel
                
        let price = String(format: "%.2f", setupModel.cartItem.product.price * Float(setupModel.cartItem.quantity))
        
        itemNameLabel.text = setupModel.cartItem.product.name
        priceLabel.text = "\(price) €"
        quantityLabel.text = "x\(setupModel.cartItem.quantity)"
        
        if (setupModel.cartItem.product.images.count > 0) {
            let url = URL(string: setupModel.cartItem.product.images.first!)
            
            if let safeUrl = url {
                productFirstImage.load(url: safeUrl)
            }
        }
        
        deletableView.deleteFunction = { [weak self] in
            guard let strongSelf = self, let viewModel = strongSelf.viewModel else { return }
            viewModel.deleteProductFromCart()
        }
    }
}
