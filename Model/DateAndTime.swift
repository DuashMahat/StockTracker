//
//  DateAndTime.swift
//  stockTrackers
//
//  Created by Duale on 7/10/19.
//  Copyright © 2019 Duale. All rights reserved.
//

import Foundation
import UIKit


class DateAndTime {
    var date = Date()
    var formatter = DateFormatter()
    var result = "";
    
    init (date : Date,  formatter: DateFormatter) {
        formatter.dateFormat = "yyyy-MM-dd"
        self.date = date
        self.formatter = formatter
        result = formatter.string(from: date)
    }
    
    func getDate () -> String {
        return result
    }
    
}
