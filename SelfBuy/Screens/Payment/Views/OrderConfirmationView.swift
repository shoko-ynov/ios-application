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
        return scrollView
    }()
    
    
    private var validateShippingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primary
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 0
        button.setTitle("Confirmer la commande", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 20,left: 20,bottom: 20,right: 20)
        
        return button
    }()
    
    init(viewModel: OrderConfirmationViewModelling) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        addSubview(shippingAddressTitle)
        shippingAddressTitle.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 25, left: 20, bottom: 0, right: 0)
        )
        
        addSubview(scrollView)
        scrollView.anchor(
            top: shippingAddressTitle.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor
        )
        scrollView.contentSize = CGSize(width: 0, height: 100)
        scrollView.alwaysBounceVertical = true
        scrollView.contentInset = UIEdgeInsets.zero
        
    
        
        scrollView.addSubview(validateShippingButton)
        validateShippingButton.anchor(
            top: shippingAddressTitle.bottomAnchor,
            leading: nil,
            bottom: scrollView.bottomAnchor,
            trailing: nil,
            padding: .init(top: 30, left: 0, bottom: 30, right: 0)
        )
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            validateShippingButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
        
        validateShippingButton.rx.tap.bind { [weak self] _ in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.viewModel.payOrder()
            }
        }.disposed(by: viewModel.bag)
    }
}


