//
//  ContentView.swift
//  HWS-5-iExpense
//
//  Created by Vaibhav Ranga on 21/05/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    var amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let data = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(data, forKey: "Items")
            }
        }
    }
    
    var personalItems: [ExpenseItem] {
        return items.filter { item in
            item.type == "Personal"
        }
    }
    
    var businessItems: [ExpenseItem] {
        return items.filter { item in
            item.type == "Business"
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ListItem: View {
    var expense: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                
                Text(expense.type)
            }
            Spacer()
            
            if expense.amount <= 100 {
                Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .foregroundStyle(.green)
            } else if expense.amount <= 1000 {
                Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .foregroundStyle(.orange)
            } else {
                Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .foregroundStyle(.red)
            }
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpenseSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                if !expenses.personalItems.isEmpty {
                    Section("Personal") {
                        ForEach(expenses.items) { item in
                            if item.type == "Personal" {
                                ListItem(expense: item)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
                
                if !expenses.businessItems.isEmpty {
                    Section("Business") {
                        ForEach(expenses.items) { item in
                            if item.type == "Business" {
                                ListItem(expense: item)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpenseSheet = true
                }
            }
            .sheet(isPresented: $showingAddExpenseSheet) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func deleteItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView()
}
