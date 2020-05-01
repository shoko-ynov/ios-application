//
//  CartCellView.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 23/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class CartCellView: UICollectionViewCell, ReusableView, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
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
    
    private var quantityLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.text = "Quantité :"
        
        return label
    }()
    
    private var quantityInput: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.placeholder = "1"
        
        return textField
    }()
    
    private var pickerData = [1, 2, 3, 4, 5]
    
    private var nbPicker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    var quantity: Int
    
    private let deletableView = DeletableItemView()
    
    private var viewModel: CartCellViewModelling?
    
    override init(frame: CGRect) {
        self.quantity = 0
        
        super.init(frame: frame)
        
        nbPicker.dataSource = self
        nbPicker.delegate = self
        quantityInput.delegate = self
        
        quantityInput.inputView = nbPicker
        
        addSubview(deletableView)
        
        deletableView.container.addSubview(quantityLabel)
        deletableView.container.addSubview(itemNameLabel)
        deletableView.container.addSubview(priceLabel)
        deletableView.container.addSubview(productFirstImage)
        deletableView.container.addSubview(quantityInput)
        
        dismissPickerView()
        
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
            top: deletableView.container.topAnchor,
            leading: productFirstImage.trailingAnchor,
            bottom: nil,
            trailing: deletableView.container.trailingAnchor,
            padding: UIEdgeInsets(top: 110, left: 10, bottom: 0, right: 20)
        )
        
        quantityInput.anchor(
            top: deletableView.container.topAnchor,
            leading: productFirstImage.trailingAnchor,
            bottom: nil,
            trailing: deletableView.container.trailingAnchor,
            padding: UIEdgeInsets(top: 110, left: 95, bottom: 0, right: 20)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with setupModel: CartCellViewModelling) {
        viewModel = setupModel
                
        let price = setupModel.cartItem.product.price * Float(setupModel.cartItem.quantity)
        
        quantity = setupModel.cartItem.quantity
        quantityInput.text = String(quantity)
        
        itemNameLabel.text = setupModel.cartItem.product.name
        priceLabel.text = "\(price) €"
        
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerData[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        quantity = pickerData[row]
        quantityInput.text = String(quantity)
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Valider", style: .plain, target: self, action: #selector(self.action as () -> Void))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        quantityInput.inputAccessoryView = toolBar
    }
    
    func reloadPrice() {
        priceLabel.text = String(viewModel!.cartItem.product.price * Float(quantity))
    }
    
    @objc func action() {
        endEditing(true)
        reloadPrice()
    }
}
