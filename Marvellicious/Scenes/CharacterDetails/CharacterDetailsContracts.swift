//
//  CharacterDetailsContracts.swift
//  Marvellicious
//
//  Created by Mert Gürcan on 20.02.2022.
//

import Foundation

protocol CharacterDetailsViewModelProtocol : AnyObject {
    var delegate : CharacterDetailsViewModelDelegate? { get set }
    func start()
}

enum CharacterDetailsViewModelOutput : Equatable {
    case showDetails(CharacterDetailsPresentation)
}

protocol CharacterDetailsViewModelDelegate: AnyObject {
    func handleOutput(_ output: CharacterDetailsViewModelOutput)
}
