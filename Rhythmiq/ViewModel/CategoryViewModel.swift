//
//  CategoryViewModel.swift
//  Rhythmiq
//
//  Created by noor on 14/05/23.
//

import Foundation
import Combine

final class CategoryViewModel: ObservableObject {
    @Published var categories: [Item] = []
    @Published var playlists: [PlaylistItem] = []
    @Published var hasError = false
    @Published var error: String?
    var cancellables = Set<AnyCancellable>()
    
   
    func fetchCategoriesNew(){
        let categoryUrl = URL(string: "https://api.spotify.com/v1/browse/categories")
        let model = APIManager<Category>.Model(url: categoryUrl, method: .get)
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
                [weak self] (returnedCategories) in
                self?.categories = returnedCategories.categories.items
            })
            .store(in: &cancellables)
    
        
    }
    func fetchPlaylistByCategory(category: String){
        let playlistUrl = URL(string: "https://api.spotify.com/v1/browse/categories/\(category)/playlists")
        let model = APIManager<Playlist>.Model(url: playlistUrl, method: .get)
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
                [weak self] (returnedPlaylists) in
                self?.playlists = returnedPlaylists.playlists.items
            })
            .store(in: &cancellables)
    
        
    }
   
}

