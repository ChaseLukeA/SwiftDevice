//
//  Device.swift
//  SwiftDevice
//
//  Created by Luke A Chase on 8/4/16.
//
//  Copyright © 2016 ChaseLukeA. All rights reserved.
//

import UIKit

public class Device : NSObject {
    
    /**
     The physical type of the device
     */
    public enum TYPE : Int {
        case Unspecified       // = 0
        case Phone             // = 1
        case Pad               // = 2
        case TV                // = 3
        case CarPlay           // = 4
    }
    
    /**
     The screen orientation of the device
     */
    public enum ORIENTATION : Int {
        case Unknown           // = 0
        case Portrait          // = 1
        case Landscape         // = 2
    }
    
    /**
     The physical type and screen orientation of the device
     
     Math at its finest! The combination of both TYPE and ORIENTATION is the sum of the TYPE [in the tens place] and the ORIENTATION [in the ones place]
     */
    public enum TYPE_AND_ORIENTATION : Int {
        case UnspecifiedPortrait  = 0
        case UnspecifiedLandscape = 1
        case UnspecifiedUnknown   = 2
        case PhoneUnknown         = 10
        case PhonePortrait        = 11
        case PhoneLandscape       = 12
        case PadUnknown           = 20
        case PadPortrait          = 21
        case PadLandscape         = 22
        case TVUnknown            = 30
        case TVPortrait           = 31
        case TVLandscape          = 32
        case CarPlayUnknown       = 40
        case CarPlayPortrait      = 41
        case CarPlayLandscape     = 42
    }
    
    /**
     The battery status of the device
     */
    public enum BATTERY_STATUS : Int {
        case Unknown
        case Charging
        case Full
        case Unplugged
    }
    
    /**
     The proximity to user of the device
     */
    public enum PROXIMITY_TO_USER : Int {
        case Unknown
        case CloseToUser
        case AwayFromUser
    }
    
    /**
     
     Get the "physical type" of device currently being used
     - returns:
     .Phone / .Pad / .TV / .CarPlay / .Unspecified
     */
    public class func type() -> TYPE {
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            return .Phone
        case .Pad:
            return .Pad
        case .TV:
            return .TV
        case .CarPlay:
            return .CarPlay
        default:
            return .Unspecified
        }
    }
    
    /**
     Get the "screen orientation" of the device currently being used
     
     - returns:
     .Portrait / .Landscape / .Unknown
     */
    public class func orientation() -> ORIENTATION {
        switch UIDevice.currentDevice().orientation {
        case .Portrait:
            return .Portrait
        case .PortraitUpsideDown:
            return .Portrait
        case .LandscapeLeft:
            return .Landscape
        case .LandscapeRight:
            return .Landscape
        default:
            return .Unknown
        }
    }
    
    /**
     Get the [fully Apple-specified] "screen orientation" of the device currently being used
     
     - returns:
     .Portrait / .PortraitUpsideDown / .LandscapeLeft / .LandscapeRight / .FaceUp / .FaceDown / .Unknown
     */
    public class func orientationDetail() -> UIDeviceOrientation {
        return UIDevice.currentDevice().orientation
    }
    
    /**
     Get the "physical type and screen orientation" of the device currently being used
     
     - returns:
     .UnspecifiedPortrait / .UnspecifiedLandscape / .UnspecifiedUnknown / .PhoneUnknown / .PhonePortrait / .PhoneLandscape / .PadUnknown / .PadPortrait / .PadLandscape / .TVUnknown / .TVPortrait / .TVLandscape / .CarPlayUnknown / .CarPlayPortrait / .CarPlayLandscape
     */
    public class func typeAndOrientation() -> TYPE_AND_ORIENTATION {
        let device = (self.type().rawValue * 10) + self.orientation().rawValue
        return TYPE_AND_ORIENTATION.init(rawValue: device)!
    }
    
    /**
     Enable the current device's battery monitoring
     */
    public class func enableBatteryMonitor() -> Bool {
        UIDevice.currentDevice().batteryMonitoringEnabled = true
        return UIDevice.currentDevice().batteryMonitoringEnabled
    }
    
    /**
     Disable the current device's battery monitoring
     */
    public class func disableBatteryMonitor() -> Bool {
        UIDevice.currentDevice().batteryMonitoringEnabled = true
        return UIDevice.currentDevice().batteryMonitoringEnabled
    }

    /**
     Get the "battery charging status" of the device currently being used; auto-enables battery monitor
     
     - returns:
     .Charging / .Full / .Unplugged / .Unknown
     */
    public class func batteryStatus() -> BATTERY_STATUS {
        if !UIDevice.currentDevice().batteryMonitoringEnabled {
            self.enableBatteryMonitor()
        }

        switch UIDevice.currentDevice().batteryState {
        case .Charging:
            return .Charging
        case .Full:
            return .Full
        case .Unplugged:
            return .Unplugged
        default:
            // battery monitor error OR status is truly unknown
            return .Unknown
        }
    }
    
    /**
     Get the "current battery level" of the device currently being used
     
     - returns:
     Float of [0.0] to [100.0] for percent full / [-1.0] for no value detected
     */
    public class func batteryLevel() -> Float {
        if UIDevice.currentDevice().batteryMonitoringEnabled {
            return UIDevice.currentDevice().batteryLevel
        } else {
            return -1.0
        }
    }
    
    /**
     Enable the current device's proximity monitor
     */
    public class func enableProximityMonitor() -> Bool {
        UIDevice.currentDevice().proximityMonitoringEnabled = true
        return UIDevice.currentDevice().proximityMonitoringEnabled
    }
    
    /**
     Disable the current device's proximity monitor
     */
    public class func disableProximityMonitor() -> Bool {
        UIDevice.currentDevice().proximityMonitoringEnabled = true
        return UIDevice.currentDevice().proximityMonitoringEnabled
    }
    
    /**
     Get the "proximity to the user" of the device currently being used; auto-enables proximity monitor

     
     - returns:
     .CloseToUser / .AwayFromUser / .Unknown
     */
    public class func proximityToUser() -> PROXIMITY_TO_USER {
        if !UIDevice.currentDevice().proximityMonitoringEnabled {
            if !self.enableProximityMonitor() {
              return .Unknown
            }
        }

        switch UIDevice.currentDevice().proximityState {
        case true:
            return .CloseToUser
        case false:
            return .AwayFromUser
        }
    }
    
    /**
     Get the "device name" of the device currently being used
     
     - returns:
     String containing the device name
     */
    public class func name() -> String {
        return UIDevice.currentDevice().name
    }
    
    /**
     Get the "device model" of the device currently being used
     
     - returns:
     String containing the device model
     */
    public class func model() -> String {
        return UIDevice.currentDevice().model
    }
    
    /**
     Get the "operating system name" of the device currently being used
     
     - returns:
     String containing the device operating system name
     */
    public class func osName() -> String {
        return UIDevice.currentDevice().systemName
    }
    
    /**
     Get the "operating system version" of the device currently being used
     
     - returns:
     String containing the device operating system version number
     */
    public class func osVersion() -> String {
        return UIDevice.currentDevice().systemVersion
    }
    
    /**
     Get the "operating system name and version" of the device currently being used
     
     - returns:
     String containing the device operating system name and version number
     */
    public class func os() -> String {
        return self.osName() + " " + self.osVersion()
    }
    
    /**
     Get the "id for vendor" of the device currently being used
     
     - returns:
     Strinc containing the "identification for vendor" string
     */
    public class func idForVendor() -> String {
        return (UIDevice.currentDevice().identifierForVendor?.UUIDString)!
    }
    
    /**
     Get whether the device currently being used "has physical GPS hardware or not"
     
     - returns:
     Boolean
     
     - Note:
     The GPS capability of the device returned is based on the actual hardware identifier that Apple uses for its devices (example: iPad5,3); the device list was created with a combination of Apple's official [iOS Device Compatibility Reference](https://developer.apple.com/library/ios/documentation/DeviceInformation/Reference/iOSDeviceCompatibility/DeviceCompatibilityMatrix/DeviceCompatibilityMatrix.html) and hardware identifiers from [EveryMac.com](http://www.everymac.com/)
     */
    public class func hasGPS() -> Bool {
        // NOTE: I chose the "non-capable" devices for this list because this list is a whole lot smaller
        let nonGPSCapableDevices: [String] = [
            "iPhone1,1",
            "iPod1,1",
            "iPod2,1",
            "iPod3,1",
            "iPod4,1",
            "iPod5,1",
            "iPad1,1",
            "iPad2,1",
            "iPad2,4",
            "iPad2,5",
            "iPad2,6",
            "iPad3,1",
            "iPad3,4",
            "iPad4,1",
            "iPad4,4",
            "iPad4,7",
            "iPad5,1",
            "iPad5,3",
            "iPad6,3",
            "iPad6,7",
        ]
        
        let hardware = self.hardwareIdentifier()
        
        if hardware != "Unknown" {
            return nonGPSCapableDevices.contains(hardware)
        } else { // an error getting hardware identifier string occurred
            return false
        }
    }
    
    /**
     Get the "hardware identifier" of the device currently being used (example "iPad5,3")
     
     - returns:
     String containing device hardware identifier string
     
     ***Credit:*** this code is a modified version of the DeviceGuru.swift function hardwareString() from [DeviceGuru](https://github.com/InderKumarRathore/DeviceGuru)
     */
    public static func hardwareIdentifier() -> String {
        var name: [Int32] = [CTL_HW, HW_MACHINE]
        var size: Int = 2
        sysctl(&name, 2, nil, &size, &name, 0)
        var hw_machine = [CChar](count: Int(size), repeatedValue: 0)
        sysctl(&name, 2, &hw_machine, &size, &name, 0)
        
        if let hardware = String.fromCString(hw_machine) {
            // check if device is a simulator
            if hardware == "i386" || hardware == "x86_64" {
                return self.name()
            } else {
                return hardware
            }
        } else { // an error getting hardware identifier string occurred
            return "Unknown"
        }
    }
    
}
