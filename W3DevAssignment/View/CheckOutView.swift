//
//  CheckOutView.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 11/04/24.
//

import SwiftUI
import Stripe

struct CheckOutView: View {
    @State private var paymentMethodParams: STPPaymentMethodParams?
    @EnvironmentObject var cartManager: CartManager
    @State private var message: String = ""
    @State private var isSuccess: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    let notify = NotificationHandler()
    @State var selectedDate = Date()
    let paymentGatewayController = PaymentGatewayController()
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(colors: [Color.pink, Color.purple], startPoint: .leading, endPoint: .trailing)
                VStack {
                    HStack {
                        Image(systemName: "person")
                        Spacer()
                        Text("VISA").bold()
                    }
                    .padding(20)
                    .foregroundColor(.white)
                    Spacer()
                    HStack {
                        Text("4242 4242 4242 4242")
                        Spacer()
                        Text("02/25")
                    }
                    .padding(20)
                    .foregroundColor(.white)
                }
            }
            .frame(width: 370, height: 250)
            .cornerRadius(20)
            
            STPPaymentCardTextField.Representable(paymentMethodParams: $paymentMethodParams)
                .padding()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Total Amount")
                    Text("Shipping")
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text(String(format: "%.2f", cartManager.cartTotal))

                    Text("FREE")
                }
            }
            .padding(20)
            
            Button(action: {
          
                pay()
                showAlert(message: "Payment Successful")
            }, label: {
                Text("Pay")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            })
            .padding()
               
//            Button("Send notification in 5 seconds") {
//            notify.sendNotification(
//                date: Date(),
//                type: "time",
//                timeInterval: 5,
//                title: "5 second notification",
//                body: "You can write more in here!")
//        }
            Text(message)
                .padding()
        }
        .navigationBarTitle("Checkout")
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage))
        }
        .onAppear {
            notify.askPermission()
        }
    }
    
    private func pay() {
        guard let clientSecret = PaymentConfig.shared.paymentIntentClientSecret else {
            return
        }
        
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        
        paymentGatewayController.submitPayment(intent: paymentIntentParams) { status, intent, error in
            switch status {
            case .failed:
                message = "Failed"
                showAlert(message: "Payment Failed")
            case .canceled:
                message = "Cancelled"
                showAlert(message: "Payment Cancelled")
            case .succeeded:
                message = "Your payment has been successfully completed!"
         
            }
        }
    }
    
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            showAlert = false
        }
    }
}


#Preview {
    CheckOutView()

    
}
