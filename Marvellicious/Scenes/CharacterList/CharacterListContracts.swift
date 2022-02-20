//
//  CharacterListContracts.swift
//  Marvellicious
//
//  Created by Mert Gürcan on 20.02.2022.
//

import Foundation


protocol CharacterListViewModelProtocol: AnyObject {
    var delegate : CharacterListViewModelDelegate? { get set }
    func getCharacters(page: Int)
    func goCharacterDetails(index: Int)
}

enum CharacterListViewModelOutput: Equatable {
    case updateList([CharacterListPresentation])
}

protocol CharacterListViewModelDelegate: AnyObject {
    func handleOutput(_ output: CharacterListViewModelOutput)
}

protocol CharacterListCoordinatorProtocol : AnyObject {
    func navigate(_ route : CharacterListRoute)
}

enum CharacterListRoute {
    case detail(Result)
}
