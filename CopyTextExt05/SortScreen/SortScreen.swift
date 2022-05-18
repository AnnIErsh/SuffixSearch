//
//  SortScreen.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 04.05.2022.
//

import SwiftUI

struct SortScreen: View {
    @EnvironmentObject var textViewModel: TextViewModel
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
        NavigationView {
            table
                .searchable(text: $searchText)
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
            randoms
        }
        .padding()
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
}
