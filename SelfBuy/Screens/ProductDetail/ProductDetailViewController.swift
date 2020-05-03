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
    
    private var quantityInCartLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setToMedium(size: 14)
        label.textAlignment = NSTextAlignment.center
        
        return label
    }()
    
    private var quantityInput: UITextField = {
        let textField = UITextField()
        
        textField.keyboardType = .numberPad
        textField.placeholder = "1"
        textField.text = "1"
        textField.font =  UIFont.systemFont(ofSize: 32)
        
        textField.layer.cornerRadius = 5.0
        textField.backgroundColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1.00)
        
        return textField
    }()
    
    private var pickerData = [1, 2, 3, 4, 5, 6, 7, 8, 9, "10+"] as [Any]
    
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
        view.addSubview(quantityInCartLabel)
        
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
        
        quantityInput.anchor(top: descriptionLabel.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 35, left: 0, bottom: 0, right: 50))
        
        quantityInCartLabel.anchor(top: addCartBtn.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 110, bottom: 120, right: 110))
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: self.quantityInput.frame.height))
        quantityInput.leftView = paddingView
        quantityInput.leftViewMode = UITextField.ViewMode.always
        
        quantityInput.rightView = paddingView
        quantityInput.rightViewMode = UITextField.ViewMode.always
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.action))
        self.view.addGestureRecognizer(tapGesture)
        
        addCartBtn.rx
            .tap
            .bind { [weak self] in
                guard let strongSelf = self else { return }
                CartItemRepository.shared.addProductToCart(product: strongSelf.viewModel.product, quantity: strongSelf.quantity)
        }.disposed(by: viewModel.bag)
        
        CartItemRepository.shared.productsSubject.subscribe(onNext: { [weak self] _ in
            guard let strongSelf = self else { return }
            let cartItem = CartItemRepository.shared.getCartItem(product: strongSelf.viewModel.product)
            if let quantity = cartItem?.quantity {
                strongSelf.quantityInCartLabel.text = "\(quantity) dans le panier."
            }
        }).disposed(by: viewModel.bag)
        
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
        let quantitySelected = pickerData[row]
        
        if(quantitySelected is Int){
            quantity = quantitySelected as! Int
            quantityInput.text = String(quantity)
        } else {
            quantityInput.inputView = nil
            quantity = 10
            quantityInput.text = String(quantity)
        }
    }
    
    func textField(_ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
          replacementString string: String) -> Bool {
        
        let text = NSString(string: textField.text!).replacingCharacters(in: range, with: string)

        if Int(text) != nil && text != "" {
            // Text field converted to an Int
            quantity = Int(text)!
            
            if(quantity > 999){
                return false
            }
            
            if(quantity < 10){
                quantityInput.inputView = nbPicker
                nbPicker.selectRow(quantity - 1, inComponent:0, animated:true)
            } else {
                quantityInput.inputView = nil
            }
            
            return true
        }
        
        if(text == ""){
            quantityInput.inputView = nbPicker
            
            return true
        }

        return false
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
        quantityInput.resignFirstResponder()
    }
}
