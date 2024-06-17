//
//  ContentView.swift
//  HWS-5-iExpense
//
//  Created by Vaibhav Ranga on 21/05/24.
//

import SwiftData
import SwiftUI

enum ExpenseType: CaseIterable {
    case all
    case personal
    case business
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = [
        SortDescriptor(\Expense.timeStamp),
        SortDescriptor(\Expense.amount)
    ]
    
    @State private var path = [Expense]()
    
    @State private var filterByExpenseType: ExpenseType = .all
    
    var body: some View {
        NavigationStack(path: $path) {
            FilterAndSortView(filterExpenseType: filterByExpenseType, sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .navigationDestination(for: Expense.self) { expense in
                AddEditExpenseView(expense: expense)
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    let expense = Expense(title: "", type: "Personal", amount: nil, timeStamp: .now)
                    
                    modelContext.insert(expense)
                    path = [expense]
                }
                
                Menu("Filter Expenses") {
                    Picker("Filter Expenses", selection: $filterByExpenseType) {
                        ForEach(ExpenseType.allCases, id: \.self) { type in
                            Text("\(type)")
                        }
                    }
                }
                
                Menu("Sort Expenses", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort Expenses", selection: $sortOrder) {
                        Text("Sort by Time Edited")
                            .tag([
                                SortDescriptor(\Expense.timeStamp),
                                SortDescriptor(\Expense.amount)
                            ])
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\Expense.amount),
                                SortDescriptor(\Expense.timeStamp)
                            ])
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
