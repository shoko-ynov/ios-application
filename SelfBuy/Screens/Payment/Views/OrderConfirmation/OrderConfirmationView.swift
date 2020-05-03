//
//  OrderRecapView.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 26/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

final class OrderConfirmationView: UIView {
    
//    var viewModel: OrderShippingViewModelling
    
    var swipeToNextPage = {}
    
    let cartRecapView = CartRecapView(viewModel: CartRecapViewModel())
    let ordersRecapView = ShippingRecapView()
    
    let shippingAddressTitle: UILabel = {
        let label = UILabel()
        label.text = "Récapitulatif de la commande"
        label.setToBold(size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private var validateShippingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primary
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 0
        button.setTitle("Confirmer la commande", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        button.contentEdgeInsets = UIEdgeInsets(top: 18,left: 20,bottom: 18,right: 20)
        
        return button
    }()
    
    init(viewModel: OrderShippingViewModelling) {
//        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        addSubview(scrollView)
        scrollView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 15, left: 0, bottom: 0, right: 0)
        )
        
        scrollView.contentSize = CGSize(width: 0, height: 700)
        scrollView.alwaysBounceVertical = true
        scrollView.contentInset = UIEdgeInsets.zero

        scrollView.addSubview(cartRecapView)
        scrollView.addSubview(ordersRecapView)
        scrollView.addSubview(validateShippingButton)
        scrollView.addSubview(shippingAddressTitle)
        
        shippingAddressTitle.anchor(
            top: scrollView.topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
        
        cartRecapView.anchor(
            top: shippingAddressTitle.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 10, left: 0, bottom: 0, right: 0)
        )
        
        ordersRecapView.anchor(
            top: cartRecapView.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        
        validateShippingButton.anchor(
            top: ordersRecapView.bottomAnchor,
            leading: nil,
            bottom: scrollView.bottomAnchor,
            trailing: nil,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        
        
        NSLayoutConstraint.activate([
            cartRecapView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            cartRecapView.heightAnchor.constraint(equalToConstant: 400),
            ordersRecapView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            ordersRecapView.heightAnchor.constraint(equalToConstant: 170),
            validateShippingButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
    }
}


