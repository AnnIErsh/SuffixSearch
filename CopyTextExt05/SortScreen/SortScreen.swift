//
//  SortScreen.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 04.05.2022.
//

import SwiftUI

struct SortScreen: View {
    @EnvironmentObject var textViewModel: TextViewModel
    @StateObject var searchedTextModel: SearchViewModel = .init()
    @Binding var currentHead: Modes
    @State var searchText: String = ""

    var searchResults: [Any] {
        if searchText.isEmpty {
            return textViewModel.topOrNorm
        } else {
            return textViewModel.topOrNorm.filter {
                let str = String(($0 as AnyObject).description).lowercased()
                return str.contains(searchText.lowercased())
            }
        }
    }
            
    var body: some View {
        VStack {
            if currentHead == .tops { }
            else  {
                searchTops
            }
            table
                .onReceive(searchedTextModel.$debounced) { res in
                    searchText = res
            }
        }
    }
                
    var table: some View {
        VStack {
            Picker("Show: ", selection: $currentHead, content: {
                ForEach(ModeNames.shared.modes.indices, id:\.self) { i in
                    Text(ModeNames.shared.modes[i].rawValue)
                        .tag(ModeNames.shared.modes[i])
                }
                .onChange(of: currentHead) { newValue in
                    textViewModel.mode = newValue
                }
            })
            .pickerStyle(.segmented)
            listToShow
        }
        .padding()
    }
    
    private var listToShow: AnyView {
        switch currentHead {
        case .norm, .asc, .des:
            return randoms
        case .tops:
            return topTens
        }
    }
    
    private var randoms: AnyView {
        return AnyView(
            List {
                let uniques = searchResults
                ForEach(uniques.indices, id: \.self) { i in
                    HStack {
                        Text(String((uniques[i] as AnyObject).description))
                        let numb = textViewModel.uniques.count(for: uniques[i])
                        Spacer()
                        Text("\(Int.showNumber(n: numb))")
                    }
                }
            }
        )
    }
    
    private var topTens: AnyView {
        return AnyView(
            List {
                let sorted = textViewModel.sortByAppearances()                
                ForEach(sorted.indices, id: \.self) { i in
                    HStack {
                        Text(String((sorted[i] as AnyObject).description))
                        Spacer()
                        let count = textViewModel.tops.count(for: sorted[i])
                        Text("\(Int.showNumber(n: count))")
                            .foregroundColor(.blue)
                    }
                }
            }
        )
    }
    
    private var searchTops: some View {
        HStack {
            TextField("Enter smth.....", text: $searchedTextModel.searched)
            Spacer()
            Button("submit") {
                textViewModel.showTopTen(searched: searchResults as! [Suffix])
                searchedTextModel.searched = ""
            }
            .disabled(searchedTextModel.searched.isEmpty)
        }
    }
}
