//
//  SelectPaymentMethodView.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 26/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

final class SelectPaymentMethodView: UIView {
    
    private let cardsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.register(
            PaymentMethodCellView.self,
            forCellWithReuseIdentifier: PaymentMethodCellView.reuseIdentifier
        )
        
        return collectionView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Choisissez votre moyen de paiement"
        label.setToBold(size: 16)
        
        return label
    }()
    
    let viewModel: SelectPaymentMethodViewModelling
    
    var swipeToNextPage = {}
    
    init(viewModel: SelectPaymentMethodViewModelling) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        cardsCollectionView.dataSource = self
        cardsCollectionView.delegate = self
        
        addSubview(cardsCollectionView)
        addSubview(label)
        
        label.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 10, bottom: 0, right: 10)
        )
        
        cardsCollectionView.anchor(
            top: label.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 5, left: 0, bottom: 0, right: 0)
        )
        
        viewModel.repository.cardsSubject.subscribe(onNext: { [weak self] _ in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.cardsCollectionView.reloadData()
            }
        }).disposed(by: viewModel.bag)
    }

}

extension SelectPaymentMethodView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.numberOfItems)
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentMethodCellView.reuseIdentifier, for: indexPath) as! PaymentMethodCellView
        
        cell.configure(viewModel: viewModel.getItem(indexPath), index: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = cardsCollectionView.frame.width
        return CGSize.init(width: size - 20, height: 175)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectCard(indexPath)
        swipeToNextPage()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 25, left: 0, bottom: 0, right: 0)
    }
    
}
