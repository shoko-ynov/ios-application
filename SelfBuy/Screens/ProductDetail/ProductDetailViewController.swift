//
//  ProductDetailViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 30/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class ProductDetailViewController: PresentableViewController, UITextFieldDelegate {
    
    let viewModel: ProductDetailViewModelling
    
    var quantity: Int
    
    private var productFirstImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setToBold(size: 30)
        label.numberOfLines = 2
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 5
        
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setToBold(size: 35)
        
        return label
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
    
    private var addCartBtn = GhostButton(text: "Ajouter Au Panier")
    
    private func setupView() {
        view.addSubview(productFirstImage)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(priceLabel)
        view.addSubview(nbPicker)
        view.addSubview(addCartBtn)
        view.addSubview(quantityInput)
        view.addSubview(quantityLabel)
        
        productFirstImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        productFirstImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        titleLabel.anchor(top: productFirstImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 25, left: 50, bottom: 0, right: 0) )
        titleLabel.text = viewModel.product.name
        
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor , bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 25, left: 50, bottom: 0, right: 50))
        descriptionLabel.text = viewModel.product.description
        
        priceLabel.anchor(top: descriptionLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 35, left: 50, bottom: 0, right: 0))
        priceLabel.text = "\(viewModel.product.price) €"
        
        nbPicker.anchor(top: priceLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        addCartBtn.anchor(
            top: priceLabel.bottomAnchor,
            bottom: nil,
            centerAnchor: view.centerXAnchor,
            padding: .init(top: 25, left: 0, bottom: 0, right: 0)
        )
        
        quantityLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 120, bottom: 190, right: 0))
        
        quantityInput.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 205, bottom: 188, right: 0))
        
        addCartBtn.rx
            .tap
            .bind { [weak self] in
                guard let strongSelf = self else { return }
                CartItemRepository.shared.addProductToCart(product: strongSelf.viewModel.product, quantity: strongSelf.quantity)
        }.disposed(by: viewModel.bag)
        
        if (viewModel.product.images.count > 0) {
            let url = URL(string: viewModel.product.images.first!)
            
            if let safeUrl = url {
                self.productFirstImage.load(url: safeUrl)
            }
        }
    }
    
    init(viewModel: ProductDetailViewModelling) {
        self.viewModel = viewModel
        self.quantity = 1
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        dismissPickerView()
        
        nbPicker.dataSource = self
        nbPicker.delegate = self
        quantityInput.delegate = self
        
        quantityInput.inputView = nbPicker
        
        view.backgroundColor = .lightGray
    }
}


extension ProductDetailViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
        
        let button = UIBarButtonItem(title: "Valider", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        quantityInput.inputAccessoryView = toolBar
    }
    
    @objc func action() {
       view.endEditing(true)
    }
}
