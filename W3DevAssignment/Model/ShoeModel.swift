//
//  ShoeModel.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 11/04/24.
//

import Foundation


struct ShoeData: Identifiable,Codable {
    var id = UUID()
    var shoeName: String
    var shoeImage: String
    var shoePrice: String
    var shoeRating: Double
    var shoeArticleNumber: String
    var shoeColors: [String]
    var shoeSizes: [Int]
    var favourite: Bool
}

// Create some dummy data
let dummyShoeData: [ShoeData] = [
    ShoeData(shoeName: "Air Force 1", shoeImage: "s1", shoePrice: "$100", shoeRating: 4.8, shoeArticleNumber: "987654", shoeColors: ["White", "Black"], shoeSizes: [6, 7, 8, 9, 10], favourite: true),
    ShoeData(shoeName: "Yeezy Boost 350", shoeImage: "s1", shoePrice: "$220", shoeRating: 4.6, shoeArticleNumber: "654321", shoeColors: ["Black", "Gray", "Blue"], shoeSizes: [7, 8, 9, 10, 11], favourite: true)
]
