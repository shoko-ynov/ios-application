//
//  CardViewController.swift
//  SelfBuy
//
//  Created by Léo GIGT on 25/03/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import Stripe

class AddCardViewController: PresentableViewController {
    var setupIntentClientSecret: String?
    
    private let cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        cardTextField.postalCodeEntryEnabled = false
        
        return cardTextField
    }()
    
    private let nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = "Titulaire de la carte"
        nameTextField.borderStyle = .roundedRect
        
        return nameTextField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.setTitle("Ajouter", for: .normal)
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        return button
    }()
    
    private let mandateLabel: UILabel = {
        let mandateLabel = UILabel()
        // Collect permission to reuse the customer's card:
        // See https://stripe.com/docs/strong-customer-authentication/faqs#mandates
        mandateLabel.text = "J'autorise Stripe à envoyer des instructions à l'institution financière qui a émis ma carte pour prélever des paiements sur mon compte de carte conformément aux termes de l'accord que j'ai passé avec vous."
        mandateLabel.numberOfLines = 0
        mandateLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        mandateLabel.textColor = .systemGray
        
        return mandateLabel
    }()
    
    let viewModel: AddCardViewModelling
    
    init(viewModel: AddCardViewModelling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = setTitleLabel("Ajouter une carte")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [nameTextField, cardTextField, mandateLabel, saveButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 15, left: 15, bottom: 15, right: 15)
        )
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
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
        let cardParams = cardTextField.cardParams
        
        viewModel.createCard(cardParams: cardParams) { [weak self] result in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    strongSelf.dismiss(animated: true)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
