//
//  NSDateExt.swift
//  NSDateExt
//
//  Created by Chris Wagner on 12/10/14.
//  Copyright (c) 2014 Chris Wagner. All rights reserved.
//

import Foundation

public enum TimeUnit {
    case Seconds(Int)
    case Minutes(Int)
    case Hours(Int)
    case Days(Int)
    case Weeks(Int)
    case Years(Int)
    
    public var timeInterval: NSTimeInterval {
        switch self {
        case .Seconds(let seconds):
            return NSTimeInterval(seconds)
        case .Minutes(let minutes):
            return NSTimeInterval(minutes) * 60
        case .Hours(let hours):
            return NSTimeInterval(hours) * TimeUnit.Minutes(60).timeInterval
        case .Days(let days):
            return NSTimeInterval(days) * TimeUnit.Hours(24).timeInterval
        case .Weeks(let weeks):
            return NSTimeInterval(weeks) * TimeUnit.Days(7).timeInterval
        case .Years(let years):
            return NSTimeInterval(years) * TimeUnit.Days(365).timeInterval
        }
    }
}

private let componentFlags = NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.WeekCalendarUnit | NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.HourCalendarUnit | NSCalendarUnit.MinuteCalendarUnit | NSCalendarUnit.SecondCalendarUnit | NSCalendarUnit.WeekdayCalendarUnit | NSCalendarUnit.WeekdayOrdinalCalendarUnit

// MARK: Date Formatters

private let _shortDateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateStyle = .ShortStyle
    return formatter
}()

private let _mediumDateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateStyle = .MediumStyle
    return formatter
}()

private let _fullDateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateStyle = .FullStyle
    return formatter
}()

public extension NSDate {
    
    // MARK: Convenience Initializers
    
    public class func today() -> NSDate {
        return NSDate()
    }
    
    public class func tomorrow() -> NSDate {
        return NSDate().dateByAdding(TimeUnit.Days(1))
    }
    
    public class func yesterday() -> NSDate {
        return NSDate().dateByAdding(TimeUnit.Days(-1))
    }
    
    public var midnight: NSDate {
        let components = NSCalendar.currentCalendar().components(componentFlags, fromDate: self)
        components.second = 0
        components.minute = 0
        components.hour = 0
        
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    public var startOfDay: NSDate {
        return midnight
    }
    
    public var endOfDay: NSDate {
        let components = NSCalendar.currentCalendar().components(componentFlags, fromDate: self)
        components.second = 59
        components.minute = 59
        components.hour = 23
        
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    // MARK: Components

    private var commonComponents: NSDateComponents {
        return NSCalendar.currentCalendar().components(componentFlags, fromDate: self)
    }

    public var year: Int {
        return commonComponents.year
    }
    
    public var month: Int {
        return commonComponents.month
    }
    
    public var weekday: Int {
        return commonComponents.weekday
    }
    
    public var nthWeekday: Int {
        return commonComponents.weekdayOrdinal
    }
    
    public var day: Int {
        return commonComponents.day
    }
    
    public var hour: Int {
        return commonComponents.hour
    }
    
    public var minute: Int {
        return commonComponents.minute
    }
    
    public var seconds: Int {
        return commonComponents.second
    }
    
    // MARK: Comparisons
    
    public var isToday: Bool {
        return equalToDateIngoringTime(NSDate.today())
    }
    
    public var isTomorrow: Bool {
        return equalToDateIngoringTime(NSDate.tomorrow())
    }
    
    public var isYesterday: Bool {
        return equalToDateIngoringTime(NSDate.yesterday())
    }
    
    public func equalToDateIngoringTime(date: NSDate) -> Bool {
        let components1 = NSCalendar.currentCalendar().components(componentFlags, fromDate: self)
        let components2 = NSCalendar.currentCalendar().components(componentFlags, fromDate: date)
        return components1.year == components2.year &&
            components1.month == components2.month &&
            components1.day == components2.day
    }
    
    // MARK: Display Strings
    
    public var shortDateString: String {
        return _shortDateFormatter.stringFromDate(self)
    }
    
    public var mediumDateString: String {
        return _mediumDateFormatter.stringFromDate(self)
    }
    
    public var fullDateString: String {
        return _fullDateFormatter.stringFromDate(self)
    }
    
    // MARK: Manipulations
    
    public func dateByAdding(unit: TimeUnit) -> NSDate {
        return dateByAdding(units: unit)
    }
    
    public func dateByAdding(#units: TimeUnit...) -> NSDate {
        let components = NSDateComponents()
        for timeUnit in units {
            switch timeUnit {
            case .Seconds(let seconds):
                components.second = seconds
            case .Minutes(let minutes):
                components.minute = minutes
            case .Hours(let hours):
                components.hour = hours
            case .Days(let days):
                components.day = days
            case .Weeks(let weeks):
                components.day = weeks * 7
            case .Years(let years):
                components.year = years
            }
        }
        
        let newDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self, options: nil)
        return newDate!
    }
    
    public func dateBySubtracting(#units: TimeUnit...) -> NSDate {
        let components = NSDateComponents()
        for timeUnit in units {
            switch timeUnit {
            case .Seconds(let seconds):
                components.second = seconds
            case .Minutes(let minutes):
                components.minute = -minutes
            case .Hours(let hours):
                components.hour = -hours
            case .Days(let days):
                components.day = -days
            case .Weeks(let weeks):
                components.day = -weeks * 7
            case .Years(let years):
                components.year = -years
            }
        }
        
        let newDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self, options: nil)
        return newDate!
    }
    
    public func dateBySubtracting(unit: TimeUnit) -> NSDate {
        return dateBySubtracting(units: unit)
    }
}

public extension Int {
    
    public var years: TimeUnit {
        return .Years(self)
    }
    
    public var weeks: TimeUnit {
        return .Weeks(self)
    }
    
    public var days: TimeUnit {
        return .Days(self)
    }
    
    public var hours: TimeUnit {
        return .Hours(self)
    }
    
    public var minutes: TimeUnit {
        return .Minutes(self)
    }
    
    public var seconds: TimeUnit {
        return .Seconds(self)
    }
}

public func + (left: NSDate, right: TimeUnit) -> NSDate {
    return left.dateByAdding(right)
}

public func - (left: NSDate, right: TimeUnit) -> NSDate {
    return left.dateBySubtracting(right)
}
