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
    
    * Note: By default we are having a dictionary with 5 key value pairs i.e, Model - iPhone, DeviceType - iPhone 6, SystemName - iPhone OS, Version - 9.3.5, DeviceName - yourDeviceName. Addition to these properties if you want to add more you can provide them in device info dictionary.
    
          we provided you with properties: left button title, left button image , left button title color, right button title, right button image, right button title color, segmented control background color, segmented control tint color, nav bar color, and statusbar style.
    
  
    import FullFeedback
    
    guard let feedbackvc = FeedbackViewController.initialize(loopToDoKey: "agtzfmxvb3BhYmFja3IRCxIETG9vcBiAgKDBl8iYCww", feedbackCardTitle: "Test Pod Feedback") else {
            return
        }
        
        feedbackvc.userName = "Venkata vamsi"
        feedbackvc.userEmail = "venkata.vamsi@full.co"
        
        feedbackvc.appInfo = ["appVersion": 11, "appName": "MyApp"]
        feedbackvc.deviceInfo = ["deviceaaa": "dfsfe"]
        feedbackvc.userInfo = ["Name": "vamsi"]
        
        self.present(feedbackvc, animated: true, completion: nil)
                                   
## Author

Vamsi Vekata, venkata.vamsi@full.co

## License

FullFeedback is available under the MIT license. See the LICENSE file for more info.
