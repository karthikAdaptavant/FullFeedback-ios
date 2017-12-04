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

```ruby
pod 'FullFeedback'
```
## Usage

import FullFeedback

        let obj = FeedbackHelper()
    
        guard let feedbackvc = obj.getFeedbackViewController(loopToDoKey: "Your loopToDoKey") else {
            return
        }
        
        params should be in the form of {
        "applicationInfo": {
                "login": "optional",
                "version": 10
        },
        "DeviceInfo": {
                "deviceName": "User's device",
                "deviceModel": "Your device model",
                "Device Os version": 11.2
        }

example :   let params = ["ApplicationInfo": ["version": 1, "login": "vamsi"],
                      "DeviceInfo": ["DeviceName": "mymobile", "DeviceOsVersion": 11.2]]
                      
}
        
## Author

karthikAdaptavant, karthik.samy@a-cti.com

## License

FullFeedback is available under the MIT license. See the LICENSE file for more info.
