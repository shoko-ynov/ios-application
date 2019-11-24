//
//  ProductCellView.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 23/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class ProductCellView: UICollectionViewCell, ReusableView {
    
    private lazy var productCategoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.setToMedium(size: 12)
        
        return label
    }()
    
    private lazy var productNameLabel: UITextField = {
        let label = UITextField()
        label.textColor = .black
        label.setToMedium(size: 15)
        label.contentVerticalAlignment = .top
        
        return label
    }()
    
    private lazy var productFirstImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setToMedium(size: 13)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        applyShadow()
        applyCornerRadius()
        
        contentView.addSubview(productCategoryLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productFirstImage)
        contentView.addSubview(productPriceLabel)
        
        let padding = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        let spacing = 8
        
        productCategoryLabel.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: nil,
            trailing: contentView.trailingAnchor,
            padding: .init(top: padding.top, left: padding.left, bottom: 0, right: padding.right))
        productNameLabel.anchor(
            top: productCategoryLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            bottom: nil,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 0, left: padding.left, bottom: 0, right: padding.right),
            size: .init(width: contentView.frame.width - padding.left - padding.right, height: productNameLabel.font!.lineHeight * 3))
        productFirstImage.anchor(
            top: productNameLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            bottom: nil,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 8, left: 0, bottom: 0, right: 0),
            size: .init(width: contentView.frame.width, height: 110))
        productPriceLabel.anchor(
            top: nil,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 0, left: padding.left, bottom: padding.bottom, right: padding.right))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: ProductCellViewModelling) {
        productNameLabel.text = viewModel.product.name
        
        if let category = viewModel.product.category {
            productCategoryLabel.text = "- \(category.uppercased())"
        } else {
            productCategoryLabel.text = " "
        }
        
        if (viewModel.product.images.count > 0) {
            let url = URL(string: viewModel.product.images.first!)
            
            if let safeUrl = url {
                self.productFirstImage.load(url: safeUrl)
            }
        }
        
        productPriceLabel.text = "\(viewModel.product.price)€"
    }
    
}
