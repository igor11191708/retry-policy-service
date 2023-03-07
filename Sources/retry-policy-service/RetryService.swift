//
//  RetryService.swift
//  
//
//  Created by Igor on 06.03.2023.
//

import Foundation


/// Generate sequence of time delays between retries depending on retry strategy
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct RetryService: Sequence{
        
    /// Default service
    static let `default` = RetryService(strategy: .exponential())
    
    /// Retry strategy
    public let strategy: Strategy
    
    /// - Parameter strategy: Retry strategy ``RetryService.Strategy``
    public init(strategy: Strategy){
        self.strategy = strategy
    }
       
    /// - Returns: Retry delays iterator
    public func makeIterator() -> RetryIterator {
        return RetryIterator(service: self)
    }
}




