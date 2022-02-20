//
//  CharacterListPresentation.swift
//  Marvellicious
//
//  Created by Mert Gürcan on 20.02.2022.
//

import Foundation

class CharacterListPresentation : NSObject {
    var name : String
    var photo : String

    init(name : String, photo: String){
        self.name = name
        self.photo = photo.replacingOccurrences(of: "http", with: "https") + ".jpg"
    }

    convenience init(result : Result) {
        self.init(name: result.name ?? "", photo : result.thumbnail?.path ?? "")
    }

    static func ==(left: CharacterListPresentation, right : CharacterListPresentation) -> Bool {
        return left.name == right.name
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? CharacterListPresentation else { return false}
        return self == other
    }
}
