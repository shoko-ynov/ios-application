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
    
    private let nameTextField = StyledTextField(placeholder: "Titulaire de la carte")
    
    private let saveButton = SolidButton(text: "Ajouter")
    
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
        let stackView = UIStackView(arrangedSubviews: [nameTextField, cardTextField, mandateLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        cardTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(stackView)
        view.addSubview(saveButton)
        
        stackView.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 15, left: 15, bottom: 15, right: 15)
        )
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        saveButton.anchor(
            top: stackView.bottomAnchor,
            bottom: nil,
            centerAnchor: view.centerXAnchor,
            padding: .init(top: 25, left: 0, bottom: 0, right: 0)
        )
        
        saveButton.rx.tap.bind { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.save()
        }.disposed(by: bag)
        
        nameTextField
            .rx
            .text
            .map({ $0.unsafelyUnwrapped })
            .asObservable()
            .bind(to: viewModel.nameTextInput)
            .disposed(by: viewModel.bag)
        
        // Do any additional setup after loading the view.
    }
    
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
