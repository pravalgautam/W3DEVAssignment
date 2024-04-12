//
//  CartManager.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 11/04/24.
//
import Foundation

class CartManager: ObservableObject {
    @Published private(set) var items: [ShoeData] = []
    
    var cartTotal: Double {
        return items.reduce(0) { result, product in
            if let shoePrice = Double(product.shoePrice) {
                return result + shoePrice
            } else {
                
                return result
            }
        }
    }
    
    var cartCount: Int {
        return items.count
    }
    
    func addToCart(_ item: ShoeData) {
        items.append(item)
    }
}
