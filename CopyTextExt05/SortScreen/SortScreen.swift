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

    var suffixes: [Suffix] {
        return textViewModel.setOrderSuffix(currentHead: currentHead)
    }
        
    var body: some View {
        table
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
        case .norm, .tops:
            return randoms
        case .asc, .des:
            return sortView
        }
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
                let uniques = textViewModel.topOrNorm
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
