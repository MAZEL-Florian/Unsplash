//
//  FeedState.swift
//  Unsplash
//
//  Created by MAZEL Florian on 07/01/2025.
//

import Foundation
import Combine

@MainActor
class FeedState: ObservableObject {
    @Published var homeFeed: [UnsplashPhoto]? = nil
    
    private let unsplashAPI = UnsplashAPI()

    func fetchHomeFeed() async {
        guard let url = unsplashAPI.feedUrl() else {
            print("Failed to create feed URL.")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let photos = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            homeFeed = photos
        } catch {
            print("Failed to fetch home feed: \(error)")
        }
    }

    func fetchFeed(forTopicId topicId: String) async {
        guard let url = unsplashAPI.feedUrl(for: topicId) else {
            print("Invalid feed URL for topic")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let photos = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            homeFeed = photos
        } catch {
            print("Failed to fetch feed for topic: \(error)")
        }
    }
}
