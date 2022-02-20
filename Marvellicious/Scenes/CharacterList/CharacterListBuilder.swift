//
//  CharacterListBuilder.swift
//  Marvellicious
//
//  Created by Mert Gürcan on 20.02.2022.
//

import Foundation

class CharacterListBuilder {
    static func build() -> CharacterListController {
        let service = Service()
        let vc = CharacterListController()
        let coordinator = CharacterListCoordinator(vc: vc)
        let viewModel = CharacterListViewModel(coordinator: coordinator,service: service)
        vc.viewModel = viewModel
        return vc
    }
}
