//
//  HWS_5_iExpenseApp.swift
//  HWS-5-iExpense
//
//  Created by Vaibhav Ranga on 21/05/24.
//

import SwiftData
import SwiftUI

@main
struct HWS_5_iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
