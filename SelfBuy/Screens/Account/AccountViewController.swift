//
//  AccountViewController.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 30/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class AccountViewController: PresentableViewController {
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
    
    private let editButton: UIButton = {
         let button = UIButton()
         return button
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
    
    @objc func handleTap(value: String) {
        self.present(EditInfoViewController(viewModel: viewModel, fieldName: "Test Field", fieldValue: "Zakarya"), animated: true)
        print(value)
    }
    
    override func loadView() {
        super.loadView()
        
        _ = setTitleLabel("Compte", textColor: UIColor.black)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func bindViewModel() {
        
        func mapUserInformations(from user: User) -> [String?] {
            let firstName = user.firstName ?? ""
            let lastName = user.lastName ?? ""
            let address = user.address ?? ""
            let postalCode = user.postalCode ?? ""
            let city = user.city ?? ""
            
            return [firstName, lastName, user.mail, address, city, postalCode]
        }
        
        func mapViews(from values: [String?]) -> [InfoLine] {
            var views = [InfoLine]()
            
            for (index, value) in values.enumerated()  {
                guard let user = viewModel.user.value else { return }
                let vm = UserEditViewModel(valueName: viewModel.staticUserData[index].label, value: value ?? "", userId: user._id)
                let viewController = UserEditViewController(viewModel: vm)
                let view = InfoLine(text: viewModel.staticUserData[index].label, iconName: viewModel.staticUserData[index].iconName, data: value)
                view.addTapGestureRecognizer { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.present(viewController, animated: true)
                }
                view.heightAnchor.constraint(equalToConstant: 65).isActive = true
                view.isUserInteractionEnabled = true
                view.translatesAutoresizingMaskIntoConstraints = false
                views.append(view)
            }
            
            return views
        }
        
        func setupStackView(with views: [InfoLine]) {
            views.forEach({
               
                stackView.addArrangedSubview($0)
            })
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
