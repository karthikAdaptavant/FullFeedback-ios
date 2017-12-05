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

    Note :  After pod install, go to pods targets then select FullFeedback pod, there you should include feedback storyboard in copy Bundle Resources and remove from compile sources if feedback storyboard is present there.
    
    import FullFeedback

        let obj = FeedbackHelper()
    
        guard let feedbackvc = obj.getFeedbackViewController(loopToDoKey: "Your loopToDoKey") else {
            return
        }
        
        Parameter structure should be:  
        
          {
          "applicationInfo": {
            "login": "optional",
            "version": 10
          },
          "DeviceInfo": {
            "deviceName": "User's device",
            "deviceModel": "Your device model",
            "Device Os version": 11.2
          }
        }
                              
## Author

Vamsi Vekata, venkata.vamsi@full.co

## License

FullFeedback is available under the MIT license. See the LICENSE file for more info.
