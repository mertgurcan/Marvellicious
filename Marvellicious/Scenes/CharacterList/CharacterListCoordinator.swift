//
//  CharacterListCoordinator.swift
//  Marvellicious
//
//  Created by Mert Gürcan on 20.02.2022.
//

import Foundation

class CharacterListCoordinator : CharacterListCoordinatorProtocol {

    let vc : CharacterListController

    init(vc: CharacterListController){
        self.vc = vc
    }

    func navigate(_ route: CharacterListRoute) {
        switch route {
        case .detail(let result):
            let detailVC = CharacterDetailsBuilder.build(result: result)
            vc.navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    
}
