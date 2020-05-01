//
//  OrderShippingView.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 26/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

final class OrderShippingView: UIView {
    
    let shippingTitle: UILabel = {
        let label = UILabel()
        label.text = "Adresse de livraison"
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
        let input = UITextField(frame: CGRect(x: -10, y: 350,width:250 ,height: 30))
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
        let input = UITextField(frame: CGRect(x: -10, y: 350,width:250 ,height: 30))
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
        let input = UITextField(frame: CGRect(x: -10, y: 350,width:250 ,height: 30))
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
        let input = UITextField(frame: CGRect(x: -10, y: 350,width:250 ,height: 30))
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
        let input = UITextField(frame: CGRect(x: -10, y: 350,width:250 ,height: 30))
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
        let input = UITextField(frame: CGRect(x: -10, y: 350,width:250 ,height: 30))
        input.placeholder = " Ville *"
        input.backgroundColor = .darkGray
        input.layer.cornerRadius = 15
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.tintColor = .primary
        input.font = UIFont.systemFont(ofSize: 15)
        input.textColor = .black
        return input
    }()
    
    var countryTextField: UITextField = {
        let input = UITextField(frame: CGRect(x: -10, y: 350,width:250 ,height: 30))
        input.placeholder = " Pays *"
        input.backgroundColor = .darkGray
        input.layer.cornerRadius = 15
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.tintColor = .primary
        input.font = UIFont.systemFont(ofSize: 15)
        input.textColor = .black
        return input
    }()
    
    var phoneTextField: UITextField = {
        let input = UITextField(frame: CGRect(x: -10, y: 350,width:250 ,height: 30))
        input.placeholder = " Numéro de téléphone *"
        input.backgroundColor = .darkGray
        input.layer.cornerRadius = 15
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.tintColor = .primary
        input.font = UIFont.systemFont(ofSize: 15)
        input.textColor = .black
        return input
    }()
    
    private var validateShippingButton: UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: 0, y: 475, width: 250, height: 50))
        button.backgroundColor = .primary
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 0
        button.setTitle("Accéder au paiement", for: .normal)
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(shippingTitle)
        shippingTitle.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 25, left: 20, bottom: 0, right: 0)
        )
        
        addSubview(scrollView)
        scrollView.anchor(
            top: shippingTitle.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor
        )
        
        //        scrollView.contentSize = CGSize(width: 0, height: self.scrollView.contentSize.height) // Uncomment to set height auto
        scrollView.contentSize = CGSize(width: 0, height: 2000) // Remove if height auto
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
        scrollView.addSubview(countryTextField)
        countryTextField.anchor(
            top: cityTextField.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 30, left: 20, bottom: 0, right: 20)
        )
        scrollView.addSubview(phoneTextField)
        phoneTextField.anchor(
            top: countryTextField.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 30, left: 20, bottom: 0, right: 20)
        )
        
        scrollView.addSubview(validateShippingButton)
        validateShippingButton.anchor(
            top: phoneTextField.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 30, left: 20, bottom: 0, right: 20)
        )
        
        NSLayoutConstraint.activate([
            genderSC.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            lastNameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            firstNameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            addressTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            addressAdditionTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            postalCodeTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            cityTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            countryTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            phoneTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
    }
    
}
