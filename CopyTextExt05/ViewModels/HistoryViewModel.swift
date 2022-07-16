//
//  HistoryViewModel.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 10.07.2022.
//

import Foundation
import Job

final class HistoryViewModel: ObservableObject {
    @Published var items: [(String, TimeInterval)] = []
    var service: JobScheduler = .init()
    var testTime: TimeInterval?

    func createSearchJob() {
        let q = service.createQueue(withName: "Search")
        service.addJob(on: q)
    }
    
    func run(completionJob: @escaping () -> Void) {
        service.runAllTasks(withName: "Search") {
            self.testTime = JobTimer.calculateTime(completion: {
                completionJob()
            })
        }
    }
    
    func stop() {
        service.stopCurrentTasks(withName: "Search")
        service.removeAllJob()
    }
}
