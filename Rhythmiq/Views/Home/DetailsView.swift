//
//  DetailsView.swift
//  Rhythmiq
//
//  Created by noor on 09/05/23.
//

import SwiftUI


struct PlaylistView: View {
    let playlistItem: PlaylistItem
    @StateObject private var playlistVm = PlaylistViewModel()
    var namespace : Namespace.ID
    @Binding var isShowing : Bool
    var body: some View {
        GeometryReader{
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            StickyHeaderView(
                headerImage: playlistItem.images.first?.url ?? "",
                headerText: playlistItem.name,
                id: playlistItem.id,
                safeArea: safeArea,
                size: size,
                content: TracksListView(),
                namespace: namespace,
                isShowing: $isShowing
            )
                .ignoresSafeArea(.container,edges: .top)
                .onAppear {
                    playlistVm.fetchPlaylistTracks(playlistId: playlistItem.id )
                }
        }
    }
    @ViewBuilder
    func TracksListView()-> some View{
        VStack(alignment: .leading,spacing: 25){
            ForEach(playlistVm.tracks.indices, id: \.self) { index in
                let track = playlistVm.tracks[index]
                HStack(spacing: 25){
                    Text("\(index + 1)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                
                    AsyncImage(url: URL(string: track.track.album.images.first?.url ?? "")) { image in
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                    } placeholder: {}

                    VStack(alignment: .leading){
                        Text(track.track.name)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Text(track.track.track.description)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                
            }
            
            
        }
        .padding(.horizontal,12)
    }
}


struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
