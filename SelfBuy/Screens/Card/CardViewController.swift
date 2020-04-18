//
//  CardViewController.swift
//  SelfBuy
//
//  Created by Léo GIGT on 25/03/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import Stripe

class CardViewController: UIViewController {
    var setupIntentClientSecret: String?

    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        cardTextField.postalCodeEntryEnabled = false
        return cardTextField
    }()
    lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = "Titulaire de la carte"
        nameTextField.borderStyle = .roundedRect
        return nameTextField
    }()
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.setTitle("Ajouter", for: .normal)
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        return button
    }()
    lazy var mandateLabel: UILabel = {
        let mandateLabel = UILabel()
        // Collect permission to reuse the customer's card:
        // See https://stripe.com/docs/strong-customer-authentication/faqs#mandates
        mandateLabel.text = "J'autorise Stripe à envoyer des instructions à l'institution financière qui a émis ma carte pour prélever des paiements sur mon compte de carte conformément aux termes de l'accord que j'ai passé avec vous."
        mandateLabel.numberOfLines = 0
        mandateLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        mandateLabel.textColor = .systemGray
        return mandateLabel
    }()
    
    let viewModel: CardViewModel
    
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [nameTextField, cardTextField, saveButton, mandateLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 2),
            view.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor, multiplier: 2),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 30),
        ])
        
        nameTextField
        .rx
        .text
        .map({ $0.unsafelyUnwrapped })
        .asObservable()
        .bind(to: viewModel.nameTextInput)
        .disposed(by: viewModel.bag)
        
        // Do any additional setup after loading the view.
    }
    
    @objc
    func save() {
        print("Saving card");
        
        let cardParams = cardTextField.cardParams
        
        viewModel.createCard(cardParams: cardParams)
    }
}
