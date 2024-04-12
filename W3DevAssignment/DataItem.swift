//
//  DataItem.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 11/04/24.
//

import Foundation
import SwiftData

@Model
class DataItem: Identifiable {
    var id : String
    var shoeName: String
    var shoeImage: String
    var shoePrice: String
    var shoeRating: Double
    var shoeArticleNumber: String
    var shoeColors: [String]
    var shoeSizes: [Int]
    var favourite: Bool
    
    init( shoeName: String, shoeImage: String, shoePrice: String, shoeRating: Double, shoeArticleNumber: String, shoeColors: [String], shoeSizes: [Int], favourite: Bool) {
        self.id = UUID().uuidString
        self.shoeName = shoeName
        self.shoeImage = shoeImage
        self.shoePrice = shoePrice
        self.shoeRating = shoeRating
        self.shoeArticleNumber = shoeArticleNumber
        self.shoeColors = shoeColors
        self.shoeSizes = shoeSizes
        self.favourite = favourite
    }
}

//@Model
//class Profile: Identifiable{
//    var id : String
//    var image : String
//    var name: String
//    
//    
//    init(id: String, image: String, name: String) {
//        self.id = id
//        self.image = image
//        self.name = name
//    }
//}
//struct ProfileData{
//    var id : String
//    var image : String
//    var name: String
//    
//}
