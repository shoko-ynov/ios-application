//
//  ProfileButton.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 04/12/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class ProfileButton: UIView {

    let bag = DisposeBag()
    var onTapHandler: (() ->Void)?

    private let button: UIButton = {
        let button = UIButton()
        button.titleLabel?.setToMedium(size: 20)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private let arrow : UIImageView = {
        let image = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(weight: .ultraLight))?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)

        let imageView = UIImageView(image: image)

        return imageView
    }()

    private let line : UIView = {
        let line = UIView()
        line.layer.borderWidth = 1.0
        line.layer.borderColor = UIColor.gray.cgColor

        return line
    }()

    init(text: String) {
        super.init(frame: .zero)

        button.setTitle(text, for: .normal)

        self.addSubview(button)
        self.addSubview(line)
        self.addSubview(arrow)

        button.titleLabel?.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 0, left: 35, bottom: 0, right: 0)
        )

        arrow.anchor(
               top: self.topAnchor,
               leading: button.trailingAnchor,
               bottom: nil,
               trailing: self.trailingAnchor,
               padding: .init(top: 0, left: 0, bottom: 0, right: 35),
               size: .init(width: 15, height: 25)
        )
        
        line.anchor(
              top: button.bottomAnchor,
              leading: button.leadingAnchor,
              bottom: self.bottomAnchor,
              trailing: arrow.trailingAnchor,
              padding: .init(top: 3, left: 0, bottom: 0, right: 0),
              size: .init(width: 310, height: 0.3)
        )

        button
            .rx
            .tap
            .bind {
                self.onTapHandler?()
        }.disposed(by: bag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
