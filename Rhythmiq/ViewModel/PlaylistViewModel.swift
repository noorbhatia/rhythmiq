//
//  PlaylistViewModel.swift
//  Rhythmiq
//
//  Created by noor on 20/05/23.
//

import Foundation
import Combine


final class PlaylistViewModel: ObservableObject {
    @Published var tracks: [TrackItem] = []
    @Published var hasError = false
    @Published var error: String?
    var cancellables = Set<AnyCancellable>()
    
   
    func fetchPlaylistTracks(playlistId: String){
        let playlistUrl = URL(string: "https://api.spotify.com/v1/playlists/\(playlistId)/tracks")
        print(playlistUrl)
        let model = APIManager<TrackModel>.Model(url: playlistUrl, method: .get)
        APIManager.shared.request(with: model)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.hasError = true
                    self.error = error.localizedDescription
                    print(error)
                }
            }, receiveValue: {
                [weak self] (returnedTracks) in
                self?.tracks = returnedTracks.items
            })
            .store(in: &cancellables)
    
        
    }
   
}
