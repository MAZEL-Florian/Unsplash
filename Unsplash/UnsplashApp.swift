//
//  UnsplashApp.swift
//  Unsplash
//
//  Created by MAZEL Florian on 04/12/2024.
//

import SwiftUI

@main
struct UnsplashApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct UnsplashPhoto: Identifiable, Decodable {
    let id: String
    let urls: URLS
    let user: User // Auteur de l'image

    struct URLS: Decodable {
        let small: String
        let full: String
        let regular: String
        let thumb: String

        var allUrls: [String] {
            [small, full, regular, thumb]
        }
    }

    struct User: Decodable {
        let name: String
        let profileImage: String
        let profileUrl: String

        enum CodingKeys: String, CodingKey {
            case name
            case profileImage = "profile_image"
            case profileUrl = "links"
        }

        enum ProfileImageKeys: String, CodingKey {
            case medium
        }

        enum LinksKeys: String, CodingKey {
            case html
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            name = try container.decode(String.self, forKey: .name)

            let profileImageContainer = try container.nestedContainer(keyedBy: ProfileImageKeys.self, forKey: .profileImage)
            profileImage = try profileImageContainer.decode(String.self, forKey: .medium)

            let linksContainer = try container.nestedContainer(keyedBy: LinksKeys.self, forKey: .profileUrl)
            profileUrl = try linksContainer.decode(String.self, forKey: .html)
        }
    }
}


struct PhotoURLs: Codable {
    let small: String
    let full: String
}
