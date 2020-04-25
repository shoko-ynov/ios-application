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
        label.setToBold(size: 16)
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
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.applyShadow()
        view.applyCornerRadius()
        
        return view
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 20
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .white
        button.isEnabled = false
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        return button
    }()
    
    private var xOrigin: CGFloat = 0
    private var viewModel: CartCellViewModelling?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(container)
        contentView.addSubview(deleteButton)
        
        deleteButton.layer.zPosition = 1
        container.layer.zPosition = 2
        
        deleteButton.anchor(
            top: nil,
            leading: nil,
            bottom: nil,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 10, left: 0, bottom: 10, right: 10)
        )
        
        deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        container.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor
        )
        
        xOrigin = container.frame.origin.x
        
        let containerLeftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        containerLeftSwipeGesture.direction = [.left]
        
        let containerRightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        containerRightSwipeGesture.direction = [.right]
        
        container.addGestureRecognizer(containerLeftSwipeGesture)
        container.addGestureRecognizer(containerRightSwipeGesture)
        
        container.addSubview(itemNameLabel)
        container.addSubview(priceLabel)
        container.addSubview(productFirstImage)
        
        productFirstImage.anchor(
            top: container.topAnchor,
            leading: container.leadingAnchor,
            bottom: container.bottomAnchor,
            trailing: nil,
            padding: .init(top: 20, left: 10, bottom: 20, right: 0)
        )
        productFirstImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        itemNameLabel.anchor(
            top: container.topAnchor,
            leading: productFirstImage.trailingAnchor,
            bottom: nil,
            trailing: container.trailingAnchor,
            padding: UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 20)
        )
        
        priceLabel.anchor(
            top: itemNameLabel.bottomAnchor,
            leading: nil,
            bottom: nil,
            trailing: container.trailingAnchor,
            padding: .init(top: 10, left: 0, bottom: 0, right: 20)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindDeleteButton() {
        guard let strongVM = viewModel else { return }
        
        strongVM.isMove.subscribe(onNext: { [weak self] isMove in
            guard let strongSelf = self else { return }
            
            if (isMove) {
                UIView.animate(withDuration: 0.25) {
                    strongSelf.container.frame = CGRect(
                        x: strongSelf.xOrigin - 60,
                        y: strongSelf.container.frame.origin.y,
                        width: strongSelf.container.frame.width,
                        height: strongSelf.container.frame.height
                    )
                }
            } else {
                UIView.animate(withDuration: 0.25) { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.container.frame = CGRect(
                        x: strongSelf.xOrigin,
                        y: strongSelf.container.frame.origin.y,
                        width: strongSelf.container.frame.width,
                        height: strongSelf.container.frame.height
                    )
                }
            }
        }).disposed(by: strongVM.bag)
        
        deleteButton.rx
            .tap
            .bind { [weak self] in
                guard let strongSelf = self, let strongVm = strongSelf.viewModel else { return }
                strongVm.deleteProductFromCart()
        }.disposed(by: strongVM.bag)
    }
    
    @objc
    func handleSwipeRight() {
        viewModel?.isMove.onNext(false)
        deleteButton.isEnabled = false
    }
    
    @objc
    func handleSwipeLeft() {
        viewModel?.isMove.onNext(true)
        deleteButton.isEnabled = true
    }
    
    func configure(with setupModel: CartCellViewModelling) {
        self.viewModel = setupModel
                
        let price = setupModel.cartItem.product.price * Float(setupModel.cartItem.quantity)
        
        itemNameLabel.text = setupModel.cartItem.product.name
        priceLabel.text = "\(price) €"
        
        if (setupModel.cartItem.product.images.count > 0) {
            let url = URL(string: setupModel.cartItem.product.images.first!)
            
            if let safeUrl = url {
                self.productFirstImage.load(url: safeUrl)
            }
        }
        self.bindDeleteButton()
        viewModel?.isMove.onNext(false)
    }
    
}
