//
//  Strategy.swift
//  
//
//  Created by Igor on 06.03.2023.
//

import Foundation

public extension RetryService{
    
    /// Retry strategy
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    enum Strategy {
        
        /// constant delay between retries
        case constant(
            retry : UInt = 5,
            duration: DispatchTimeInterval = .seconds(2),
            timeout: DispatchTimeInterval = .seconds(Int.max)
        )
        
        /// Exponential backoff is a strategy in which you increase the delays between retries.
        case exponential(
            retry : UInt = 3,
            multiplier: Double = 2.0,
            duration: DispatchTimeInterval = .seconds(2),
            timeout: DispatchTimeInterval = .seconds(Int.max)
        )
        
        /// Max amount of retries
        var maximumRetries: UInt{
            switch self{
                case .constant(let retry, _, _) : return retry
                case .exponential(let retry, _, _, _) : return retry
            }
        }
        
        /// Duration between retries For .exponential multiply on the amount of the current retries
        var duration: DispatchTimeInterval{
            switch self{
                case .constant(_, let duration, _) : return duration
                case .exponential(_, _, let duration, _) : return duration
            }
        }
        /// Max time before stop iterating
        var timeout: DispatchTimeInterval{
            switch self{
                case .constant(_, _, let timeout) : return timeout
                case .exponential(_, _, _, let timeout) : return timeout
            }
        }
    }
}



