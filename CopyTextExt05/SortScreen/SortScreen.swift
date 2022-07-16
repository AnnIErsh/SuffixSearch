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
    @EnvironmentObject var historyViewModel: HistoryViewModel
    @Binding var currentHead: Modes
    @State var searchText: String = ""
    @State var testArr: [Any] = []
   
    var searchResults: [Any] {
        if searchText.isEmpty {
            return textViewModel.topOrNorm
        } else {
            print(testArr)
            return testArr
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
                    if searchText == "" {
                        testArr = []
                    }
                    else {
                        testTime()
                    }
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
                .onAppear {
                    if (textViewModel.tops == []) {
                        textViewModel.showTopTen(searched: searchResults as! [Suffix])
                    }
                    self.historyViewModel.createSearchJob()
                }
                .onDisappear {
                    self.historyViewModel.stop()
                    self.searchText = ""
                    self.searchedTextModel.searched = ""
                }
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
                        let submited = textViewModel.tops.count(for: sorted[i])
                        let wasCounted = textViewModel.uniques.count(for: sorted[i])
                        Text("\(Int.showNumber(n: submited * wasCounted))")
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
            Button("save") {
                if let time = historyViewModel.testTime {
                    let text = searchedTextModel.searched
                    let res = (text, time)
                    historyViewModel.items.append(res)
                }
                //textViewModel.showTopTen(searched: searchResults as! [Suffix])
                searchedTextModel.searched = ""
                testArr = []
            }
            .disabled(searchedTextModel.searched.isEmpty)
        }
    }
    
    func testTime() {
        if !searchText.isEmpty {
            historyViewModel.run {
                for i in textViewModel.topOrNorm {
                    let str = String((i as AnyObject).description).lowercased()
                    if str.contains(searchText.lowercased()) {
                        //sleep(1)
                        print(str)
                        self.testArr.append(str)
                    }
                }
            }
        }
    }
}
