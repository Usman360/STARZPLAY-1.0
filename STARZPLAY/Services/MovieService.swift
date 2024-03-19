//
//  MovieService.swift
//  STARZPLAY
//
//  Created by Usman on 18/03/2024.
//

import Foundation
import Combine
import SPNetworking
protocol MovieServiceProtocol: AnyObject {
    func fetchTVShowData(params: [String: Any]) -> AnyPublisher<TVShowModel, ApiError>
    func fetchSeasonEpisodesData(showId: Int,seasonId: Int,params: [String: Any]) -> AnyPublisher<SeasonDetailModel, ApiError>
    func fetchTVShowDataWithID(showId: Int, params: [String: Any]) -> AnyPublisher<ShowDetailModel, ApiError>
}

class MovieService: MovieServiceProtocol {
   
    
    init() {}
    
    func fetchTVShowData(params: [String: Any]) -> AnyPublisher<TVShowModel, ApiError> {
        let request = MovieProvider.popular(params: params)
        return NetworkManager.shared.request(request, decodingType: TVShowModel.self)
    }
    
    func fetchSeasonEpisodesData(showId: Int, seasonId: Int,params: [String: Any]) -> AnyPublisher<SeasonDetailModel, ApiError> {
        let request = MovieProvider.season(showId: showId, seasonId: seasonId, params: params)
        return NetworkManager.shared.request(request, decodingType: SeasonDetailModel.self)
    }
    
    func fetchTVShowDataWithID(showId: Int, params: [String: Any]) -> AnyPublisher<ShowDetailModel, ApiError> {
        let request = MovieProvider.detail(showId: showId, params: params)
        return NetworkManager.shared.request(request, decodingType: ShowDetailModel.self)
    }
}
