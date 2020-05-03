//
//  OrderShippingView.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 26/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

final class OrderShippingView: UIView {
    
    var viewModel: OrderShippingViewModelling
    
    var swipeToNextPage = {}
    
    let shippingAddressTitle: UILabel = {
        let label = UILabel()
        label.text = "Adresse de livraison"
        label.setToBold(size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let shippingMethodTitle: UILabel = {
        let label = UILabel()
        label.text = "Mode de livraison"
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
    
    var lastNameTextField: UITextField = {
        let input = UITextField()
        input.placeholder = " Nom *"
        input.backgroundColor = .darkGray
        input.layer.cornerRadius = 15
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.tintColor = .primary
        input.font = UIFont.systemFont(ofSize: 15)
        input.textColor = .black
        return input
    }()
    
    var firstNameTextField: UITextField = {
        let input = UITextField()
        input.placeholder = " Prénom *"
        input.backgroundColor = .darkGray
        input.layer.cornerRadius = 15
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.tintColor = .primary
        input.font = UIFont.systemFont(ofSize: 15)
        input.textColor = .black
        return input
    }()
    
    var addressTextField: UITextField = {
        let input = UITextField()
        input.placeholder = " Adresse postale *"
        input.backgroundColor = .darkGray
        input.layer.cornerRadius = 15
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.tintColor = .primary
        input.font = UIFont.systemFont(ofSize: 15)
        input.textColor = .black
        return input
    }()
    
    var addressAdditionTextField: UITextField = {
        let input = UITextField()
        input.placeholder = " Complément d'adresse"
        input.backgroundColor = .darkGray
        input.layer.cornerRadius = 15
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.tintColor = .primary
        input.font = UIFont.systemFont(ofSize: 15)
        input.textColor = .black
        return input
    }()
    
    var postalCodeTextField: UITextField = {
        let input = UITextField()
        input.placeholder = " Code postal *"
        input.backgroundColor = .darkGray
        input.layer.cornerRadius = 15
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.tintColor = .primary
        input.font = UIFont.systemFont(ofSize: 15)
        input.textColor = .black
        return input
    }()
    
    var cityTextField: UITextField = {
        let input = UITextField()
        input.placeholder = " Ville *"
        input.backgroundColor = .darkGray
        input.layer.cornerRadius = 15
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.tintColor = .primary
        input.font = UIFont.systemFont(ofSize: 15)
        input.textColor = .black
        return input
    }()

    private var validateShippingButton = SolidButton(text: "Accéder au paiement")
    
    init(viewModel: OrderShippingViewModelling) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        bind()
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
        
        
        let genders = ["Madame", "Monsieur"]
        let genderSC = UISegmentedControl(items: genders)
        genderSC.selectedSegmentIndex = 0
        
        scrollView.addSubview(genderSC)
        genderSC.anchor(
            top: scrollView.topAnchor,
            leading: scrollView.trailingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 30, left: 0, bottom: 0, right: 0)
        )
        
        
        scrollView.addSubview(lastNameTextField)
        lastNameTextField.anchor(
            top: genderSC.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 30, left: 20, bottom: 0, right: 20)
        )
        
        scrollView.addSubview(firstNameTextField)
        firstNameTextField.anchor(
            top: lastNameTextField.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 30, left: 20, bottom: 0, right: 20)
        )
        
        scrollView.addSubview(addressTextField)
        addressTextField.anchor(
            top: firstNameTextField.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 30, left: 20, bottom: 0, right: 20)
        )
        
        scrollView.addSubview(addressAdditionTextField)
        addressAdditionTextField.anchor(
            top: addressTextField.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 30, left: 20, bottom: 0, right: 20)
        )
        
        scrollView.addSubview(postalCodeTextField)
        postalCodeTextField.anchor(
            top: addressAdditionTextField.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 30, left: 20, bottom: 0, right: 20)
        )
        
        scrollView.addSubview(cityTextField)
        cityTextField.anchor(
            top: postalCodeTextField.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 30, left: 20, bottom: 0, right: 20)
        )
        
        scrollView.addSubview(shippingMethodTitle)
        shippingMethodTitle.anchor(
            top: cityTextField.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 30, left: 20, bottom: 0, right: 20)
        )
        
        
        let shippingMethodsItems = ["Éco", "Standard", "Express"]
        let shippingMethodSC = UISegmentedControl(items: shippingMethodsItems)
        shippingMethodSC.selectedSegmentIndex = 0
        
        scrollView.addSubview(shippingMethodSC)
        shippingMethodSC.anchor(
            top: shippingMethodTitle.bottomAnchor,
            leading: scrollView.trailingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 30, left: 0, bottom: 0, right: 0)
        )
        
        scrollView.addSubview(validateShippingButton)
        validateShippingButton.anchor(
            top: shippingMethodSC.bottomAnchor,
            bottom: scrollView.bottomAnchor,
            centerAnchor: scrollView.centerXAnchor,
            padding: .init(top: 30, left: 0, bottom: 30, right: 0)
        )
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            genderSC.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            shippingMethodSC.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            validateShippingButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
    }
    
    func bind() {
        
        validateShippingButton.rx.tap.bind { [weak self] _ in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.swipeToNextPage()
            }
        }.disposed(by: self.viewModel.bag)
        
        lastNameTextField.rx
            .text
            .skip(1)
            .map({ $0.unsafelyUnwrapped })
            .asObservable()
            .bind(to: viewModel.lastName)
            .disposed(by: viewModel.bag)
        
        lastNameTextField.text = viewModel.getBehaviorSubjectValue(viewModel.lastName)
        
        firstNameTextField.rx
            .text
            .skip(1)
            .map({ $0.unsafelyUnwrapped })
            .asObservable()
            .bind(to: viewModel.firstName)
            .disposed(by: viewModel.bag)
        
        firstNameTextField.text = viewModel.getBehaviorSubjectValue(viewModel.firstName)
        
        addressTextField.rx
            .text
            .skip(1)
            .map({ $0.unsafelyUnwrapped })
            .asObservable()
            .bind(to: viewModel.address)
            .disposed(by: viewModel.bag)
        
        addressTextField.text = viewModel.getBehaviorSubjectValue(viewModel.address)
        
        postalCodeTextField.rx
            .text
            .skip(1)
            .map({ $0.unsafelyUnwrapped })
            .asObservable()
            .bind(to: viewModel.postalCode)
            .disposed(by: viewModel.bag)
        
        postalCodeTextField.text = viewModel.getBehaviorSubjectValue(viewModel.postalCode)
        
        cityTextField.rx
            .text
            .skip(1)
            .map({ $0.unsafelyUnwrapped })
            .asObservable()
            .bind(to: viewModel.city)
            .disposed(by: viewModel.bag)
        
        cityTextField.text = viewModel.getBehaviorSubjectValue(viewModel.city)
    }
    
    @objc func dismissKeyboard() {
        endEditing(true)
    }
}

