//
//  InfoLine.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 18/12/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class InfoLine: UIView {
    
    private let label1: UILabel = {
        let label = UILabel()
        label.setToBold(size: 17)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
       
       return label
   }()
    
    
    init(text: String) {
        super.init(frame: .zero)
        
        self.addSubview(label1)
    
        label1.anchor(
             top: nil,
             leading: self.leadingAnchor,
             bottom: nil,
             trailing: nil,
             padding: .init(top: 0, left: 25, bottom: 0, right: 0)
         )
        
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
