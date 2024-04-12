//
//  ProfileView.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 10/04/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var userProfileImage: Image?
    @State private var userName = "Account 1"
    @State private var email = "account1@example.com"
    @State private var showImagePicker = false
    @State private var isEditing = false


    var body: some View {
        VStack {
            
            Button(action: {
                self.showImagePicker = true
            }) {
                if let userProfileImage = userProfileImage {
                    userProfileImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
            }
            .padding()
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: self.$userProfileImage)
            }

            HStack {
                Spacer()
                TextField("Enter your name", text: $userName)
                    .font(.title2)
                    .padding(.horizontal)
                    .disabled(!isEditing)
                if isEditing {
                    Button(action: {
                        // Perform save action here
                        self.isEditing = false
                    }) {
                        Text("Save")
                            .fontWeight(.bold)
                    }
                }
                Spacer()
            }
            HStack{
                Spacer()
                TextField("Enter your email", text: $email)
                    .font(.title3)
                
                    .padding(.horizontal)
                    .disabled(true)
                Spacer()
            }

            Divider()
                .padding(.vertical)

            NavigationLink(destination: OrderHistoryView()) {
                HStack {
                    Image(systemName: "bag")
                        .foregroundColor(.white)
                    Text("Order History")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.purple)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 3, x: 0, y: 2)
            }
            .padding(.horizontal)

            Spacer()
        }.padding(.vertical,50)
        .navigationBarTitle("Account")
        .navigationBarItems(trailing:
            Button(action: {
                self.isEditing.toggle()
            }) {
                if isEditing {
                    Text("Done")
                } else {
                    Text("Edit")
                }
            }
        )
        .background(Color.bg2)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct OrderHistoryView: View {

    
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
            }
        }
    }
}

struct OrderRow: View {
    var order: [ShoeData]
    
    var body: some View {
        VStack(alignment: .leading) {
          
            ForEach(order.indices, id: \.self) { index in
                Text("Order \(order[index].id)")
                    .font(.headline)
                Text(order[index].shoeName)
            }
        }
    }
}
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: Image?
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = Image(uiImage: uiImage)
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

#Preview {
    ProfileView()
}
