////
////  Movie.swift
////  Unsplash
////
////  Created by MAZEL Florian on 07/01/2025.
////
//
//import Foundation
//import SwiftUI
//
//struct Movie: Codable {
//    let title: String
//    let releaseYear: Int
//    let genre: String
//}
//
//
//
//struct jsonMovie: View {
//    let jsonString = """
//    [
//        {
//            "title": "Inception",
//            "releaseYear": 2010,
//            "genre": "Sci-Fi"
//        },
//        {
//            "title": "The Dark Knight",
//            "releaseYear": 2008,
//            "genre": "Action"
//        }
//    ]
//    """
//    struct Codable {
//    if let jsonData = jsonString.data(using: .utf8) {
//        do {
//            let movies = try JSONDecoder().decode([Movie].self, from: jsonData)
//            // Ici, vous avez un tableau de films que vous pouvez utiliser.
//            for movie in movies {
//                print("Film: \(movie.title), Année de sortie: \(movie.releaseYear), Genre: \(movie.genre)")
//            }
//        } catch {
//            print("Erreur de décodage: \(error)")
//        }
//    }
//
//        
//            
//        }
//            
//}
