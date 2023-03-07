//
//  RetryIterator.swift
//  
//
//  Created by Igor on 06.03.2023.
//

import Foundation


public extension RetryService{
    
    /// Retry iterator
     @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
     struct RetryIterator: IteratorProtocol {
         
         /// Current amount of retries
        public private(set) var retries: UInt = 0
         
         /// Retry strategy
         public let strategy: Strategy
         
         /// A time after which stop producing sequence
         public let deadline : DispatchTime

         
         /// - Parameter service: Retry service ``RetryService``
        init(service: RetryService){
            
            self.strategy = service.strategy
            
            deadline =  .now().advanced(by: strategy.timeout)
        }

        /// Returns the next delay amount in nanoseconds, or `nil`.
        public mutating func next() -> UInt64? {

            guard isValid else { return nil }
           
            defer { retries += 1 }
            
            switch strategy {
                case .constant(_, let duration, _):
                if let value = duration.toDouble(){
                    let delay  = value * 1e+9
                    return UInt64(delay)
                }
                case .exponential(_, let multiplier, let duration, _):
                if let duration = duration.toDouble(){
                    let value = duration * (pow(multiplier, Double(retries)))
                    let delay  = value * 1e+9
                    return UInt64(delay)
                }
            }

            return nil
        }

         /// Validate current iteration
         var isValid: Bool{
             
             guard deadline >= .now() else {
                 return false
             }
             
             let max = strategy.maximumRetries
             guard max > retries && max != 0 else { return false }
             
             return true
         }
    }
}
