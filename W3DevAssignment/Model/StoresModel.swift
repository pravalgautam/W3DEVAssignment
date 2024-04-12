//
//  StoresModel.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 12/04/24.
//

import Foundation

struct Store: Identifiable {
    let id = UUID()
    let name: String
    let state: String
}

let stores = [
    Store(name: "Mumbai Mart", state: "Maharashtra"),
    Store(name: "Chennai Supermarket", state: "Tamil Nadu"),
    Store(name: "Bengaluru Bazaar", state: "Karnataka"),
    Store(name: "Kolkata Corner", state: "West Bengal"),
    Store(name: "Delhi Depot", state: "Delhi"),
    Store(name: "Hyderabad Hypermarket", state: "Telangana"),
    Store(name: "Ahmedabad Shoppe", state: "Gujarat"),
    Store(name: "Jaipur Junction", state: "Rajasthan"),
    Store(name: "Lucknow Local", state: "Uttar Pradesh"),
    Store(name: "Pune Plaza", state: "Maharashtra"),
    Store(name: "Surat Store", state: "Gujarat"),
    Store(name: "Kanpur Corner", state: "Uttar Pradesh"),
    Store(name: "Nagpur Mart", state: "Maharashtra"),
    Store(name: "Indore Market", state: "Madhya Pradesh"),
    Store(name: "Thane Thrift", state: "Maharashtra"),
    Store(name: "Bhopal Bazaar", state: "Madhya Pradesh"),
    Store(name: "Visakhapatnam Value", state: "Andhra Pradesh"),
    Store(name: "Patna Plaza", state: "Bihar"),
    Store(name: "Vadodara Venue", state: "Gujarat"),
    Store(name: "Ludhiana Local", state: "Punjab"),
    Store(name: "Agra Alley", state: "Uttar Pradesh"),
    Store(name: "Nashik Neighborhood", state: "Maharashtra"),
    Store(name: "Ranchi Roadside", state: "Jharkhand"),
    Store(name: "Meerut Market", state: "Uttar Pradesh"),
    Store(name: "Rajkot Retail", state: "Gujarat"),
    Store(name: "Srinagar Store", state: "Jammu and Kashmir"),
    Store(name: "Amritsar Arcade", state: "Punjab"),
    Store(name: "Allahabad Avenue", state: "Uttar Pradesh"),
    Store(name: "Howrah Haven", state: "West Bengal"),
    Store(name: "Jabalpur Junction", state: "Madhya Pradesh"),
    Store(name: "Dhanbad Depot", state: "Jharkhand"),
    Store(name: "Gwalior Goods", state: "Madhya Pradesh"),
    Store(name: "Vijayawada Value", state: "Andhra Pradesh"),
    Store(name: "Jodhpur Junction", state: "Rajasthan"),
    Store(name: "Raipur Retail", state: "Chhattisgarh"),
    Store(name: "Kota Kiosk", state: "Rajasthan"),
    Store(name: "Guwahati Gallery", state: "Assam"),
    Store(name: "Chandigarh Corner", state: "Punjab"),
    Store(name: "Solapur Store", state: "Maharashtra"),
    
]
