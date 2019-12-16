//
//  HomeViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 06/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//  MARK: - ViewController

final class HomeViewController: UIViewController {
    
    //  MARK: - UI
    private var productsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    //  MARK: - Behaviour
    let viewModel: HomeViewModelling
    var products: [Product] = []
    let dispodeBag = DisposeBag()
    
    init(viewModel: HomeViewModelling) {
        self.viewModel = viewModel
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderImage()
        let titleLabel = setTitleLabel("Accueil", textColor: .white)
        view.backgroundColor = .lightGray
        view.addSubview(productsCollectionView)
        
        self.viewModel.fetchData()
            .subscribe(onSuccess: { products in
                DispatchQueue.main.async {
                    self.products = products
                    self.productsCollectionView.reloadData()
                }
            }, onError: { err in
                self.products = []
                print(err)
            }).disposed(by: dispodeBag)
        
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.alwaysBounceVertical = true
        productsCollectionView.register(ProductCellView.self, forCellWithReuseIdentifier: ProductCellView.reuseIdentifier)
        productsCollectionView.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 5, right: 0))
        
    }

}

//  MARK: - ProductCollectionView
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCellView.reuseIdentifier, for: indexPath) as! ProductCellView
        cell.configure(viewModel: ProductCellViewModel(product: self.products[indexPath.row]))
        
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = productsCollectionView.frame.width
        return CGSize.init(width: size / 2 - 20, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 25, left: 13, bottom: 0, right: 13)
    }
    
}
