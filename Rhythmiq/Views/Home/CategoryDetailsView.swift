//
//  CategoryDetailsView.swift
//  Rhythmiq
//
//  Created by noor on 20/05/23.
//

import SwiftUI
import Kingfisher

struct CategoryDetailsView: View {
    var category: Item
    @StateObject private var categoryVm = CategoryViewModel()
    var namespace : Namespace.ID
    @Binding var isShowing: Bool
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            StickyHeaderView(
                headerImage: category.icons?.first?.url ?? "",
                headerText: category.name,
                id: category.id,
                safeArea: safeArea,
                size: size,content: CategoryPlaylistView(),
                namespace: namespace,
                isShowing: $isShowing
            )
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
                        
                        NavigationLink(destination: PlaylistView(playlistItem: playlist, namespace: namespace,isShowing: $isShowing)) {
                            VStack (alignment: .leading){
                                KFImage(URL(string: playlist.images.first?.url ?? ""))
                                    .resizable()
                                    .frame(width: 150, height: 150)
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
    @Namespace static var namespace

    static var previews: some View {
        CategoryDetailsView(category: Item(href: nil, icons: nil, id: "toplists", name: "Top Lists"),namespace: namespace,isShowing: .constant(true))
    }
}
