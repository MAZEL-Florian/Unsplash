//
//  ContentView.swift
//  Unsplash
//
//  Created by MAZEL Florian on 04/12/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var feedState = FeedState()
    @StateObject private var topicsState = TopicsState()

    let columns = [
        GridItem(.flexible(minimum: 150), spacing: 8),
        GridItem(.flexible(minimum: 150), spacing: 8)
    ]

    let placeholderItems = Array(0..<12)

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(topicsState.topics) { topic in
                            NavigationLink(destination: TopicFeedView(topic: topic)) {
                                VStack(spacing: 8) {
                                    AsyncImage(url: URL(string: topic.coverPhotoUrl ?? "")) { phase in
                                        switch phase {
                                        case .empty:
                                            Color.gray
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        case .failure:
                                            Color.red
                                        @unknown default:
                                            Color.gray
                                        }
                                    }
                                    .frame(width: 150, height: 100)
                                    .cornerRadius(12)
                                    .clipped()

                                    Text(topic.title)
                                        .foregroundColor(.primary)
                                        .fontWeight(.semibold)
                                        .lineLimit(1)
                                        .frame(maxWidth: 150)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .frame(width: 150)
                        }
                    }
                    .padding()
                }
                .onAppear {
                    Task {
                        await topicsState.fetchTopics()
                    }
                }

                Button(action: {
                    Task {
                        await feedState.fetchHomeFeed()
                    }
                }) {
                    Text("Load Data")
                        .padding()
                        .background(feedState.homeFeed == nil ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(feedState.homeFeed != nil)

                ScrollView {
                    if feedState.homeFeed == nil {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(placeholderItems, id: \.self) { _ in
                                Color.gray
                                    .frame(height: 150)
                                    .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                        .redacted(reason: .placeholder)
                    } else if let homeFeed = feedState.homeFeed {
                        LazyVGrid(columns: columns, spacing: 8) {
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
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Feed")
            .padding()
        }
    }
}


#Preview {
    ContentView()
}
