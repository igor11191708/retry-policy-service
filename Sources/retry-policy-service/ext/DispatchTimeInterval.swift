//
//  DispatchTimeInterval.swift
//  
//
//  Created by Igor on 07.03.2023.
//

import Foundation

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension DispatchTimeInterval {
    
    /// Convert to Double
    /// - Returns: Converted value
    func toDouble() -> Double? {
        switch self {
        case .seconds(let value):
            return Double(value)
        case .milliseconds(let value):
            return Double(value) / 1000.0
        case .microseconds(let value):
            return Double(value) / 1_000_000.0
        case .nanoseconds(let value):
            return Double(value) / 1_000_000_000.0
        case .never:
            return nil
        @unknown default:
            return nil
        }
    }
}
