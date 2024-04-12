//
//  W3DevAssignmentApp.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 10/04/24.
//
import SwiftUI
import FirebaseCore
import Stripe

class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    FirebaseApp.configure()
    return true
  }
}

@main
struct W3DevAssignmentApp: App {
    @StateObject var dataManager = DataManager()
    @StateObject var cartManager = CartManager()
    let notify = NotificationHandler()
    init(){
        StripeAPI.defaultPublishableKey = "pk_test_51P4KSfSEWCH2Si9a9lw7s528MqnuPrNyA7V6iEEgOQMzto4wS6CveAmbtR1hVAESXrXlRH4z5ijQJmbs9Kx7h7tQ00yjCOuac0"
       
    }

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {

        WindowGroup {
            NavigationView{
                ContentView()
      
            }
                
     
                    .environmentObject(dataManager)
                    .environmentObject(cartManager)
            
                    .onAppear {
                        notify.askPermission()
                    }
        }
    }
}
