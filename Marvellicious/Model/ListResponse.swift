//
//  ListResponse.swift
//  Marvellicious
//
//  Created by Mert Gürcan on 20.02.2022.
//

import Foundation

// MARK: - ListResponse
class ListResponse: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass

    init(code: Int, status: String, copyright: String, attributionText: String, attributionHTML: String, etag: String, data: DataClass) {
        self.code = code
        self.status = status
        self.copyright = copyright
        self.attributionText = attributionText
        self.attributionHTML = attributionHTML
        self.etag = etag
        self.data = data
    }
}

// MARK: - DataClass
class DataClass: Codable {
    let offset, limit, total, count: Int?
    var results: [Result] = []

    init(offset: Int?, limit: Int?, total: Int?, count: Int?, results: [Result]) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }
}

// MARK: - Result
class Result: Codable {
    let id: Int?
    let name, resultDescription: String?
    let modified: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    var comics: Comics? = nil
    var series: Comics? = nil
    var stories: Stories? = nil
    var events: Comics? = nil
    let urls: [URLElement]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }

    init(id: Int?, name: String?, resultDescription: String?, modified: String?, thumbnail: Thumbnail?, resourceURI: String?, comics: Comics, series: Comics, stories: Stories, events: Comics, urls: [URLElement]?) {
        self.id = id
        self.name = name
        self.resultDescription = resultDescription
        self.modified = modified
        self.thumbnail = thumbnail
        self.resourceURI = resourceURI
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
        self.urls = urls
    }
}

// MARK: - Comics
class Comics: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
    let returned: Int?

    init(available: Int?, collectionURI: String?, items: [ComicsItem]?, returned: Int?) {
        self.available = available
        self.collectionURI = collectionURI
        self.items = items
        self.returned = returned
    }
}

// MARK: - ComicsItem
class ComicsItem: Codable {
    let resourceURI: String?
    let name: String?

    init(resourceURI: String?, name: String?) {
        self.resourceURI = resourceURI
        self.name = name
    }
}

// MARK: - Stories
class Stories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?

    init(available: Int?, collectionURI: String?, items: [StoriesItem]?, returned: Int?) {
        self.available = available
        self.collectionURI = collectionURI
        self.items = items
        self.returned = returned
    }
}

// MARK: - StoriesItem
class StoriesItem: Codable {
    let resourceURI: String?
    let name: String?
    let type: ItemType?

    init(resourceURI: String?, name: String?, type: ItemType?) {
        self.resourceURI = resourceURI
        self.name = name
        self.type = type
    }
}

enum ItemType: String, Codable {
    case ad = "ad"
    case backcovers = "backcovers"
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
    case pinup = "pinup"
    case profile = "profile"
    case recap = "recap"
    case textArticle = "text article"
}

// MARK: - Thumbnail
class Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: Extension?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }

    init(path: String?, thumbnailExtension: Extension?) {
        self.path = path
        self.thumbnailExtension = thumbnailExtension
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    case png = "png"
}

// MARK: - URLElement
class URLElement: Codable {
    let type: URLType?
    let url: String?

    init(type: URLType?, url: String?) {
        self.type = type
        self.url = url
    }
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
