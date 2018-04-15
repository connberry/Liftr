//
//  Stopwatch.swift
//  Liftr2
//
//  Created by Connor Berry on 15/04/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import Foundation

class Stopwatch
{
    private var startTime: Date?
    var elapsedTime: TimeInterval {
        if let startTime = self.startTime
        {
            return -startTime.timeIntervalSinceNow
        } else {return 0}
    }
    var isRunning: Bool
    {
        return startTime != nil
    }
    func start()
    {
        startTime = Date()
    }
    func stop()
    {
        startTime = nil
    }
}
