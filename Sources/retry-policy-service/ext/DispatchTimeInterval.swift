//
//  DispatchTimeInterval.swift
//  
//
//  Created by Igor on 07.03.2023.
//

import Foundation

import Foundation

// DispatchTimeInterval Extension for toDouble method
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

extension DispatchTimeInterval {
    func toDispatchTimeInterval() -> DispatchTimeInterval {
        switch self {
        case .seconds(let value):
            return .seconds(value)
        case .milliseconds(let value):
            return .milliseconds(value)
        case .microseconds(let value):
            return .microseconds(value)
        case .nanoseconds(let value):
            return .nanoseconds(value)
        case .never:
            return .never
        @unknown default:
            return .never
        }
    }
}
