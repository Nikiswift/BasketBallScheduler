//
//  UtilityManager.swift
//  BasketBallSchedule
//
//  Created by Nikhil1 Desai on 08/05/25.
//

import Foundation
import Combine
import SwiftUI

enum JSONLoader {
    static func loadJSON<T: Decodable>(filename: String, type: T.Type) -> AnyPublisher<T, Error> {
        Future<T, Error> { promise in
            guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
                return promise(.failure(NSError(domain: "Invalid file path", code: 0)))
            }
            do {
                let data = try Data(contentsOf: url)
                let decoded = try JSONDecoder().decode(T.self, from: data)
                promise(.success(decoded))
            } catch {
                promise(.failure(error))
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
enum AppConstants {
    static let AppNameID = "1610612748"
}
enum DateUtils {
    static func date(from isoString: String?) -> Date {
        guard let isoString = isoString else { return Date() }
        
        // Remove milliseconds part if it exists
        var formattedString = isoString
        if isoString.contains(".") {
            formattedString = isoString.components(separatedBy: ".")[0] + "Z"
        }
        
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: formattedString) ?? Date()  // Return current date if parsing fails
    }
    static func formatted(_ date: Date, dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .short) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: date)
    }
    static func formattedStatusLine(status: Int?) -> String {
        let statusText: String = {
            switch status {
            case 1: return "Upcoming"
            case 2: return "Live"
            case 3: return "Final"
            default: return "Unknown"
            }
        }()
        return statusText
    }
    
    static func formatDayMonthDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"
        return formatter.string(from: date)
    }
    
    static func formatDayMonthDate(from isoString: String?) -> String {
        guard let isoString = isoString else { return "" }
        
        // Convert to Date object
        let date = date(from: isoString)
        
        // Format the Date object into the desired string format "E, MMM d"
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"
        return formatter.string(from: date)
    }
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255,
                            (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255,
                            int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            if shouldShow { placeholder() }
            self
        }
    }
}
