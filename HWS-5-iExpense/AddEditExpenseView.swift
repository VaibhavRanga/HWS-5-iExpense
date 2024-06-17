//
//  AddEditExpenseView.swift
//  HWS-5-iExpense
//
//  Created by Vaibhav Ranga on 15/06/24.
//

import SwiftData
import SwiftUI

struct AddEditExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var expense: Expense
    
    let expenseTypes = ["Personal", "Business"]
    
    var body: some View {
        Form {
            TextField("Title", text: $expense.title)
            Picker("Expense Type", selection: $expense.type) {
                ForEach(expenseTypes, id: \.self) { type in
                    Text(type)
                }
            }
            TextField("Amount", value: $expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
        .navigationTitle("Edit Expense")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .onDisappear(perform: deleteEmptyExpense)
    }
    
    func deleteEmptyExpense() {
        if expense.title.isEmpty && (expense.amount == nil || expense.amount == 0) {
            modelContext.delete(expense)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Expense.self, configurations: config)
        let expense = Expense(title: "Lunch", type: "Personal", amount: 15, timeStamp: .now)
        
        return AddEditExpenseView(expense: expense)
            .modelContainer(container)
            
    } catch {
        return Text(error.localizedDescription)
    }
}
