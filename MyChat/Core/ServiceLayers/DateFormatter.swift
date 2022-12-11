//
//  DateFormatter.swift
//  MyChat
//
//  Created by Сергей Штейман on 10.12.2022.
//

import Foundation


final class Formatter {
    private static let formatter = DateFormatter()
    
    static func formatDate(_ date: Date?, format: FormatType) -> String? {
        guard let date = date else {
            return nil
        }
        formatter.dateFormat = format.rawValue
        return formatter.string(from: date)
    }
    
    static func formatString(_ string: String?, format: FormatType) -> Date? {
        guard let string = string else {
            return nil
        }
        formatter.dateFormat = format.rawValue
        return formatter.date(from: string)
    }
}

enum FormatType: String {
    case yyyyMMdd = "yyyy-MM-dd"
    case ddMMyyyy = "dd.MM.yyyy"
}
//
//final class HoroscopeWorker {
//    static func fetchHoroscope(from date: Date?) -> HoroscopeType {
//        guard let date = date else {
//            return .horoscope
//        }
//
//    }
//}
//
//enum HoroscopeType: String {
//    case oven = "Овен"
//    case horoscope = "Гороскоп"
//}
