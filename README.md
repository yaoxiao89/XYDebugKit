# XYDebugKit
Simple Device Debugging

## Requirements
* iOS 11.0+
* Xcode 10.0+
* Swift 4.2+

## Quick Start

1. Create configurations:

```swift

let container = NSPersistentContainer(name: "Database")

let configs = [
    UserDefaultsDebugConfiguration(userDefaults: UserDefaults.standard),
    CoreDataDebugConfiguration(container: container)
]

```

2. Create DebugViewController:

```swift

let debugVC = DebugViewController(configurations: configs)

```

3. Present DebugViewController:

```swift

let viewController = ...
viewController.present(debugVC, animated: true, completion: nil)

```

## Supported Configurations
* CoreData
* FileManager
* UserDefaults
* UserNotifications

## Planned Configuration Support
* CoreBluetooth
* CoreLocation
* HealthKit
