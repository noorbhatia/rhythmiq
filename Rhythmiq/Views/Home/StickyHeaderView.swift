//
//  StickyHeaderView.swift
//  Rhythmiq
//
//  Created by noor on 28/05/23.
//

import SwiftUI
import Kingfisher

struct StickyHeaderView<Content:View>: View {
    @Environment(\.dismiss) private var dismiss
    var headerImage: String
    var headerText: String
    var id: String
    var safeArea: EdgeInsets
    var size: CGSize
    let content: Content
    var namespace : Namespace.ID
    @Binding var isShowing : Bool
    @State private var animateContent: Bool = false
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
            
            KFImage(URL(string: headerImage))
                .resizable()
                .aspectRatio( contentMode: .fill)
                .matchedGeometryEffect(id: id, in: namespace)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY:0))
                .clipped()
                .cornerRadius(deviceCornerRadius)
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
            HStack {
                
                    Text(headerText)
                        .font(.system(size: 45))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                
                    
               
                Spacer()
                Button {
                    withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.8, blendDuration: 0.7)){
                        isShowing = false
                    }
                } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                        .foregroundColor(.white)
                       
            
                }

        
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

extension View {
    var deviceCornerRadius: CGFloat {
        let key = "_displayCornerRadius"
        if let screen = (UIApplication.shared.connectedScenes.first as?
                         UIWindowScene)?.windows.first?.screen{
            if let cornerRadius = screen.value(forKey: key) as? CGFloat {
                return cornerRadius
            }
            return 0
        }
        return 0

    }
}
