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
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searched
            .debounce(for: .milliseconds(1000), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] res in
                self?.debounced = res
            })
            .store(in: &subscriptions)
    }
}
