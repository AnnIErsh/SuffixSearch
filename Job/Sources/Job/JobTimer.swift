//
//  JobTimer.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 09.07.2022.
//

import Foundation

public final class JobTimer {
    
public class func calculateTime(completion: () -> Void) -> TimeInterval {
        let begin = CFAbsoluteTimeGetCurrent()
        completion()
        let diff = CFAbsoluteTimeGetCurrent() - begin
        print("from timer", diff)
        return diff
    }
}
