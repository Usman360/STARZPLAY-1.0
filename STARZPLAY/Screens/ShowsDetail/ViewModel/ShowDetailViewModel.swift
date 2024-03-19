//
//  ShowDetailViewModel.swift
//  STARZPLAY
//
//  Created by Usman on 18/03/2024.
//

import Foundation
import Combine

class ShowDetailViewModel : ObservableObject{
    private let service: MovieServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading = false
    @Published var tvShowDetail: ShowDetailModel = ShowDetailModel()
    
    @Published var seasonDetail = SeasonDetailModel()

    @Published var isAlreadySelected = true
    
    @Published var seasonList = [SeasonsTapModel]()
    
    
    init(service: MovieServiceProtocol = MovieService()) {
        self.service = service
    }
   
    func fetchTVShowData(showId: Int){
        isLoading = true
        let params = ["api_key": Constants.APIEnvionment.apiKey]
        
        self.service.fetchTVShowDataWithID(showId: showId, params: params)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] result in
            switch result {
            case .failure(let error):
                print("Error in request: \(error)")
                    self?.isLoading = false
            case .finished:
                print("api process complete")
            }
        } receiveValue: {[weak self] response in
            self?.isLoading = false
                self?.tvShowDetail = response
                self?.getSeasonsList(fromShowData: response)

        }.store(in: &cancellables)

    }
    
    func fetchSeasonData(_ ShowID:Int, _ SeasonID: Int){
        self.isAlreadySelected = false
        isLoading = true

        let params = ["api_key": Constants.APIEnvionment.apiKey]
        
        self.service.fetchSeasonEpisodesData(showId: ShowID, seasonId: SeasonID, params: params)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] result in
            switch result {
            case .failure(let error):
                print("Error in request: \(error)")
                self?.isLoading = false
            case .finished:
                print("api process complete")
            }
        } receiveValue: {[weak self] response in
            self?.isLoading = false
            self?.seasonDetail = response
            
        }.store(in: &cancellables)

    }
    
    func getSeasonsList(fromShowData showData : ShowDetailModel?){
        self.seasonList = []
        if showData != nil && showData?.seasons != nil && !showData!.seasons!.isEmpty{
            
            for season in showData!.seasons!{
                if (season.seasonNumber != nil) && season.name != nil{
                    if season.seasonNumber! != 0{
                        
                        self.seasonList.append(SeasonsTapModel(id: season.seasonNumber!, name: "SEASON \(season.seasonNumber!)"))
                    }
                }
            }
        }
    }
}
