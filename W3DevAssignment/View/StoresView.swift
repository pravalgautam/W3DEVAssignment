//
//  StoresView.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 10/04/24.
//

import SwiftUI

struct StoresView: View {

  
    
    @State private var searchText = ""
    
    var filteredStores: [Store] {
        if searchText.isEmpty {
            return stores
        } else {
            return stores.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
 
            VStack {
                Text("Check Nearby Stores")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(filteredStores) { store in
                            Card(store: store)
                                .padding(.horizontal)
                        }
                    }
                }.padding(.vertical,20)
            }
        
        }
    }
    
    
    struct StoresView_Previews: PreviewProvider {
        static var previews: some View {
            StoresView()
        }
    }
    
 
    struct Card: View {
        let store: Store
        
        var body: some View {
            HStack {
                Image(systemName: "mappin")
                    .foregroundColor(.blue)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(store.name)
                        .font(.title)
                        .foregroundColor(.black)
                    Text(store.state)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding()
            .padding(.top,10)
            .background(Color.bg2)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
    
    
    struct SearchBar: View {
        @Binding var text: String
        
        var body: some View {
            HStack {
                TextField("Search", text: $text)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 8)
                .opacity(text.isEmpty ? 0 : 1)
            }
        }
    }

