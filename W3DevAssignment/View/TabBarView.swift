//
//  TabBarView.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 10/04/24.
//
import SwiftUI

struct TabBarView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                        .foregroundStyle(.black)
                    Text("Home")
                }
                .tag(0)
            NewView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                        .foregroundStyle(.black)
                    Text("New")
                }
                .tag(1)
            StoresView()
                .tabItem {
                    Image(systemName: "bag.fill")
                        .foregroundStyle(.black)
                    
                    Text("Stores")
                }
                .tag(2)

                .tag(3)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                        .accentColor(.blue)
                    Text("Profile")
                }
                .tag(4)
        }
     
        .accentColor(.pink)
    }
}

#Preview {
    TabBarView()
    
}

