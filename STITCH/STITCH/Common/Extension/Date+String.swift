//
//  Date+String.swift
//  STITCH
//
//  Created by neuli on 2023/03/19.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func toDisplay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd(E) a h:mm"
        return dateFormatter.string(from: self)
    }
    
    func toDisplayHour24() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd(E) H:mm"
        return dateFormatter.string(from: self)
    }
    
    func toDisplay(startDate: Date, duration: Int) -> String {
        let calendar = Calendar.current
        guard let updatedDate = calendar.date(byAdding: .minute, value: duration, to: startDate) else { return "" }
        let startDateString = startDate.toDisplayHour24()
        let updateDateString = updatedDate.toDisplayHour24().components(separatedBy: " ")[1]
        
        return "\(startDateString)~\(updateDateString)"
    }
    
    func addTime(hour: Int, minute: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        return calendar.date(byAdding: dateComponents, to: self) ?? Date()
    }
    
    func hour() -> Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: self)
    }
    
    func minute() -> Int {
        let calendar = Calendar.current
        return calendar.component(.minute, from: self)
    }
}
