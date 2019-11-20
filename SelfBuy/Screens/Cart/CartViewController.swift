//
//  CartViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

final class CartViewController: UIViewController {

    private lazy var itemStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Accueil"
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
        view.addSubview(itemStackView)
        
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        itemStackView.anchor(top: titleLabel.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 20, bottom: 5, right: 20))
        
        for i in 0...self.viewModel.numberOfItems - 1 {
            print(i)
            let view = CartItemView(frame: .init(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
            view.configure(viewModel: self.viewModel.getItem(index: i))
            itemStackView.addArrangedSubview(view)
        }
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
