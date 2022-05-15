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
        let process = SortingProcess()
        let type = process.show(type: currentHead, words: textViewModel.suffixes)
        return type.names
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
            return AnyView(List {
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
        case .asc, .des:
            return AnyView(List {
                ForEach(suffixes.indices, id: \.self) { i in
                    Text(String((suffixes[i] as AnyObject).description))
                }
            })
        }
    }
}
