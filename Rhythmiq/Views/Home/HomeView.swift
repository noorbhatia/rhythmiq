//
//  ContentView.swift
//  Rhythmiq
//
//  Created by noor on 08/05/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = CategoryViewModel()
    @StateObject private var newReleaseVm = NewReleaseViewModel()
    @Namespace var namespace
    @State var isShowing = false
    @State var selectedCategory : Item?
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient:
                        Gradient(
                            colors: [
                                .blue.opacity(0.8),.black,.black
                            ]),
                    startPoint: .top,
                    endPoint: .center)
                .ignoresSafeArea()
                
                
                
                ScrollView {
                    VStack (alignment: .leading){
                        HomeAppBar().padding(.bottom,35)
                        HStack {
                            HeaderTextView(text: "New Releases")
                            Button {
                                newReleaseVm.tapMeTapped()
                            } label: {
                                Text("Tap ME")
                            }
                            
                        }
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing: 31){
                                ForEach(newReleaseVm.albums, id: \.id){album in
                                    
                                    AlbumsView(album: album)
                                        .onTapGesture {
                                            
                                        }
                                    
                                }
                            }
                        }
                        
                        .alert(isPresented: $newReleaseVm.hasError, content: {
                            Alert(title: Text(newReleaseVm.error ?? "")
                                  
                            )})
                        .onAppear(perform: newReleaseVm.fetchNewReleases)
                        .padding(.bottom,35)
                        HeaderTextView(text: "Top Categories")
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing: 31){
                                ForEach(vm.categories, id: \.id){category in
                                    MixesView(
                                        category: category,
                                        namespace: namespace,
                                        isShowing: $isShowing,
                                        selectedId: category.id
                                    ) .onTapGesture {
                                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.4)){
                                            selectedCategory = category
                                            isShowing.toggle()
                                        }
                                    }
                                }
                            }
                        }
                        .alert(isPresented: $vm.hasError, content: {
                            Alert(title: Text(vm.error ?? "")
                                  
                            )})
                        .onAppear(perform: vm.fetchCategoriesNew)
                        Spacer()
                    }
                    .padding(25)
                }
                .transition(.opacity)
                
                
                
                
                
                
            }
            .overlay {
                if isShowing{
                    
                    CategoryDetailsView(
                        category: selectedCategory!,
                        namespace: namespace,
                        isShowing: $isShowing
                    )
                    
                }
            }
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
    struct HomeAppBar: View {
        
        var body: some View {
            HStack{
                Circle()
                    .frame(width: 30,height: 30)
                    .foregroundColor(.green)
                VStack (alignment: .leading){
                    Text("Welcome Back!")
                        .foregroundColor(.white)
                        .font(.body).bold()
                    Text("noobzik")
                        .foregroundColor(.white.opacity(0.5))
                        .font(.footnote).bold()
                    
                }
                Spacer()
                HStack(spacing: 15) {
                    Button {
                        
                    } label: {
                        Image(systemName: "bell")
                            .foregroundColor(.white)
                    }
                    
                    
                    Image(systemName: "gearshape")
                        .foregroundColor(.white)
                }
                
                
            }
        }
    }
}
