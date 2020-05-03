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
    
    var viewModel: OrderConfirmationViewModelling
    
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
    
    
    private var validateShippingButton = SolidButton(text: "Confirmer la commande")
    
    init(viewModel: OrderConfirmationViewModelling) {
        self.viewModel = viewModel
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
        
        cartRecapView.anchor(
            top: shippingAddressTitle.bottomAnchor,
            bottom: nil,
            centerAnchor: scrollView.centerXAnchor,
            padding: .init(top: 10, left: 10, bottom: 10, right: 10),
            size: .init(width: 0, height: 400)
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
            bottom: scrollView.bottomAnchor,
            centerAnchor: scrollView.centerXAnchor,
            padding: .init(top: 25, left: 0, bottom: 0, right: 0)
        )
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        addGestureRecognizer(tap)
        
        validateShippingButton.rx.tap.bind { [weak self] _ in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.viewModel.payOrder()
            }
        }.disposed(by: viewModel.bag)
    }
}


