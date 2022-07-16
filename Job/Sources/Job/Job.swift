import Foundation

public class Job {
    public var queue: JobQueue
    
    init(_ queue: JobQueue) {
        self.queue = queue
    }
}
