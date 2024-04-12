//
//  DataManager.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 11/04/24.
//

import Foundation
import Firebase

class DataManager: ObservableObject {
    @Published var newArrivals: [ShoeData] = []

    init() {
        fetchData()
    }

    func fetchData() {
        newArrivals.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("NewArrival")

        ref.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {
                print("Error: Snapshot is nil.")
                return
            }
            
            for document in snapshot.documents {
                let data = document.data()
                
                // Parse data fields
                let shoeName = data["shoeName"] as? String ?? ""
                let shoeImage = data["shoeImage"] as? String ?? ""
                let shoePrice = data["shoePrice"] as? String ?? ""
                let shoeRating = data["shoeRating"] as? Double ?? 0.0
                let shoeArticleNumber = data["shoeArticleNumber"] as? String ?? ""
                let shoeColors = data["shoeColors"] as? [String] ?? []
                let shoeSizes = data["shoeSizes"] as? [Int] ?? []
                let favourite = data["favourite"] as? Bool ?? false
                
                // Create ShoeData instance
                let shoeData = ShoeData(shoeName: shoeName,
                                        shoeImage: shoeImage,
                                        shoePrice: shoePrice,
                                        shoeRating: shoeRating,
                                        shoeArticleNumber: shoeArticleNumber,
                                        shoeColors: shoeColors,
                                        shoeSizes: shoeSizes,
                                        favourite: favourite)
                
                // Append to newArrivals
                self.newArrivals.append(shoeData)
            }
        }
    }
}
