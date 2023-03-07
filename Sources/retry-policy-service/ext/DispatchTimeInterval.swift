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
        
        let result: Double?

        switch self {
        case .seconds(let value):
            result = Double(value)
        case .milliseconds(let value):
            result = Double(value)*0.001
        case .microseconds(let value):
            result = Double(value)*0.000001
        case .nanoseconds(let value):
            result = Double(value)*0.000000001

        case .never:
            result = nil
        @unknown default:
            result = nil
        }

        return result
    }
}
