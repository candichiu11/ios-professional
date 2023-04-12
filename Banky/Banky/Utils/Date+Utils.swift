//
//  Date+Utils.swift
//  Banky
//
//  Created by Candi Chiu on 09.04.23.
//

import Foundation

extension Date {
    static var bankyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "CET")
        return formatter
    }
    
    var dayMonthYearString: String {
        let dateFormatter = Date.bankyDateFormatter
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
}
