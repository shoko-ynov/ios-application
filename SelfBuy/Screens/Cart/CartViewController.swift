//
//  CartViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

final class CartViewController: UIViewController {

    private lazy var itemCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Mon panier"
        label.setToBold(size: 30)
        
        return label
    }()
    
    let viewModel: CartViewModelling
    
    init(viewModel: CartViewModelling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .lightGray
        view.addSubview(titleLabel)
        view.addSubview(itemCollectionView)
        
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.alwaysBounceVertical = true
        itemCollectionView.register(CartCellView.self, forCellWithReuseIdentifier: CartCellView.reuseIdentifier)
        itemCollectionView.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 20, bottom: 5, right: 20))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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

extension CartViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("NUMBER OF ITEMS")
        print(self.viewModel.numberOfItems)
        return self.viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("\n IndexPath")
        print(indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCellView.reuseIdentifier, for: indexPath) as! CartCellView
        cell.configure(with: self.viewModel.getItem(index: indexPath))
        
        return cell
    }
    
}

extension CartViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension CartViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = itemCollectionView.frame.height
        return CGSize.init(width: size - 21, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
    }

}
