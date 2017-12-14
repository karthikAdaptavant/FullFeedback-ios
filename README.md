# FullFeedback

[![CI Status](http://img.shields.io/travis/karthikAdaptavant/FullFeedback.svg?style=flat)](https://travis-ci.org/karthikAdaptavant/FullFeedback)
[![Version](https://img.shields.io/cocoapods/v/FullFeedback.svg?style=flat)](http://cocoapods.org/pods/FullFeedback)
[![License](https://img.shields.io/cocoapods/l/FullFeedback.svg?style=flat)](http://cocoapods.org/pods/FullFeedback)
[![Platform](https://img.shields.io/cocoapods/p/FullFeedback.svg?style=flat)](http://cocoapods.org/pods/FullFeedback)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements



## Installation

FullFeedback is available through [CocoaPods](http://cocoapods.org/pods/FullFeedback). To install
it, simply add the following line to your Podfile:

```ruby'
platform :ios, '10.0'
pod 'FullFeedback'
```
## Usage
    
    * Note: By default we have a dictionary with 5 key value pairs i.e, Model - iPhone, DeviceType - iPhone 6, SystemName - iPhone OS, Version - 9.3.5, DeviceName - yourDeviceName. Addition to these properties if you want to add more you can provide them in device info dictionary.
    
    import FullFeedback
    
    guard let feedbackvc = FeedbackViewController.initialize(loopToDoKey: "Your loopTodo key", feedbackCardTitle: "Feedback card title") else {
            return
        }
        
        // userName -> Logged in userName
        feedbackvc.userName = "user name"
        feedbackvc.userEmail = "user email"
        
        feedbackvc.appInfo = [:]
        feedbackvc.deviceInfo = [:]
        feedbackvc.userInfo = [:]
        
        self.present(feedbackvc, animated: true, completion: nil)
                                   
## Author

Vamsi Venkata, venkata.vamsi@full.co

## License

FullFeedback is available under the MIT license. See the LICENSE file for more info.
