//
//  FeedScreen.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 09.07.2022.
//

import SwiftUI

struct FeedScreen: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var historyViewModel: HistoryViewModel

    private var items: [(String, TimeInterval)] {
        historyViewModel.items
    }
    
    private var sorted: [Double] {
        var arr: [Double] = []
        for i in items {
            arr.append(i.1)
        }
        return arr.sorted(by: <)
    }

    var body: some View {
        Button("dismiss") {
            dismiss()
        }
        List {
            ForEach(items.indices, id: \.self) { i in
                HStack {
                    Text(items[i].0.description)
                    Spacer()
                    Text("\(items[i].1)")
                }
                .listRowBackground(Color.timeColor(value: items[i].1, sortedItems: sorted))
            }
        }
        .listStyle(.plain)
        .padding()
    }
}
