//
//  PaymentViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 26/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

final class PaymentViewController: PresentableViewController {
    
    let swipeableCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PaymentCellView.self, forCellWithReuseIdentifier: PaymentCellView.reuseIdentifier)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    let viewModel: PaymentViewModelling
    
    let breadcrumb = PaymentBreadcrumbView(viewModel: PaymentBreadcrumbViewModel())
    
    var collectionViewScreens: [UIView] = []
    
    init(viewModel: PaymentViewModelling) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let selectPaymentMethodView = SelectPaymentMethodView(viewModel: SelectPaymentMethodViewModel())
    
    let orderShippingView = OrderShippingView(viewModel: OrderShippingViewModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        orderShippingView.swipeToNextPage = { [weak self] in
            guard let strongSelf = self else { return }
            let indexPath = IndexPath(item: 1, section: 0)
            
            strongSelf.swipeableCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            strongSelf.breadcrumb.viewModel.index.onNext(indexPath)
        }
        
        selectPaymentMethodView.swipeToNextPage = { [weak self] in
            guard let strongSelf = self else { return }
            let indexPath = IndexPath(item: 2, section: 0)
            
            strongSelf.swipeableCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            strongSelf.breadcrumb.viewModel.index.onNext(indexPath)
        }
        
        collectionViewScreens = [
            orderShippingView,
            selectPaymentMethodView
        ]
        
        swipeableCollectionView.delegate = self
        swipeableCollectionView.dataSource = self
        breadcrumb.viewModel.index.onNext(.init(item: 0, section: 0))
        
        view.addSubview(swipeableCollectionView)
        view.addSubview(breadcrumb)
        
        breadcrumb.anchor(
            top: closeButton.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 10, left: 15, bottom: 0, right: 15)
        )
        
        swipeableCollectionView.anchor(
            top: breadcrumb.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 15, left: 0, bottom: 0, right: 0)
        )
        
        bind()
    }
    
    func bind() {
        selectPaymentMethodView.viewModel.selectedCard.subscribe(onNext: { [weak self] card in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.setSelectedCard(card)
        }).disposed(by: viewModel.bag)
    }
}

extension PaymentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewScreens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentCellView.reuseIdentifier, for: indexPath) as! PaymentCellView
        cell.setupView(collectionViewScreens[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: swipeableCollectionView.frame.width, height: swipeableCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
