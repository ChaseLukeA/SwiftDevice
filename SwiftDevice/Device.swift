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
     Device type enum
     */
    public enum TYPE : Int {
        case Unspecified       // = 0
        case Phone             // = 1
        case Pad               // = 2
        case TV                // = 3
        case CarPlay           // = 4
    }
    
    /**
     Device orientation enum
     */
    public enum ORIENTATION : Int {
        case Unknown           // = 0
        case Portrait          // = 1
        case Landscape         // = 2
    }
    
    /**
     Device type and orientation enum
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
     Get the "type" of device currently being used.
     
     - returns:
        enum TYPE : Int {
            case Phone
            case Pad
            case TV
            case CarPlay
            case Unspecified
        }
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
     Get the "orientation" of the device currently being used.
     
     - returns:
        enum ORIENTATION : Int {
            case Portrait
            case Landscape
            case Unknown
        }
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
     Get the [full Apple-specified] "orientation" of the device currently being used.
     
     - returns:
        enum UIDeviceOrientation : Int {
            case Unknown
            case Portrait
            case PortraitUpsideDown
            case LandscapeLeft
            case LandscapeRight
            case FaceUp
            case FaceDown
        }
     */
    public class func orientationDetail() -> UIDeviceOrientation {
        return UIDevice.currentDevice().orientation
    }
    
    /**
     Get the "type and orientation" of the device currently being used.
     
     - returns:
        enum TYPE_AND_ORIENTATION : Int {
            case UnspecifiedPortrait
            case UnspecifiedLandscape
            case UnspecifiedUnknown
            case PhoneUnknown
            case PhonePortrait
            case PhoneLandscape
            case PadUnknown
            case PadPortrait
            case PadLandscape
            case TVUnknown
            case TVPortrait
            case TVLandscape
            case CarPlayUnknown
            case CarPlayPortrait
            case CarPlayLandscape
        }
     */
    public class func typeAndOrientation() -> TYPE_AND_ORIENTATION {
        let device = (type().rawValue * 10) + orientation().rawValue
        return TYPE_AND_ORIENTATION.init(rawValue: device)!
    }
}
