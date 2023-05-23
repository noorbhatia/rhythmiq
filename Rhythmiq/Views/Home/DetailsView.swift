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
    var body: some View {
        GeometryReader{
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            StickyHeaderView(playlist: playlistItem,category: nil,safeArea: safeArea, size: size,content: TracksListView())
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
struct StickyHeaderView<Content:View>: View {
    @Environment(\.dismiss) private var dismiss
    var playlist: PlaylistItem?
    var category:Item?
    var safeArea: EdgeInsets
    var size: CGSize
    let content: Content
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            
            VStack{
                ArtWork()
                content

            }
            .overlay(alignment: .top){
                HeaderView()
                
            }
        }
        .navigationBarBackButtonHidden()
        .background{
            Color.black.ignoresSafeArea()
            
        }
        .coordinateSpace(name: "SCROLL")
    }
    @ViewBuilder
    func ArtWork()-> some View{
        let height = size.height * 0.45
        GeometryReader{proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / height * (minY > 0 ? 0.5 : 0.8)
            
            AsyncImage(url: URL(string: category?.icons?.first?.url ?? playlist?.images.first?.url ?? "")) { image in
                image.resizable()
            } placeholder: {
            }
            .aspectRatio( contentMode: .fill)
            .frame(width: size.width,height: size.height + (minY > 0 ? minY:0))
            .clipped()
            .overlay(content: {
                ZStack {
                    Rectangle()
                        .fill(
                            .linearGradient(colors: [
                                .black.opacity(0 - progress),
                                .black.opacity(0.1 - progress),
                                .black.opacity(0.3 - progress),
                                .black.opacity(0.5 - progress),
                                .black.opacity(0.8 - progress),
                                .black.opacity(1)
                            ], startPoint: .top, endPoint: .bottom))
            
                }
            })
            .offset(y: -minY)
            
        }
        .frame(height: height + safeArea.top)
        
    }
   
    
    @ViewBuilder
    func HeaderView()-> some View{
        GeometryReader {proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let height = size.height * 0.45
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            let titleProgress = minY / height
            HStack {
                Button {
                    dismiss()
                } label: {
                        Image(systemName: "chevron.left")
                            .font(.title)
                        .foregroundColor(.white)
                       
            
                }
                Text(category?.name ?? playlist?.name ?? "")
                    .font(.system(size: 45))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
//                        .opacity(1 + (progress > 0 ? -progress : progress))
//                        .offset(y: minY < 0 ? minY : 0)
               
                Spacer()
            }
            .padding([.horizontal,.bottom], 15)
            .padding(.top, safeArea.top+10)
            .background(content: {
                Color.black.opacity(-progress > 1 ? -progress * 0.05 : 0)
            })
            .offset(y: -minY)
        }
        .frame(width: .infinity,height: 35)

    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
