//
//  TopicFeedView.swift
//  Unsplash
//
//  Created by MAZEL Florian on 07/01/2025.
//

import SwiftUI


struct TopicFeedView: View {
    let topic: Topic
    @StateObject private var feedState = FeedState()

    let columns = [
        GridItem(.flexible(minimum: 150), spacing: 8),
        GridItem(.flexible(minimum: 150), spacing: 8)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                if let homeFeed = feedState.homeFeed {
                    ForEach(homeFeed) { photo in
                        NavigationLink(destination: ImageDetailView(photo: photo)) {
                            AsyncImage(url: URL(string: photo.urls.small)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(height: 150)
                                        .cornerRadius(12)
                                        .clipped()
                                case .failure:
                                    Color.red
                                @unknown default:
                                    Color.gray
                                }
                            }
                            .frame(height: 150)
                            .cornerRadius(12)
                            .clipped()
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle(topic.title)
        .onAppear {
            Task {
                await feedState.fetchFeed(forTopicId: topic.id)
            }
        }
    }
}
