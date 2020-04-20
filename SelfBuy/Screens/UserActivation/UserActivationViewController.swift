//
//  UserActivationViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 20/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

class UserActivationViewController: PresentableViewController {
    
    let viewModel: UserActivationViewModelling
    
    init(viewModel: UserActivationViewModelling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        let titleLabel = setTitleLabel("Activer mon compte")
        
        print(viewModel.key)
        print(viewModel.userId)
    }

}
