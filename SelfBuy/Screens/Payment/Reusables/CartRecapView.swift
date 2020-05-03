//
//  ProductsRecapView.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 02/05/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

final class CartRecapView: UIView {
    
    let viewModel = CartViewModel()
    
    public var itemCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    let viewTitle: UILabel = {
        let label = UILabel()
        label.text = "Produits"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let totalPriceTitle: UILabel = {
        let label = UILabel()
        label.text = "Total"
        label.textColor = .black
        label.setToMedium(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let totalPrice: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.setToBold(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        applyShadow()
        applyCornerRadius()
        backgroundColor = .white
        
        addSubview(viewTitle)
        viewTitle.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 10, left: 20, bottom: 0, right: 0)
        )
        
        addSubview(totalPriceTitle)
        totalPriceTitle.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: nil,
            padding: .init(top: 10, left: 30, bottom: 30, right: 0)
        )
        
        addSubview(totalPrice)
        totalPrice.anchor(
            top: nil,
            leading: nil,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 10, left: 0, bottom: 30, right: 30)
        )
        
        addSubview(itemCollectionView)
        
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.alwaysBounceVertical = true
        itemCollectionView.register(CartRecapCellView.self, forCellWithReuseIdentifier: CartRecapCellView.reuseIdentifier)
        itemCollectionView.anchor(top: viewTitle.bottomAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 80, right: 0))
        
        viewModel.cartItemPublishSubject
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.itemCollectionView.reloadData()
            })
            .disposed(by: viewModel.bag)
        
        totalPrice.text = "33 €"
    }
}

extension CartRecapView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartRecapCellView.reuseIdentifier, for: indexPath) as! CartRecapCellView
        
        cell.configure(with: viewModel.getItem(index: indexPath))
        
        return cell
    }
    
}

extension CartRecapView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = itemCollectionView.frame.width
        return CGSize.init(width: size - 30, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 25, left: 0, bottom: 0, right: 0)
    }
    
}
