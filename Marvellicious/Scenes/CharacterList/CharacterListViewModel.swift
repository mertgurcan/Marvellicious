//
//  CharacterListViewModel.swift
//  Marvellicious
//
//  Created by Mert Gürcan on 20.02.2022.
//

import Foundation

class CharacterListViewModel: CharacterListViewModelProtocol {

    weak var delegate: CharacterListViewModelDelegate?

    private let url = "https://gateway.marvel.com/v1/public/characters"
    private var loadResources : Resource<ListResponse>?

    private var listResponse : ListResponse?

    private let coordinator : CharacterListCoordinatorProtocol
    private let service : ServiceProtocol

    var pageItem = 30

    init(coordinator: CharacterListCoordinatorProtocol, service : Service) {
        self.coordinator = coordinator
        self.service = service
    }
    
    func getCharacters(page : Int) {
        let param : [String: Any] = ["limit" : "\(pageItem)", "offset" :"\((page-1) * pageItem)"]
        loadResources = Resource<ListResponse>(url: url, param: param)
        guard let loadResources = loadResources else {
            return
        }
        service.load(resource: loadResources) { result in
            switch result {
            case .succes(let data):
                if let data = data {
                    if page == 1 {
                        self.listResponse = data
                    } else {
                        self.listResponse?.data.results.append(contentsOf: data.data.results)
                    }
                    self.delegate?.handleOutput(.updateList(data.data.results.map(CharacterListPresentation.init)))
                }
            case .failure(let err):
                print("Failed")
            }
        }
    }

    func goCharacterDetails(index: Int) {
        guard let listResponse = listResponse else {
            return
        }
        coordinator.navigate(.detail(listResponse.data.results[index]))
    }


}
