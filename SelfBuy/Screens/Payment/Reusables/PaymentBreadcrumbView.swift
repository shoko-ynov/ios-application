//
//  PaymentBreadcrumbView.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 26/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

final class PaymentBreadcrumbView: UIView {
    
    let viewModel: PaymentBreadcrumbViewModelling
    
    let shippingStep = BreadcrumbStepView(imageName: "wallet")
    let orderStep = BreadcrumbStepView(imageName: "order")
    let finalStep = BreadcrumbStepView(imageName: "final_step")
    
    let separator1 = UIView()
    let separator2 = UIView()
    
    init(viewModel: PaymentBreadcrumbViewModelling) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        setupView()
        
        self.viewModel.index.subscribe(onNext: { [weak self] index in
            guard let strongSelf = self else { return }
            
            if (index.row == 0) {
                strongSelf.shippingStep.enableStep()
                strongSelf.disbaleLiveSeparator(strongSelf.separator1)
                strongSelf.orderStep.disableStep()
                strongSelf.disbaleLiveSeparator(strongSelf.separator2)
                strongSelf.finalStep.disableStep()
            }
            
            if (index.row == 1) {
                strongSelf.shippingStep.enableStep()
                strongSelf.enableLiveSeparator(strongSelf.separator1)
                strongSelf.orderStep.enableStep()
                strongSelf.disbaleLiveSeparator(strongSelf.separator2)
                strongSelf.finalStep.disableStep()
            }
            
            if (index.row == 2) {
                strongSelf.shippingStep.enableStep()
                strongSelf.enableLiveSeparator(strongSelf.separator1)
                strongSelf.orderStep.enableStep()
                strongSelf.enableLiveSeparator(strongSelf.separator2)
                strongSelf.finalStep.enableStep()
            }
        }).disposed(by: viewModel.bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        applyShadow()
        applyCornerRadius()
        backgroundColor = .lightGray
        
        addSubview(shippingStep)
        addSubview(separator1)
        addSubview(orderStep)
        addSubview(separator2)
        addSubview(finalStep)
        
        shippingStep.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: nil,
            padding: .init(top: 15, left: 35, bottom: 15, right: 0)
        )
        
        orderStep.anchor(
            top: topAnchor,
            leading: nil,
            bottom: bottomAnchor,
            trailing: nil,
            padding: .init(top: 15, left: 0, bottom: 15, right: 0)
        )
        orderStep.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        finalStep.anchor(
            top: topAnchor,
            leading: nil,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 15, left: 0, bottom: 15, right: 35)
        )
        
        separator1.backgroundColor = .darkGray
        separator2.backgroundColor = .darkGray
        
        NSLayoutConstraint.activate([
            separator1.centerYAnchor.constraint(equalTo: centerYAnchor),
            separator2.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        separator1.anchor(
            top: nil,
            leading: shippingStep.trailingAnchor,
            bottom: nil,
            trailing: orderStep.leadingAnchor,
            size: .init(width: 0, height: 2)
        )
        
        separator2.anchor(
            top: nil,
            leading: orderStep.trailingAnchor,
            bottom: nil,
            trailing: finalStep.leadingAnchor,
            size: .init(width: 0, height: 2)
        )
    }
    
    func enableLiveSeparator(_ line: UIView) {
        UIView.animate(withDuration: 0.25) {
            line.backgroundColor = .primary
        }
    }
    
    func disbaleLiveSeparator(_ line: UIView) {
        UIView.animate(withDuration: 0.25) {
            line.backgroundColor = .darkGray
        }
    }
    
}
