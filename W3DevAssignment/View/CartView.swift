//
//  CartView.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 11/04/24.
//

import SwiftUI

import Stripe

struct CartView: View {

    @EnvironmentObject var cartManager : CartManager
    @State  var isActive : Bool  = false
    
    private func startCheckout(completion: @escaping (String?) -> Void) {
         
          let url = URL(string: "https://mango-persistent-organ.glitch.me/create-payment-intent")!

          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(cartManager.items)
          
          URLSession.shared.dataTask(with: request) { data, response, error in
                  
              guard let data = data, error == nil,
                    (response as? HTTPURLResponse)?.statusCode == 200
              else {
                  completion(nil)
                  return
              }
              
              let checkoutIntentResponse = try? JSONDecoder().decode(CheckoutIntentResponse.self, from: data)
              completion(checkoutIntentResponse?.clientSecret)

          }.resume()
          
      }
      
    var body: some View {
        if cartManager.items.isEmpty {
Text("nothing")
        } else {
            ScrollView{
                ForEach(cartManager.items){
                    item in
                    CartCard(shoeData: item)
                }
                
                NavigationLink(isActive: $isActive){
                    CheckOutView()
                }label:{
                    Button("Checkout") {
                        startCheckout { clientSecret in
                            
                            PaymentConfig.shared.paymentIntentClientSecret = clientSecret
                            
                            DispatchQueue.main.async {
                                isActive = true
                            }
                        }
                    }.foregroundColor(.white)
                        .frame(width: 350,height: 60)
                        .cornerRadius(30)
                        .background(.black)
                        
                    
                }
              
          
            }
        }
    }
}

#Preview {
    CartView()
        
}

struct CartCard: View {
    var shoeData :ShoeData
    var body: some View {
        VStack{
                HStack{
                    AsyncImage(url: URL(string: shoeData.shoeImage) ){ phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 150,height: 200)
                                .aspectRatio(contentMode: .fill)
        
                                .cornerRadius(20)
                                .clipped()
                        case .failure:
                            Image("s1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150,height: 200)
                                .cornerRadius(10)
                                .clipped()
                        @unknown default:
                            EmptyView()
                        }
                        
                    }

                VStack(alignment:.leading){
                    Text(shoeData.shoeName)
                        .bold()
                    HStack(alignment: .top, spacing: 10){
                        DropDownView(width: 70, height: 40)
                    }
                    HStack{
                        Text(shoeData.shoePrice)
                            .bold()
                        ZStack{
                            Text("$ 1400")
                            Rectangle()
                                .frame(width: 50,height: 1)
                        }
                    }

                        .bold()
                    HStack{
                        Image(systemName: "return")
                        Text("14 days return available")
                            .foregroundStyle(.gray)
                    }
                    .padding(.bottom,30)
                }
               
            }
        }
        .background(.bg2)
    }
}

