//
//  ProductDetailViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 30/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    let viewModel: ProductCellViewModelling
    
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
    
    private func setupView() {
        view.addSubview(productFirstImage)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(priceLabel)
        
        productFirstImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 200))
        
        titleLabel.anchor(top: productFirstImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 25, left: 50, bottom: 0, right: 0) )
        titleLabel.text = viewModel.product.name
        
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor , bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 25, left: 50, bottom: 0, right: 50))
        descriptionLabel.text = viewModel.product.description
        
        priceLabel.anchor(top: descriptionLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 35, left: 50, bottom: 0, right: 0))
        priceLabel.text = "\(viewModel.product.price) €"
        
        if (viewModel.product.images.count > 0) {
            let url = URL(string: viewModel.product.images.first!)
            
            if let safeUrl = url {
                self.productFirstImage.load(url: safeUrl)
            }
        }
    }
    
    init(viewModel: ProductCellViewModelling) {
        self.viewModel = viewModel
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
