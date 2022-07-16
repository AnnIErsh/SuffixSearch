//
//  JobScheduler.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 07.07.2022.
//

import Foundation

public final class JobScheduler {
    public var jobs: [Job] = []

    public init() {}
    
    public func createQueue(withName name: String) -> JobQueue {
        return JobQueue(name: name)
    }
    
    public func addJob(on queue: JobQueue) {
        let job = Job(queue)
        self.jobs.append(job)
    }
    
    public func removeAllJob() {
        self.jobs.removeAll()
    }
    
    public func runAllTasks(withName name: String, completion: @escaping () -> Void) {
        for job in jobs {
            if job.queue.name == name {
                job.queue.resume(task: completion)
            }
        }
    }
    
    public func stopCurrentTasks(withName name: String) {
        for job in jobs {
            if job.queue.name == name {
                job.queue.stopTask()
            }
        }
    }
}
