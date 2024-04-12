//
//  HomeView.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 10/04/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea(.all)
            
            VStack {
                HStack {
                    Text("W3DEV \nCollection")
                        .foregroundStyle(.white)
                        .font(.system(size: 29, weight: .ultraLight))
                    
                    Spacer()
                    
                    NavigationLink(destination: CartView()) {
                        Cart()
                    }
                }
                .padding(.horizontal,20)
                
                ShoeTypesView()
                
                ScrollView(showsIndicators:false) {
                    ForEach(dataManager.newArrivals, id: \.id) { item in
                        TrendingShoeCard(shoeData: item)
                    }
                }
            }
        }
    }
}

import SwiftUI

struct TrendingShoeCard: View {
    var shoeData: ShoeData
    
    var body: some View {
        NavigationLink(destination: ShoeDetailView(shoeData: shoeData)) {
            ZStack {
                VStack(alignment: .leading) {
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
                    
                    HStack {
                        Text(shoeData.shoeName)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .foregroundColor(.black)
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        Text("Explore")
                            .foregroundColor(.white)
                            .frame(width: 90, height: 40)
                            .background(Color.black)
                            .cornerRadius(10)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.trailing, 30)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                }
                .frame(width: 370, height: 300)
                .background(Color.white)
                .cornerRadius(40)
                .shadow(radius: 5)
            }
        }
        .buttonStyle(PlainButtonStyle()) 
    }
}

struct ShoeTypesView: View {
    let shoeTypes = ["All", "Sneakers", "Boots", "Sandals", "Flats", "Heels", "Loafers"]
    @State private var selectedType: String?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(shoeTypes, id: \.self) { type in
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(selectedType == type ? Color.white : Color.black, lineWidth: 0.4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(selectedType == type ? Color.white : Color.black)
                        )
                        .frame(width: 120, height: 40, alignment: .topLeading)

                        .overlay(
                            Text(type)
                                .foregroundColor(selectedType == type ? .black : .gray)
                                .font(.headline)
                        )
                        .onTapGesture {
                            selectedType = type
                        }
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

struct Cart: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        ZStack{
            Image(systemName:"cart")
                .resizable()
                .foregroundColor(.purple)
                .frame(width: 30, height: 30)
            
            Text("\(cartManager.cartCount)")
                .foregroundStyle(.red)
                .frame(width: 20, height: 15)
                .background(.white)
                .offset(x:-10,y: -10)
        }
    }
}
