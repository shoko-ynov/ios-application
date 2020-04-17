//
//  AccountViewController.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 30/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class AccountViewController: UIViewController {
    
    
    let bag = DisposeBag()
    let viewModel: UserViewModel
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
    
    private let closeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let editButton: UIButton = {
         let button = UIButton()
         return button
     }()
     
    private let closeIcon : UIImage = {
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25.0, weight: .regular, scale: .large))?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal)
        return image!
    }()
    
    private let editIcon : UIImage = {
         let image = UIImage(systemName: "pencil.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 35.0, weight: .regular, scale: .large))?.withTintColor(UIColor.primary, renderingMode: .alwaysOriginal)
         return image!
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        viewModel.showData()
        bindViewModel()

    }
    
    override func loadView() {
        super.loadView()
        
        _ = setTitleLabel("Account", textColor: UIColor.black)
        navigationController?.navigationBar.isHidden = true
    
        
        // MARK: Close button
        self.view.addSubview(closeButton)
        
        closeButton.setImage(closeIcon, for: .normal)
        
        closeButton.anchor(
            top: self.view.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 25, left: 0, bottom: 0, right: 20)
        )
        
        closeButton
            .rx
            .tap
            .bind { [ weak self ] in
                self?.dismiss(animated: true, completion: nil)
        }.disposed(by: bag)
        
        
        // MARK: Edit button (disabled)
//        self.view.addSubview(editButton)
//
//        editButton.setImage(editIcon, for: .normal)
//
//        editButton.anchor(
//            top: nil,
//            leading: self.view.trailingAnchor,
//            bottom: self.view.bottomAnchor,
//            trailing: nil,
//            padding: .init(top: 0, left: -230, bottom: 150, right: 0)
//        )
//
//        editButton
//            .rx
//            .tap
//            .bind { [ weak self ] in
//                self?.present(EditInfoViewController(viewModel: UserViewModel()), animated: true)
//        }.disposed(by: bag)
        
    }
    
    private func bindViewModel() {
        
        func mapUserInformations(from user: User) -> [String?] {
            let firstName = user.firstName ?? ""
            let lastName = user.lastName ?? ""
            let fullName = firstName + " " + lastName
            let address = user.address ?? ""
            let postalCode = user.postalCode ?? ""
            let city = user.city ?? ""
            let fullAddress = address + " " + postalCode + " " + city
            
            return [fullName, user.mail, fullAddress]
        }
        
        func mapViews(from values: [String?]) -> [InfoLine] {
            var views = [InfoLine]()
            
            for (index, value) in values.enumerated()  {
                let view = InfoLine(text: viewModel.staticUserData[index].label, iconName: viewModel.staticUserData[index].iconName, data: value)
                view.heightAnchor.constraint(equalToConstant: 65).isActive = true
                view.translatesAutoresizingMaskIntoConstraints = false
                views.append(view)
            }
            
            return views
        }
        
        func setupStackView(with views: [InfoLine]) {
            views.forEach({ stackView.addArrangedSubview($0) })
            view.addSubview(stackView)
            
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
                stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
                stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        }
        
        viewModel
            .user
            .asDriver()
            .filter({ $0 != nil })
            .map({ $0.unsafelyUnwrapped })
            .map({ mapUserInformations(from: $0) })
            .map({ mapViews(from: $0) })
            .drive(onNext: { views in
                setupStackView(with: views)
            })
        .disposed(by: bag)
    }
}
