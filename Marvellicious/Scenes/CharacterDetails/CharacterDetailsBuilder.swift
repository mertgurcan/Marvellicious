//
//  CharacterDetailsBuilder.swift
//  Marvellicious
//
//  Created by Mert Gürcan on 20.02.2022.
//

import Foundation

class CharacterDetailsBuilder {
    static func build(result : Result) -> CharacterResultController {
        let vc = CharacterResultController()
        let viewModel = CharacterDetailsViewModel(result: result)
        vc.viewModel = viewModel
        return vc
    }
}
