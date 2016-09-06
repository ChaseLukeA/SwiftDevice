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
     The physical type of the device (read-only)
     
     Possible values:
     .Phone / .Pad / .TV / .CarPlay / .Unspecified
     */
    public static var type: TYPE {
        get {
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
    }
    
    /**
     The screen orientation of the device (read-only)
     
     Possible values:
     .Portrait / .Landscape / .Unknown
     */
    public static var orientation: ORIENTATION {
        get {
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
    }
    
    /**
     The [fully Apple-specified] screen orientation of the device (read-only)
     
     Possible values:
     .Portrait / .PortraitUpsideDown / .LandscapeLeft / .LandscapeRight / .FaceUp / .FaceDown / .Unknown
     */
    public static var orientationDetail: UIDeviceOrientation {
        get {
            return UIDevice.currentDevice().orientation
        }
    }
    
    /**
     The physical type and screen orientation of the device (read-only)
     
     Possible values:
     .UnspecifiedPortrait / .UnspecifiedLandscape / .UnspecifiedUnknown / .PhoneUnknown / .PhonePortrait / .PhoneLandscape / .PadUnknown / .PadPortrait / .PadLandscape / .TVUnknown / .TVPortrait / .TVLandscape / .CarPlayUnknown / .CarPlayPortrait / .CarPlayLandscape
     */
    public static var typeAndOrientation: TYPE_AND_ORIENTATION {
        get {
            let device = (self.type.rawValue * 10) + self.orientation.rawValue
            return TYPE_AND_ORIENTATION.init(rawValue: device)!
        }
    }
    
    /**
     Retrieve, enable, and disable the current device's battery monitoring
     
     The default system state is `battery monitoring disabled`. To set a new battery monitoring state: `Device.batteryMonitored = true` or `Device.batteryMonitored = false`
     
     Possible values:
     true / false
     */
    public static var batteryMonitored: Bool {
        get {
            return UIDevice.currentDevice().batteryMonitoringEnabled
        }
        set {
            UIDevice.currentDevice().batteryMonitoringEnabled = !UIDevice.currentDevice().batteryMonitoringEnabled
        }
    }
    
    /**
     The battery charging status of the device (read-only)
     
     - Note: battery monitoring must be enabled to retrieve the charging status. Use `Device.batteryMonitored` to retrieve the battery monitoring status, to enable it, or to disable it.
     
     Possible values:
     .Charging / .Full / .Unplugged / .Unknown
     */
    public static var batteryStatus: BATTERY_STATUS {
        get {
            switch UIDevice.currentDevice().batteryState {
            case .Charging:
                return .Charging
            case .Full:
                return .Full
            case .Unplugged:
                return .Unplugged
            default:
                // UIDevice.currentDevice().batteryMonitoringEnabled is 'false' OR state is truly unknown
                return .Unknown
            }
        }
    }
    
    /**
     The current battery level of the device (read-only)
     
     - Note: battery monitoring must be enabled to retrieve the battery level. Use `Device.batteryMonitored` to retrieve the battery monitoring status, to enable it, or to disable it.
     
     Possible values:
     [0.0] for empty to [1.0] for full (decimal percentage)
     [-1.0] for no value detected
     */
    public static var batteryLevel: Float {
        get {
            if UIDevice.currentDevice().batteryMonitoringEnabled {
                return UIDevice.currentDevice().batteryLevel
            } else {
                return -1.0
            }
        }
    }
    
    /**
     Retrieve, enable, and disable the current device's proximity monitoring
     
     The default system state is `proximity monitoring disabled`. To set a new proximity monitoring state: `Device.proximityMonitored = true` or `Device.proximityyMonitored = false`
     
     Possible values:
     true / false
     */
    public static var proximityMonitored: Bool {
        get {
            return UIDevice.currentDevice().proximityMonitoringEnabled
        }
        set {
            UIDevice.currentDevice().proximityMonitoringEnabled = !UIDevice.currentDevice().proximityMonitoringEnabled
        }
    }
    
    /**
     The proximity of the device to the user (read-only)
     
     - Note: proximity monitoring must be enabled to retrieve the proximity of the device to the user. Use `Device.proximityMonitored` to retrieve the proximity monitoring status, to enable it, or to disable it.
     
     Possible values:
     .CloseToUser / .AwayFromUser / .Unknown
     */
    public static var proximityToUser: PROXIMITY_TO_USER {
        get {
            if Device.proximityMonitored {
                switch UIDevice.currentDevice().proximityState {
                case true:
                    return .CloseToUser
                case false:
                    return .AwayFromUser
                }
            } else {
                return .Unknown
            }
        }
    }
    
    /**
     The name of device (read-only)
     
     Possible values:
     String containing the device name
     */
    public static var name: String {
        get {
            return UIDevice.currentDevice().name
        }
    }
    
    /**
     The model of the device (read-only)
     
     Possible values:
     String containing the device model
     */
    public static var model: String {
        get {
            return UIDevice.currentDevice().model
        }
    }
    
    /**
     The name of the operating system running on the device (read-only)
     
     Possible values:
     String containing the device operating system name
     */
    public static var osName: String {
        get {
            return UIDevice.currentDevice().systemName
        }
    }
    
    /**
     The version of the operating system running on the device (read-only)
     
     Possible values:
     String containing the device operating system version number
     */
    public static var osVersion: String {
        get {
            return UIDevice.currentDevice().systemVersion
        }
    }
    
    /**
     The name and version of the operating system running on the device (read-only)
     
     Possible values:
     String containing the device operating system name and version number
     */
    public static var os: String {
        get {
            return self.osName + " " + self.osVersion
        }
    }
    
    /**
     The identification of the device for vendor (read-only)
     
     - Note:
     Determinded by data provided by App Store (example: App Store ID), otherwise the app's bundle ID (example: com.example.app)
     
     Possible values:
     Strinc containing the "identification for vendor" string
     */
    public static var idForVendor: String {
        get {
            return (UIDevice.currentDevice().identifierForVendor?.UUIDString)!
        }
    }
    
    /**
     The existence of GPS hardware on the device (read-only)
     
     Possible values:
     [true] for devices containing GPS hardware
     [false] for devices NOT containing GPS hardware
     
     - Note:
     The GPS capability of the device returned is based on the actual hardware identifier that Apple uses for its devices (example: iPad5,3); the device list was created with a combination of Apple's official [iOS Device Compatibility Reference](https://developer.apple.com/library/ios/documentation/DeviceInformation/Reference/iOSDeviceCompatibility/DeviceCompatibilityMatrix/DeviceCompatibilityMatrix.html) and hardware identifiers from [EveryMac.com](http://www.everymac.com/)
     */
    public static var hasGPS: Bool {
        get {
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
            
            let hardware = self.hardwareIdentifier
            
            if hardware != "Unknown" {
                if nonGPSCapableDevices.contains(hardware) {
                    return false
                } else {
                    return true
                }
            } else { // an error getting hardware identifier string occurred
                return false
            }
        }
    }
    
    /**
     The hardware identifier of the device [example: iPad5,3] (read-only)
     
     Possible values:
     String containing device hardware identifier string
     
     ***Credit:*** this code is a modified version of the DeviceGuru.swift function hardwareString() from [DeviceGuru](https://github.com/InderKumarRathore/DeviceGuru)
     */
    public static var hardwareIdentifier: String {
        get {
            var name: [Int32] = [CTL_HW, HW_MACHINE]
            var size: Int = 2
            sysctl(&name, 2, nil, &size, &name, 0)
            var hw_machine = [CChar](count: Int(size), repeatedValue: 0)
            sysctl(&name, 2, &hw_machine, &size, &name, 0)
            
            if let hardware = String.fromCString(hw_machine) {
                // check if device is a simulator
                if hardware == "i386" || hardware == "x86_64" {
                    return self.name
                } else {
                    return hardware
                }
            } else { // an error getting hardware identifier string occurred
                return "Unknown"
            }
        }
    }
    
}