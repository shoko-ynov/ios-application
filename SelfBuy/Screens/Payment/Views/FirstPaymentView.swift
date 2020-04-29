//
//  FirstPayementView.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 26/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

final class FirstPaymentView: UIView {
    
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "FirstView"
        
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Suivant", for: .normal)
        button.backgroundColor = .green
        
        return button
    }()
    
    var swipeToNextPage = {}
    
    let bag = DisposeBag()
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(testLabel)
        addSubview(button)
        
        testLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
        
        button.anchor(
            top: testLabel.bottomAnchor,
            leading: nil,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 200, left: 0, bottom: 0, right: 0)
        )
        
        button.rx.tap.bind { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.swipeToNextPage()
        }.disposed(by: bag)
    }
    
}
