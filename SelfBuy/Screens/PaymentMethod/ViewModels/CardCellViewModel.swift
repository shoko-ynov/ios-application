//
//  CardCellViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 18/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

protocol CardCellViewModelling {
    var card: Card { get }
}

final class CardCellViewModel: CardCellViewModelling {
    var card: Card
    
    init(card: Card) {
        self.card = card
    }
}
