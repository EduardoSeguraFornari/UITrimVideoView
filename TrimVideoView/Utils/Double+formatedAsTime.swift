//
//  Double+formatedAsSeconds.swift
//
//  Copyright © 2019 Fornari. All rights reserved.
//

extension Double {

    var formatedAsTime: String {
        var formated = ""
        var minutes = 0
        var seconds = Int(self)

        while seconds >= 60 {
            seconds -= 60
            minutes += 1
        }
        // format minutes
        if minutes < 10 {
            formated += "0\(minutes):"
        } else {
            formated += "\(minutes):"
        }
        // format seconds
        if seconds < 10 {
            formated += "0\(seconds):"
        } else {
            formated += "\(seconds):"
        }
        // format milliseconds
        let timeAsInt = Int(self)
        let milliseconds = Int((self - Double(timeAsInt)) * 10000)
        if milliseconds < 10 {
            formated += "000\(milliseconds)"
        } else if milliseconds < 100 {
            formated += "00\(milliseconds)"
        } else if milliseconds < 1000 {
            formated += "0\(milliseconds)"
        } else {
            formated += "\(milliseconds)"
        }
        return formated
    }

}
