//
//  Expense.swift
//  HWS-5-iExpense
//
//  Created by Vaibhav Ranga on 15/06/24.
//

import Foundation
import SwiftData

@Model
class Expense {
    let id = UUID()
    var title: String
    var type: String
    var amount: Double?
    var timeStamp: Date
    
    init(title: String, type: String, amount: Double?, timeStamp: Date) {
        self.title = title
        self.type = type
        self.amount = amount
        self.timeStamp = timeStamp
    }
}
