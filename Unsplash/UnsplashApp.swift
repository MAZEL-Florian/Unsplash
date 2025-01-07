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
    let user: User

    struct URLS: Decodable {
        let small: String
        let full: String
    }

    struct User: Decodable {
        let name: String
    }
}

struct PhotoURLs: Codable {
    let small: String
    let full: String
}
