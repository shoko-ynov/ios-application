//
//  CartTableViewCell.swift
//  SelfBuy
//
//  Created by Arthur on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    typealias SetupModel = CartCellViewModelling
    var viewModel: SetupModel
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor =  .white
        view.applyShadow()
        view.applyCornerRadius()
        
        return view
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.tintColor = .black
        //label.font = UIFont(name: <#T##String#>, size: <#T##CGFloat#>)
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.styles()
    }
    
    func styles () {
        mainView.addSubview(title)
        self.addSubview(mainView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: SetupModel) {
        self.viewModel = viewModel
    }

}
