//
//  UIImageViewExtensions.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 24/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}
