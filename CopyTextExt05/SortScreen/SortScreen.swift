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

    var suffixes:[Suffix] {
        let words = textViewModel.setOrderSuffix(currentHead: currentHead)
        return words
    }
            
    var body: some View {
        table
            .onDisappear {
                textViewModel.resetData()
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
        case .norm:
            return normalView
        case .unique:
            return uniquesView
        case .asc, .des:
            return sortView
        }
    }
    
    private var normalView: AnyView {
        AnyView(List {
            ForEach(textViewModel.words.indices, id: \.self) { i in
                let arr = Array(textViewModel.words[i])
                let n = textViewModel.indexes[i]
                Section {
                    ForEach(arr.indices, id: \.self) { j in
                        Text(String((suffixes[n + j] as AnyObject).description))
                    }
                } header: {
                    Text(textViewModel.words[i])
                }
            }
        })
    }
    
    private var uniquesView: AnyView {
        return AnyView(
            VStack {
                randoms
                tops
            }
        )
    }
    
    private var sortView: AnyView {
        let orderedArr = Array(NSOrderedSet(array: suffixes))
        return AnyView(List {
            ForEach(orderedArr.indices, id: \.self) { i in
                HStack {
                    Text(String((orderedArr[i] as AnyObject).description))
                    let numb = textViewModel.uniques.count(for: orderedArr[i])
                    Spacer()
                    Text("\(Int.showNumber(n: numb))")
                }
            }
        })
    }
    
    private var randoms: AnyView {
        return AnyView(
            List {
                let uniques = Array(textViewModel.uniques)
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
    
    private var tops: AnyView {
        return AnyView(
            List {
                let uniques = Array(textViewModel.uniques)
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
