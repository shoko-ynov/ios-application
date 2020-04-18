//
//  PaymentMethodViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 17/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

final class PaymentMethodViewController: UIViewController {
    
    let viewModel: PaymentMethodViewModelling
    var cards: [Card] = []
    let dispodeBag = DisposeBag()

    
    private let closeIcon : UIImage = {
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25.0, weight: .regular, scale: .large))?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal)
        return image!
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
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
        
        let titleLabel = setTitleLabel("Moyen de paiement", textColor: UIColor.black)
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(closeButton)
        
        closeButton.setImage(closeIcon, for: .normal)
        
        closeButton.anchor(
            top: self.view.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 25, left: 0, bottom: 0, right: 20)
        )
        
        closeButton
            .rx
            .tap
            .bind { [ weak self ] in
                self?.dismiss(animated: true, completion: nil)
        }.disposed(by: dispodeBag)
        
        self.view.addSubview(cardsCollectionView)
        
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        cardsCollectionView.alwaysBounceVertical = true
        cardsCollectionView.register(CardCellView.self, forCellWithReuseIdentifier: CardCellView.reuseIdentifier)
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
            }).disposed(by: dispodeBag)
    }

}

//  MARK: - CardsCollectionView
extension PaymentMethodViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCellView.reuseIdentifier, for: indexPath) as! CardCellView
        cell.configure(viewModel: CardCellViewModel(card: self.cards[indexPath.row]))
        
        return cell
    }
    
}

extension PaymentMethodViewController: UICollectionViewDelegate {
    
}

extension PaymentMethodViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = cardsCollectionView.frame.width
        return CGSize.init(width: size - 20, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
