//
//  UnsplashAPI.swift
//  Unsplash
//
//  Created by MAZEL Florian on 07/01/2025.
//

import Foundation

struct UnsplashAPI {
    func feedUrl() -> URL? {
        var components = unsplashApiBaseUrl()
        components.path = "/photos"
        components.queryItems?.append(contentsOf: [
            URLQueryItem(name: "per_page", value: "10")
        ])
        return components.url
    }

    func feedUrl(for topicId: String) -> URL? {
        var components = unsplashApiBaseUrl()
        components.path = "/topics/\(topicId)/photos"
        components.queryItems?.append(URLQueryItem(name: "per_page", value: "10"))
        return components.url
    }
    func unsplashApiBaseUrl() -> URLComponents {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.unsplash.com"
            components.queryItems = [
                URLQueryItem(name: "client_id", value: ConfigurationManager.instance.plistDictionnary.clientId)
            ]
            return components
        }

        func topicsUrl() -> URL? {
            var components = unsplashApiBaseUrl()
            components.path = "/topics"
            components.queryItems?.append(URLQueryItem(name: "per_page", value: "10"))
            return components.url
        }
}

