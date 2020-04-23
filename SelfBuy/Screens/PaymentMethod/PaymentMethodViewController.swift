//
//  PaymentMethodViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 17/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

final class PaymentMethodViewController: PresentableViewController {
    
    let viewModel: PaymentMethodViewModelling
    
    private var cardsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.register(
            PaymentMethodCellView.self,
            forCellWithReuseIdentifier: PaymentMethodCellView.reuseIdentifier
        )
        
        return collectionView
    }()
        
    private var addCardButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primary
        button.layer.cornerRadius = 25
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 0.0)
        button.setTitle("Ajouter une carte", for: .normal)
        
        return button
    }()
    
    init(viewModel: PaymentMethodViewModelling) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CardRepository.shared.synchronizeCards()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = setTitleLabel("Mes moyens de paiements", textColor: UIColor.black)
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(cardsCollectionView)
        view.addSubview(addCardButton)
        
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        
        addCardButton.anchor(
            top: nil,
            leading: nil,
            bottom: view.bottomAnchor,
            trailing: nil,
            padding: .init(top: 0, left: 0, bottom: 20, right: 0),
            size: .init(width: 250, height: 50)
        )
        addCardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

        cardsCollectionView.anchor(
            top: titleLabel.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: addCardButton.topAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 15, left: 0, bottom: 15, right: 0)
        )
        
        viewModel.repository.cardsPublishSubject.subscribe(onNext: { [weak self] cards in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.cardsCollectionView.reloadData()
            }
        }).disposed(by: viewModel.bag)
        
        addCardButton.rx.tap.bind { _ in
            let addCardVC = AddCardViewController(viewModel: AddCardViewModel())
            self.present(addCardVC, animated: true)
        }.disposed(by: viewModel.bag)
    }
    
}

//  MARK: - CardsCollectionView
extension PaymentMethodViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.repository.cards.count)
        return viewModel.repository.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentMethodCellView.reuseIdentifier, for: indexPath) as! PaymentMethodCellView
        cell.configure(viewModel: PaymentMethodCellViewModel(card: viewModel.repository.cards[indexPath.row]), index: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.width
        return CGSize.init(width: size - 20, height: 175)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
