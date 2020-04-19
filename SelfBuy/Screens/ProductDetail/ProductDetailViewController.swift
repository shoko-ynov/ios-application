//
//  ProductDetailViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 30/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    let viewModel: ProductDetailViewModelling
    
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
    
    private var pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    
    private var nbPicker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    private var addCartBtn: UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 18
        button.layer.borderColor = UIColor.primary.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(.primary, for: .normal)
        button.titleLabel?.setToBold(size: 14)
        button.setTitle("Ajouter Au Panier", for: .normal)
        
        return button
    }()
    
    private func setupView() {
        view.addSubview(productFirstImage)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(priceLabel)
        view.addSubview(nbPicker)
        view.addSubview(addCartBtn)
        
        productFirstImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 200))
        
        titleLabel.anchor(top: productFirstImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 25, left: 50, bottom: 0, right: 0) )
        titleLabel.text = viewModel.product.name
        
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor , bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 25, left: 50, bottom: 0, right: 50))
        descriptionLabel.text = viewModel.product.description
        
        priceLabel.anchor(top: descriptionLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 35, left: 50, bottom: 0, right: 0))
        priceLabel.text = "\(viewModel.product.price) €"
        
        nbPicker.anchor(top: priceLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        addCartBtn.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 110, bottom: 200, right: 110))
        
        addCartBtn.rx
            .tap
            .bind { [weak self] in
                guard let strongSelf = self else { return }
                CartItemRepository.shared.addProductToCart(product: strongSelf.viewModel.product, quantity: 1)
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
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        nbPicker.dataSource = self
        nbPicker.delegate = self
        
        view.backgroundColor = .lightGray
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
}
