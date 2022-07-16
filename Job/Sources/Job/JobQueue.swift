//
//  JobQueue.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 07.07.2022.
//

import Foundation

public class JobQueue {
    var name: String
    public var testTime: TimeInterval?
    
    private var taskActor: JobActor {
        JobActor(withName: self.name)
    }
    
    public init(name: String) {
        self.name = name
    }
    
    private actor JobActor {
        var name: String
        var completions: [() async -> Void] = []
        var currentTask: Task<Void, Never>? = nil
        var ended: Bool = false
        
        init(withName name: String) {
            self.name = name
        }
        
        func addTask(task: @escaping () async -> Void) {
            completions.append(task)
            execute()
        }
        
        func execute() {
            if currentTask != nil {
                return
            }
            if !completions.isEmpty {
                let task = completions.removeFirst()
                currentTask = Task {
                    await task()
                    currentTask = nil
                    ended = false
                    execute()
                }
            }
            else {
                self.ended = true
                print("the end")
            }
        }
        
        func stopTask() {
            self.ended = true
            currentTask?.cancel()
        }
    }
    
    func resume(task: @escaping () async -> Void) {
        Task {
            if await !taskActor.ended {
                await taskActor.addTask(task: task)
            }
        }
    }
    
    func stopTask() {
        Task {
            await taskActor.stopTask()
        }
    }
}
