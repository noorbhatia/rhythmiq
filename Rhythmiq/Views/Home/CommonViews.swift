//
//  CommonViews.swift
//  Rhythmiq
//
//  Created by noor on 08/05/23.
//

import SwiftUI

struct MoodView: View {
    var body: some View {
        
        HStack {
            AsyncImage(url: URL(string : Constants.dummyImageUrl), content: {image in image.resizable()}, placeholder: {})
                .frame(width: 54,height: 54)
                .cornerRadius(8)
            Text( "Coffee & Jazz").font(.caption).foregroundColor(.white)
        }.padding(.trailing)
            .background(
                Color("ContainerColor")
                    .opacity(0.2))
            .cornerRadius(12)
        
    }
}

struct CommonViews_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MoodView()
            MixesView(category: Item(href: "", icons: [Icon(height: 100, url: "", width: 22)], id: "", name: "dsdf"))
        }
    }
}

struct MixesView: View {
    var category : Item
    var body: some View {
        ZStack(alignment: .topLeading){
            AsyncImage(url: URL(string :category.icons?.first!.url ?? Constants.dummyImageUrl), content: {image in image.resizable()}, placeholder: {})
            VStack{
                Text( category.name)
                    .font(.body)
                    .bold()
                    .kerning(0.4)
                    .foregroundColor(.white)
                    .padding([.top],9)
                Spacer()
                Rectangle()
                    .fill(Color.pink)
                    .frame(width: .infinity,height: 5)
                
            }.background(ZStack {
                LinearGradient(
                    colors: [
                        Color.black.opacity(0.3),
                        Color.clear
                    ],
                    startPoint: .top,
                    endPoint: .center
                )
            })
        }.frame(width: 150,height: 150)
    }
}
struct AlbumsView: View {
    var album : AlbumItem
    var body: some View {
        VStack {
            AsyncImage(url: URL(string :album.images.first!.url),
                       content: {image in image.resizable()},
                       placeholder: {})
            .frame(width: 150,height: 150)
            .padding(.bottom,8)
            
            Text(album.name ?? "")
                .font(.body)
                .bold()
                .kerning(0.4)
                .foregroundColor(.white)
                .padding([.top],9)
                .frame(width: 150)
                .lineLimit(2)
                .truncationMode(.middle)
            
            
            
        }
        
    }
}

struct HeaderTextView: View {
    let text : String
    var body: some View {
        Text(text)
            .font(.title2)
            .bold()
            .foregroundColor(.white)
            .padding(.bottom,12)
    }
}
