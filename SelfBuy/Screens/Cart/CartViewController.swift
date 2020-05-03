//
//  CartViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

final class CartViewController: UIViewController {
    
    private var itemCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    private var checkoutBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primary
        button.layer.cornerRadius = 25
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 0.0)
        button.setTitle("Valider le panier", for: .normal)
        
        return button
    }()
    
    let viewModel: CartViewModelling
    
    init(viewModel: CartViewModelling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        itemCollectionView.reloadData()
    }
    
    fileprivate func setupView() {
        setHeaderImage()
        view.backgroundColor = .lightGray
        view.addSubview(itemCollectionView)
        
        checkoutBtn.frame = CGRect(x: 0, y: self.view.frame.size.height - 160, width: 250, height:50)
        checkoutBtn.center.x = self.view.center.x
        view.addSubview(checkoutBtn)
        
        let titleLabel = setTitleLabel("Mon panier", textColor: .white)
        
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.alwaysBounceVertical = true
        itemCollectionView.register(CartCellView.self, forCellWithReuseIdentifier: CartCellView.reuseIdentifier)
        itemCollectionView.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 5, right: 0))
        
        checkoutBtn.rx.tap.bind { [weak self] _ in
            guard let strongSelf = self else { return }
            
            //if strongSelf.viewModel.cartItemPublishSubject
            
            if UserRepository.shared.getUser() != nil {
                let paymentVc = PaymentViewController(viewModel: PaymentViewModel())
                strongSelf.present(paymentVc, animated: true)
            } else {
                let loginVC = LoginViewController(viewModel: LoginViewModel())
                
                loginVC.onDismiss = {
                    if UserRepository.shared.getUser() != nil {
                        let paymentVc = PaymentViewController(viewModel: PaymentViewModel())
                        strongSelf.present(paymentVc, animated: true)
                    }
                }
                
                strongSelf.present(loginVC, animated: true)
            }
            
        }.disposed(by: viewModel.bag)
        
        viewModel.repository.productsSubject.subscribe(onNext: { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.itemCollectionView.reloadData()
        }).disposed(by: viewModel.bag)
    }
    
}

extension CartViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCellView.reuseIdentifier, for: indexPath) as! CartCellView
        
        cell.configure(with: viewModel.getItem(index: indexPath))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = itemCollectionView.frame.width
        return CGSize.init(width: size - 30, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 25, left: 0, bottom: 0, right: 0)
    }
    
}
