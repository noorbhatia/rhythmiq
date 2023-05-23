//
//  CategoryDetailsView.swift
//  Rhythmiq
//
//  Created by noor on 20/05/23.
//

import SwiftUI

struct CategoryDetailsView: View {
    var category: Item
    @StateObject private var categoryVm = CategoryViewModel()
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            StickyHeaderView(playlist: nil, category: category, safeArea: safeArea, size: size,content: CategoryPlaylistView())
        
                .ignoresSafeArea(.container,edges: .top)
            
        }
        .onAppear {
            categoryVm.fetchPlaylistByCategory(category: category.id)
        }
    }
    @ViewBuilder
    func CategoryPlaylistView ()-> some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
//            GridItem(.flexible(),spacing: 15),
        
        ]

        NavigationStack {
            ScrollView(.vertical,showsIndicators: false) {
                LazyVGrid(columns: columns,spacing: 30) {
                    ForEach(Array(categoryVm.playlists.enumerated()) , id: \.element.id) { index,playlist in
                        
                        NavigationLink(destination: PlaylistView(playlistItem: playlist)) {
                            VStack (alignment: .leading){
                                AsyncImage(url: URL(string: playlist.images.first?.url ?? "")) { image in
                                    image
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                } placeholder: {}
                                Text(playlist.name)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .fontWeight(.regular)
                                    .frame(width: 150)
                                    .lineLimit(1)
                            }
                        }
                        
                        
                    }
                }
            }
        }

        }
        
        
    }


struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailsView(category: Item(href: nil, icons: nil, id: "toplists", name: "Top Lists"))
    }
}
