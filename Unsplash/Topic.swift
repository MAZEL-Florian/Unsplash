//
//  Topic.swift
//  Unsplash
//
//  Created by MAZEL Florian on 07/01/2025.
//

import Foundation

struct Topic: Identifiable, Decodable {
    let id: String
    let title: String
    let coverPhotoUrl: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case coverPhoto = "cover_photo"
    }

    enum CoverPhotoKeys: String, CodingKey {
        case urls
    }

    enum CoverPhotoUrlsKeys: String, CodingKey {
        case regular
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)

        if let coverPhotoContainer = try? container.nestedContainer(keyedBy: CoverPhotoKeys.self, forKey: .coverPhoto),
           let urlsContainer = try? coverPhotoContainer.nestedContainer(keyedBy: CoverPhotoUrlsKeys.self, forKey: .urls) {
            coverPhotoUrl = try urlsContainer.decode(String.self, forKey: .regular)
        } else {
            coverPhotoUrl = nil
        }
    }
}
