# Retry service provides policy for how often some operation should happen with the timeout limit

## API

There are two strategies
- constant - constant delay between retries
- exponential - Exponential backoff is a strategy in which you increase the delays between retries

```swift
        /// constant delay between retries
        case constant(
            retry : UInt = 5,
            duration: DispatchTimeInterval = .seconds(2),
            timeout: DispatchTimeInterval = .seconds(Int.max)
        )
        
        /// Exponential backoff is a strategy in which you increase the delays between retries.
        case exponential(
            retry : UInt = 3,
            multiplier: Double = 2.0, // The power exponent
            duration: DispatchTimeInterval = .seconds(2),
            timeout: DispatchTimeInterval = .seconds(Int.max)
        )

```

## How to use

```swift
final class ViewModel : ObservableObject{
    
    func constant() async {
        let policy = RetryService(strategy: .constant())
        for delay in policy{
            try? await Task.sleep(nanoseconds: delay)
            // do something
        }
    }
    
    func exponential() async {
        let policy = RetryService(
                strategy: .exponential(
                retry: 5, 
                multiplier: 2, 
                duration: .seconds(1), 
                timeout: .seconds(5)
               )
             )
                
        for delay in policy{
            try? await Task.sleep(nanoseconds: delay)
                        // do something
        }
    }
}

struct ContentView: View {
    
    @StateObject var model = ViewModel()
    
    var body: some View {
        VStack {
            Button("constatnt") { Task { await model.constant() } }
            Button("exponential") { Task { await model.exponential() } }
        }
        .padding()
        .task {
            await model.exponential()
        }
        
    }
}
```

## Packages using the package

[Async http client](https://github.com/The-Igor/async-http-client)

## SwiftUI example for the package

[example for retry service](https://github.com/The-Igor/retry-policy-service-example)
