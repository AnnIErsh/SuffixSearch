//
//  ContentView.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 02.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var sel = 0
    @State var currentHead = Modes.norm
    @ObservedObject var textViewModel: TextViewModel = .init()
    
    var body: some View {
        TabView(selection: $sel) {
            TextScreen()
                .tag(0)
                .tabItem {
                    Label("Text", systemImage: "square.and.pencil")
                }
            AllSuffixScreen()
                .tag(1)
                .tabItem {
                    Label("All", systemImage: "line.horizontal.3.decrease")
                }
            SortScreen(currentHead: $currentHead)
                .tag(2)
                .tabItem {
                    Label("Sort", systemImage: "table.fill")
                }
        }
        .environmentObject(TextViewModel())
        .padding()
    }
}
