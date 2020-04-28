//
//  UserEditViewController.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 26/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class UserEditViewController: PresentableViewController {
    
    let viewModel: UserEditViewModelling
    
    let textField: UITextField = {
        let input = UITextField(frame: CGRect(x: -10, y: 350, width:250, height: 50))
        input.backgroundColor = .white
        input.layer.cornerRadius = 15
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.tintColor = .black
        input.textColor = .black
        return input
    }()
    
    
    private var validationButton: UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: 0, y: 475, width: 250, height: 50))
        button.backgroundColor = .primary
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 0
        button.setTitle("Valider", for: .normal)
        
        return button
    }()
    
    init(viewModel: UserEditViewModelling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        let title = setTitleLabel(viewModel.valueName)
        
        textField.placeholder = viewModel.valueName
        textField.rx.text.skip(1).map({ $0.unsafelyUnwrapped }).asObservable().bind(to: viewModel.value).disposed(by: viewModel.bag)
        
        textField.text = viewModel.value.value
        
        view.addSubview(textField)
        view.addSubview(validationButton)
        
        textField.anchor(top: title.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 25, left: 15, bottom: 0, right: 15))
        validationButton.anchor(top: textField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 15, bottom: 0, right: 15))
        
        validationButton.rx.tap.bind { _ in
            self.save()
        }.disposed(by: viewModel.bag)
    }
    
    @objc
    func save() {
        let textFieldValue: String = self.textField.text!
        
        viewModel.updateUser(valueName: viewModel.valueName, value: textFieldValue, userId: viewModel.userId, parameter: viewModel.parameter) { [weak self] result in
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
}
