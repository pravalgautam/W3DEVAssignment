//
//   PaymentConfig .swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 11/04/24.
//

import Foundation

class PaymentConfig {
    
    var paymentIntentClientSecret: String?
    static var shared: PaymentConfig = PaymentConfig()
    
    private init() { }
}
