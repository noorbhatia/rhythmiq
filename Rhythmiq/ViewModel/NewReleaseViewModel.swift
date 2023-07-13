//
//  NewReleaseViewModel.swift
//  Rhythmiq
//
//  Created by noor on 16/05/23.
//


import Foundation
import Combine

final class NewReleaseViewModel: ObservableObject {
    @Published var albums: [AlbumItem] = []
    @Published var hasError = false
    @Published var error: String?
    var cancellables = Set<AnyCancellable>()
    
    func tapMeTapped(){
        albums.removeLast()
    }
    
    func fetchNewReleases(){
        let newReleaseURL = URL(string: "https://api.spotify.com/v1/browse/new-releases")
        let model = APIManager<NewRelease>.Model(url: newReleaseURL, method: .get)
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
                [weak self] (returnedAlbums) in
                self?.albums = returnedAlbums.albums.items
            })
            .store(in: &cancellables)
    
        
    }
   
}
