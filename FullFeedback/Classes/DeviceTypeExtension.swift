//
//  DeviceTypeExtension.swift
//  Alamofire
//
//  Created by user on 12/12/17.
//

import Foundation
import UIKit

public extension UIDevice {
    
    var isIphoneX: Bool {
        return UIDevice.current.modelName == "iPhone X"
    }
    
    var xDevices: [String] {
        return ["iPhone X", "iPhone XS", "iPhone XS Max", "iPhone XR"]
    }
    
    var isXDevice: Bool {
        return xDevices.contains(UIDevice.current.modelName)
    }
    
    var isIphoneMax: Bool {
        return UIDevice.current.modelName == "iPhone XS Max"
    }
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPod5,1":
            return "iPod Touch 5"
        case "iPod7,1":
            return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            return "iPhone 4"
        case "iPhone4,1":
            return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":
            return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":
            return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":
            return "iPhone 5s"
        case "iPhone7,2":
            return "iPhone 6"
        case "iPhone7,1":
            return "iPhone 6 Plus"
        case "iPhone8,1":
            return "iPhone 6s"
        case "iPhone8,2":
            return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":
            return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":
            return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":
            return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":
            return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":
            return "iPhone X"
        case "iPhone11,2":
            return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":
            return "iPhone XS Max"
        case "iPhone11,8":
            return "iPhone XR"
        case "i386", "x86_64":
            return "Simulator"
        case ".iPhoneX":
            return "iPhone X"
        case ".iPhoneXS":
            return "iPhone XS"
        case ".iPhoneXSMax":
            return "iPhone XS Max"
        case ".iPhoneXR":
                return "iPhone XR"
        case "iPad1,1" : return "iPad"
        case "iPad2,1" : return "iPad 2 (WiFi)"
        case "iPad2,2" : return "iPad 2 (GSM)"
        case "iPad2,3" : return "iPad 2 (CDMA)"
        case "iPad2,4" : return "iPad 2 (WiFi)"
        case "iPad2,5" : return "iPad Mini (WiFi)"
        case "iPad2,6" : return "iPad Mini (GSM)"
        case "iPad2,7" : return "iPad Mini (GSM+CDMA)"
        case "iPad3,1" : return "iPad 3 (WiFi)"
        case "iPad3,2" : return "iPad 3 (GSM+CDMA)"
        case "iPad3,3" : return "iPad 3 (GSM)"
        case "iPad3,4" : return "iPad 4 (WiFi)"
        case "iPad3,5" : return "iPad 4 (GSM)"
        case "iPad3,6" : return "iPad 4 (GSM+CDMA)"
        case "iPad4,1" : return "iPad Air (WiFi)"
        case "iPad4,2" : return "iPad Air (GSM)"
        case "iPad4,3" : return "iPad Air (LTE)"
        case "iPad4,4" : return "iPad Mini 2 (WiFi)"
        case "iPad4,5" : return "iPad Mini 2 (GSM)"
        case "iPad4,6" : return "iPad Mini 2 (LTE)"
        case "iPad4,7" : return "iPad Mini 3 (WiFi)"
        case "iPad4,8" : return "iPad Mini 3 (GSM)"
        case "iPad4,9" : return "iPad Mini 3 (LTE)"
        case "iPad5,1", "iPad5,2": return "iPad Mini 4"
        case "iPad5,3" : return "iPad Air 2 (WiFi)"
        case "iPad5,4" : return "iPad Air 2 (GSM)"
        case "iPad6,11", "iPad6,12" : return "iPad 5"
        case "iPad7,5", "iPad7,6" : return "iPad 6"
        case "iPad6,3", "iPad6,4": return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8": return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2": return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4": return "iPad Pro 10.5 Inch"
        default:
            return identifier
        }
    }
}

