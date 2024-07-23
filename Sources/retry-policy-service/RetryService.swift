//
//  RetryIterator.swift
//
//
//  Created by Igor on 06.03.2023.
//

import Foundation


// RetryService Definition and Implementation
@available(iOS 14.0, macOS 11.0, tvOS 15.0, watchOS 8.0, *)
public struct RetryService: Sequence {
    
    /// Default service
    static let `default` = RetryService(strategy: .exponential())
    
    /// Retry strategy
    public let strategy: Strategy
    
    /// - Parameter strategy: Retry strategy ``RetryService.Strategy``
    public init(strategy: Strategy) {
        self.strategy = strategy
    }
    
    /// - Returns: Retry delays iterator
    public func makeIterator() -> RetryIterator {
        return RetryIterator(service: self)
    }
    
    /// Retry iterator
    @available(iOS 14.0, macOS 11.0, tvOS 15.0, watchOS 8.0, *)
    public struct RetryIterator: IteratorProtocol {
        
        /// Current amount of retries
        public private(set) var retries: UInt = 0
        
        /// Retry strategy
        public let strategy: Strategy
        
        /// A time after which stop producing sequence
        public let deadline: DispatchTime

        /// - Parameter service: Retry service ``RetryService``
        init(service: RetryService) {
            self.strategy = service.strategy
            self.deadline = .now() + strategy.timeout.toDispatchTimeInterval()
        }

        /// Returns the next delay amount in nanoseconds, or `nil`.
        public mutating func next() -> UInt64? {
            guard isValid else { return nil }
            defer { retries += 1 }
            
            switch strategy {
            case .constant(_, let duration, _):
                if let value = duration.toDouble() {
                    let delay = value * 1e+9
                    return UInt64(delay)
                }
            case .exponential(_, let multiplier, let duration, _):
                if let duration = duration.toDouble() {
                    let value = duration * pow(multiplier, Double(retries))
                    let delay = value * 1e+9
                    return UInt64(delay)
                }
            }
            return nil
        }

        /// Validate current iteration
        var isValid: Bool {
            guard deadline >= .now() else { return false }
            let max = strategy.maximumRetries
            guard max > retries && max != 0 else { return false }
            return true
        }
    }
}
