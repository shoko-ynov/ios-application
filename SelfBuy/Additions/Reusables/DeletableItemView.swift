//
//  DeletableItemView.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 24/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class DeletableItemView: UIView {
    
    private let bag = DisposeBag()
    
    private let isTranslate: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.applyShadow()
        view.applyCornerRadius()
        
        return view
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 20
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .white
        button.isEnabled = false
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        return button
    }()
        
    var deleteFunction = {}

    override func draw(_ rect: CGRect) {
        addSubview(container)
        addSubview(deleteButton)
        
        deleteButton.layer.zPosition = 1
        container.layer.zPosition = 2
        
        container.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor
        )
        
        deleteButton.anchor(
            top: nil,
            leading: nil,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 10, left: 0, bottom: 10, right: 10)
        )
        deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let containerLeftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        containerLeftSwipeGesture.direction = [.left]
        
        let containerRightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        containerRightSwipeGesture.direction = [.right]
        
        container.addGestureRecognizer(containerLeftSwipeGesture)
        container.addGestureRecognizer(containerRightSwipeGesture)
        
        deleteButton.rx
            .tap
            .bind { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.deleteFunction()
        }.disposed(by: bag)
        
        isTranslate.subscribe (onNext: { [weak self] isTranslate in
            guard let strongSelf = self else { return }
            print(isTranslate)
            
            if (isTranslate) {
                strongSelf.translateViewToLeft()
            } else {
                strongSelf.translateViewToOrigin()
            }
        }).disposed(by: bag)
    }
    
    @objc
    func handleSwipeRight() {
        isTranslate.onNext(false)
        deleteButton.isEnabled = false
        //translateViewToOrigin()
    }
    
    @objc
    func handleSwipeLeft() {
        isTranslate.onNext(true)
        deleteButton.isEnabled = true
        //translateViewToLeft()
    }
    
    func translateViewToLeft() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.container.frame = CGRect(
                x: -60,
                y: strongSelf.frame.origin.y,
                width: strongSelf.frame.width,
                height: strongSelf.frame.height
            )
            
        }
    }
    
    func translateViewToOrigin() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.container.frame = CGRect(
                x: 0,
                y: strongSelf.frame.origin.y,
                width: strongSelf.frame.width,
                height: strongSelf.frame.height
            )
        }
    }
    
}
