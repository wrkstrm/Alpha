//
//  puts.swift
//  Alpha
//
//  Created by Cristian Monterroza on 12/7/14.
//  Copyright (c) 2014 wrkstrm. All rights reserved.
//

func p(message: @autoclosure () -> String,
    function: String = __FUNCTION__, file: String = __FILE__,  line: UInt = __LINE__) {
        var url = NSURL(string: file)
        var now = NSDate.now(.MinuteCalendarUnit | .SecondCalendarUnit | NSCalendarUnit.CalendarUnitNanosecond)
        if let lastPath = url?.lastPathComponent {
            println("\(now)-\(lastPath):\(function)\(line): \(message())")
        } else {
            println("\(function):\(line): \(message())")
        }
}
