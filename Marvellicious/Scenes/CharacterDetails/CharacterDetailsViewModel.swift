//
//  CharacterDetailsViewModel.swift
//  Marvellicious
//
//  Created by Mert Gürcan on 20.02.2022.
//

import Foundation

class CharacterDetailsViewModel : CharacterDetailsViewModelProtocol {

    weak var delegate: CharacterDetailsViewModelDelegate?

    private let result : Result

    init(result : Result){
        self.result = result
    }
    
    func start() {
        guard let presentation = CharacterDetailsPresentation(result: result) else {
            return
        }
        self.delegate?.handleOutput(.showDetails(presentation))
    }


}
