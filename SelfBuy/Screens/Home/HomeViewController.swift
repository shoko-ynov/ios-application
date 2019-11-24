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

final class HomeViewController: UIViewController {
    
    private var productsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    let viewModel: HomeViewModelling
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
        
        // Je dois reload la collectionView une fois que j'ai récupéré les données.
        self.viewModel
            .shouldReloadData
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] _ in
                self?.productsCollectionView.reloadData()
            })
            .disposed(by: dispodeBag)
        self.viewModel.fetchData()
        setupView()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .lightGray
        view.addSubview(productsCollectionView)
        
        let titleLabel = setTitleLabel("Accueil")
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.alwaysBounceVertical = true
        productsCollectionView.register(ProductCellView.self, forCellWithReuseIdentifier: ProductCellView.reuseIdentifier)
        productsCollectionView.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 5, right: 0))
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCellView.reuseIdentifier, for: indexPath) as! ProductCellView
        cell.configure(viewModel: self.viewModel.getItem(index: indexPath))
        
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
