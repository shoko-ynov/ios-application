//
//  UILabelExtensions.swift
//  SelfBuy
//
//  Created by Arthur on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setToBold(size: CGFloat) {
        self.font = UIFont(name: "Poppins-Bold", size: size)
    }
    
    func setToMedium(size: CGFloat) {
        self.font = UIFont(name: "Poppins-Medium", size: size)
    }
    
    func setToLight(size: CGFloat) {
        self.font = UIFont(name: "Poppins-Light", size: size)
    }
    
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment

        let attrString = NSMutableAttributedString()
        if (self.attributedText != nil) {
            attrString.append( self.attributedText!)
        } else {
            attrString.append( NSMutableAttributedString(string: self.text!))
            attrString.addAttribute(NSAttributedString.Key.font, value: self.font!, range: NSMakeRange(0, attrString.length))
        }
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
    
}

class UIViewLabel: UIView {
    
    var label: UILabel = {
        let label = UILabel()
        label.text = ""
        
        return label
    }()
    
    var lineHeight: CGFloat = 1.0 {
        didSet {
            self.label.setLineHeight(lineHeight: self.lineHeight)
        }
    }
    
    var numberOfRows: Int = 1 {
        didSet {
            self.label.numberOfLines = self.numberOfRows
        }
    }
    
    var text: String = "" {
        didSet {
            self.label.text = self.text
            self.label.setLineHeight(lineHeight: lineHeight)
        }
    }
   
    init() {
        super.init(frame: .zero)
        
        self.addSubview(label)
        label.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
