//
//  TopicState.swift
//  Unsplash
//
//  Created by MAZEL Florian on 07/01/2025.
//

import Foundation

@MainActor
class TopicsState: ObservableObject {
    @Published var topics: [Topic] = []

    private let unsplashAPI = UnsplashAPI()

    func fetchTopics() async {
        guard let url = unsplashAPI.topicsUrl() else {
            print("Invalid topics URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let topics = try JSONDecoder().decode([Topic].self, from: data)
            self.topics = topics
        } catch {
            print("Failed to fetch topics: \(error)")
        }
    }
}
