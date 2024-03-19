//
//  TVShowModel.swift
//  STARZPLAY
//
//  Created by Usman on 15/03/2024.
//

import Foundation

// MARK: - Basic Model
struct TVShowModel: Codable {
    var page: Int?
    var results: [Result]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    var backdropPath, firstAirDate: String?
    var genreIDS: [Int]?
    var id: Int?
    var name: String?
    var originCountry: [String]?
    var originalLanguage, originalName, overview: String?
    var popularity: Double?
    var posterPath: String?
    var voteAverage: Double?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


struct Card: Decodable, Hashable, Identifiable {
    var id: Int
    var name: String = ""
    var image : String = ""
}
