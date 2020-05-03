//
//  ProductsRecapView.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 02/05/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

final class ShippingRecapView: UIView {
    
    let viewModel = OrderShippingViewModel()
    
    let viewTitle: UILabel = {
        let label = UILabel()
        label.text = "Livraison"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setToBold(size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let address: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setToMedium(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let postalCode: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setToMedium(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let city: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setToMedium(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let country: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "FRANCE"
        label.setToMedium(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        applyShadow()
        applyCornerRadius()
        backgroundColor = .white
        
        addSubview(viewTitle)
        addSubview(name)
        addSubview(address)
        addSubview(postalCode)
        addSubview(city)
        addSubview(country)
        
        viewTitle.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 10, left: 20, bottom: 0, right: 0)
        )
        name.anchor(
            top: viewTitle.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 10, left: 15, bottom: 0, right: 0)
        )
        address.anchor(
            top: name.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 10, left: 15, bottom: 0, right: 0)
        )
        postalCode.anchor(
            top: address.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 10, left: 15, bottom: 0, right: 0)
        )
        city.anchor(
            top: address.bottomAnchor,
            leading: postalCode.trailingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 10, left: 5, bottom: 0, right: 0)
        )
        country.anchor(
            top: postalCode.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 10, left: 15, bottom: 0, right: 0)
        )
        
        name.text = viewModel.getBehaviorSubjectValue(viewModel.firstName) + " " + viewModel.getBehaviorSubjectValue(viewModel.lastName).uppercased()
        
        address.text = viewModel.getBehaviorSubjectValue(viewModel.address)
        
        postalCode.text = viewModel.getBehaviorSubjectValue(viewModel.postalCode)
        city.text = viewModel.getBehaviorSubjectValue(viewModel.city)
    }
}
