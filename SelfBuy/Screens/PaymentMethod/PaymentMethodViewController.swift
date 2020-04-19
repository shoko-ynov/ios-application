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
    var cards: [Card] = []
    
    private var cardsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    init(viewModel: PaymentMethodViewModelling) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = setTitleLabel("Mes moyens de paiements", textColor: UIColor.black)
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(cardsCollectionView)
        
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        cardsCollectionView.alwaysBounceVertical = true
        cardsCollectionView.register(PaymentMethodCellView.self, forCellWithReuseIdentifier: PaymentMethodCellView.reuseIdentifier)
        cardsCollectionView.anchor(
            top: titleLabel.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 15, left: 0, bottom: 5, right: 0)
        )
        
        self.viewModel.fetchData()
            .subscribe(onSuccess: { [weak self] cards in
                DispatchQueue.main.async {
                    self?.cards = cards
                    self?.cardsCollectionView.reloadData()
                }
            }, onError: { [weak self] err in
                self?.cards = []
                print(err)
            }).disposed(by: viewModel.bag)
    }

}

//  MARK: - CardsCollectionView
extension PaymentMethodViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentMethodCellView.reuseIdentifier, for: indexPath) as! PaymentMethodCellView
        cell.configure(viewModel: PaymentMethodCellViewModel(card: self.cards[indexPath.row]), index: indexPath)
        
        return cell
    }
    
}

extension PaymentMethodViewController: UICollectionViewDelegate {
    
}

extension PaymentMethodViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = cardsCollectionView.frame.width
        return CGSize.init(width: size - 20, height: 175)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
