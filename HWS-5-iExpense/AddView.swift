//
//  AddView.swift
//  HWS-5-iExpense
//
//  Created by Vaibhav Ranga on 21/05/24.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @Environment(\.dismiss) private var dismiss
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)

            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let expense = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(expense)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
