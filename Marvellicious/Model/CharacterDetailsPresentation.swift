//
//  CharacterDetailsPresentation.swift
//  Marvellicious
//
//  Created by Mert Gürcan on 20.02.2022.
//

import Foundation

class CharacterDetailsPresentation : NSObject {
    var name : String
    var photo : String
    var characterDescription: String
    var comicslist : [ComicsItemPresentation]

    init(name : String, photo: String, characterDescription : String, comicslist:[ComicsItemPresentation] ) {
        self.name = name
        self.photo = photo.replacingOccurrences(of: "http", with: "https") + ".jpg"
        self.characterDescription = characterDescription
        self.comicslist = comicslist
    }

    convenience init?(result : Result) {
        guard let comic = result.comics?.items else {
            return nil
        }
        self.init(name: result.name ?? "", photo : result.thumbnail?.path ?? "", characterDescription: result.resultDescription ?? "", comicslist: comic.map(ComicsItemPresentation.init))
    }

    static func ==(left: CharacterDetailsPresentation, right : CharacterDetailsPresentation) -> Bool {
        return left.name == right.name
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? CharacterDetailsPresentation else { return false}
        return self == other
    }
}

class ComicsItemPresentation : NSObject {
    var name : String

    init(name : String){
        self.name = name
    }

    convenience init(result : ComicsItem) {
        self.init(name: result.name ?? "")
    }

    static func ==(left: ComicsItemPresentation, right : ComicsItemPresentation) -> Bool {
        return left.name == right.name
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ComicsItemPresentation else { return false}
        return self == other
    }
}
