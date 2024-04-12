//
//  ShoeDetailView.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 11/04/24.

import SwiftUI
struct ShoeDetailView: View {
    var shoeData : ShoeData
    var body: some View {
        VStack{
            Spacer()
            HStack(spacing: 90) {
                CustomBackButton()

                Text(shoeData.shoeName)
                    .foregroundStyle(.black)
                NavigationLink(destination: CartView()) {
                    Cart()
                }
                    .foregroundStyle(.black)
                
            }
            Spacer()
            AsyncImage(url: URL(string: shoeData.shoeImage) ){ phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 365)
                        .cornerRadius(20)
                        .clipped()
                case .failure:
                    Image("s1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 365)
                        .cornerRadius(20)
                        .clipped()
                @unknown default:
                    EmptyView()
                }
            }
  
            DetailCard(shoeData: shoeData)
                .ignoresSafeArea(.all)
                .cornerRadius(50)
        }
        .ignoresSafeArea(.all)
        .background(.white)
            .navigationBarBackButtonHidden(true)
    }
}

struct DetailCard: View {
    var shoeData : ShoeData
    
    var body: some View {
        VStack{
            Spacer()
            HStack {
                VStack(alignment:.leading) {
                    Text(shoeData.shoeName)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color(UIColor.black))
                    HStack {
                        Text("")
                            .foregroundStyle(.gray)
                        Text("\(shoeData.shoeRating)")
                            .foregroundStyle(.gray)
                        Text("\(shoeData.shoeArticleNumber)")
                            .foregroundStyle(.gray)
                    }
                    Text("\(shoeData.shoeArticleNumber)")
                        .foregroundStyle(.gray)
                    Text("Color:")
                        .foregroundStyle(.gray)
                  
                }
                .padding(.leading, 20)
                
                Spacer()
                
                VStack(alignment:.trailing) {
                    Text("n3232")
                        .foregroundStyle(.gray)
                    HStack {
                        ForEach(shoeData.shoeColors, id: \.self) { colorString in
                            Text(colorString.uppercased())
                        }
                    }



                }
                .padding(.trailing, 20)
            }
            PriceCard(shoeData: shoeData)
                .cornerRadius(50)
        }
        .frame(width: 400, height: 340)
        .background(Color.bg2)
    }
}

struct PriceCard: View {
    var shoeData : ShoeData
    @EnvironmentObject var cartManager : CartManager
    var body: some View {
        VStack {
            VStack {
                HStack{
                    DropDownView(width: 120, height: 40)
                    Spacer()
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 0.2)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.black))
                        .frame(width: 50, height: 50)
                        .overlay(
                         Image(systemName: "heart")
                            .resizable()
                            .padding()
                            .foregroundColor(.white)
                        )
                 
                }
                HStack {
                    Text("MRP: \u{20B9}\(shoeData.shoePrice)")
                        .font(.title2)
                        .foregroundStyle(.white)
                    Spacer()
                    Button {
                        cartManager.addToCart(shoeData)
                    } label: {
                        Text("Add To Bag")
                            .foregroundColor(.black)
                            .frame(width: 180, height: 60)
                            .background(.white)
                            .cornerRadius(30).font(.system(size: 16, weight: .semibold))
                    }
                }.padding(2)
            }
        }
        .padding(.horizontal,30)
        .frame(maxWidth: 400, maxHeight: 200).background(Color.bg)
    }
}

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left").font(.title2).foregroundColor(Color(UIColor.black))
        }
    }
}

struct DropDownView: View {
    var width : Double
    var height : Double
    let options = ["US 5", "US 6", "US 8"]
    @State private var selectedOption = 0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white, lineWidth: 0.2)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.black))
                .frame(width: width, height: height)
                .padding(.leading,0)
            
            Picker(selection: $selectedOption, label: Text(""))
            {
                ForEach(0 ..< options.count) {
                    Text(self.options[$0])
                }
            }
            
            .foregroundColor(.white)
            .pickerStyle(MenuPickerStyle())
            .accentColor(.white)
            .padding(EdgeInsets(top: 5, leading: 45, bottom:5, trailing: 45))
        }
    }
}



#Preview {
    ShoeDetailView(shoeData: dummyShoeData[0])
}

