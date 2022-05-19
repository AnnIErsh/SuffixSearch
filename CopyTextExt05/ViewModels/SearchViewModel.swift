//
//  SearchViewModel.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 18.05.2022.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    @Published var debounced: String = ""
    @Published var searched: String = ""
    
    var getString: String? {
        if (debounced.count < 3) { return nil }
        let str = String(debounced.suffix(3))
        return str
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searched
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] res in
                self?.debounced = res
            })
            .store(in: &subscriptions)
    }
}
