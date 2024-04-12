//
//  NewView.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 10/04/24.
//

import SwiftUI

import SwiftUI

struct NewView: View {
    @EnvironmentObject var dataManager :  DataManager
    var body: some View {
        
        ZStack{
            Color.white
            VStack{
                Text("New Arrivals")
                    .font(.title)
                ScrollView(showsIndicators:false){
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], content: {
                        ForEach(dataManager.newArrivals) {
                            i in
                            NavigationLink(destination: ShoeDetailView(shoeData: i)) {
                                nikeCard(shoeData: i)
                            }
                        }
                    })
                }
            }
        }


      
    }
    
}



struct nikeCard  : View {
    var shoeData: ShoeData
    var body: some View {
        ZStack{
            Color.white
            VStack{
                ZStack{
                    Color.bg2
                    AsyncImage(url: URL(string: shoeData.shoeImage) ){ phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 220)
                                .cornerRadius(20)
                                .clipped()
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 220)
                                .cornerRadius(20)
                                .clipped()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                }    .frame(width: 170,height: 150)
                    .cornerRadius(20)
                    .padding()
                HStack{
                    VStack(alignment: .leading){
                        Text(shoeData.shoeName)
                            .font(.system(size: 15))
                            .bold()
                        Text("Rs \(shoeData.shoePrice)")
                            .bold()
                    }                  .foregroundStyle(.black)
                    Spacer()
                   
                     
                            
                        HStack{
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(2)")
                                .foregroundStyle(.black)
                        
                    }
                   
                }.padding()
                Spacer()
            }
            
        }  .frame(width: 180,height: 270)
         
    }
}

#Preview {
    NewView()
}
