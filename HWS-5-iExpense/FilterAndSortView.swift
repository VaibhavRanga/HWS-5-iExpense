//
//  FilterView.swift
//  HWS-5-iExpense
//
//  Created by Vaibhav Ranga on 16/06/24.
//

import SwiftData
import SwiftUI

struct FilterAndSortView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                NavigationLink(value: expense) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(expense.title)
                            Text(expense.type)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        
                        Text(expense.amount ?? 0, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
            }
            .onDelete(perform: deleteExpense)
        }
        .scrollBounceBehavior(.basedOnSize)
    }
    
    func deleteExpense(at offsets: IndexSet) {
        for index in offsets {
            let expense = expenses[index]
            modelContext.delete(expense)
        }
    }
    
    init(filterExpenseType: ExpenseType, sortOrder: [SortDescriptor<Expense>]) {
        if filterExpenseType == .all {
            _expenses = Query(sort: sortOrder)
        } else if filterExpenseType == .personal {
            _expenses = Query(filter: #Predicate<Expense> { expense in
                expense.type == "Personal"
            }, sort: sortOrder)
        } else if filterExpenseType == .business {
            _expenses = Query(filter: #Predicate<Expense> { expense in
                expense.type == "Business"
            }, sort: sortOrder)
        }
    }
}

#Preview {
    FilterAndSortView(filterExpenseType: .all, sortOrder: [SortDescriptor(\Expense.timeStamp)])
}
