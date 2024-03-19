//
//  SeasonDetailModel.swift
//  STARZPLAY
//
//  Created by Usman on 18/03/2024.
//

import Foundation

struct SeasonDetailModel: Codable {
    var id, airDate: String?
    var episodes: [Episode]?
    var name, overview: String?
    var posterPath: String?
    var seasonNumber: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case airDate = "air_date"
        case episodes, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

// MARK: - Episode
struct Episode: Codable {
    
    var episodeNumber, id: Int?
    var name,stillPath : String?
    var runtime, seasonNumber, showID: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case episodeNumber = "episode_number"
        case id, name
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
    }
}
