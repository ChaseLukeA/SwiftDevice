//
//  Device.swift
//  Swift
//
//  Created by Luke A Chase on 8/4/16.
//
//  Copyright © 2016 ChaseLukeA. All rights reserved.
//

import UIKit

struct Device {
    enum TYPE : Int {
        case Unspecified  // 0
        case Phone        // 1
        case Pad          // 2
        case TV           // 3
        case CarPlay      // 4
    }
    
    enum ORIENTATION : Int {
        case Unknown             // 0
        case Portrait            // 1
        case Landscape           // 2
    }
    
    enum TYPE_AND_ORIENTATION : Int {
        case UnspecifiedPortrait = 0
        case UnspecifiedLandscape = 1
        case UnspecifiedUnknown = 2
        case PhoneUnknown = 10
        case PhonePortrait = 11
        case PhoneLandscape = 12
        case PadUnknown = 20
        case PadPortrait = 21
        case PadLandscape = 22
        case TVUnknown = 30
        case TVPortrait = 31
        case TVLandscape = 32
        case CarPlayUnknown = 40
        case CarPlayPortrait = 41
        case CarPlayLandscape = 42
    }
    
    static func type() -> TYPE {
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
    
    // Get *all* specific orientations provided by Apple; additional orientations:
    // PortraitUpsideDown, LandscapeLeft, LandscapeRight, FaceUp, FaceDown
    static func orientationDetail() -> UIDeviceOrientation {
        return UIDevice.currentDevice().orientation
    }
    
    static func orientation() -> ORIENTATION {
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
    
    static func typeAndOrientation() -> TYPE_AND_ORIENTATION {
        let device = (type().rawValue * 10) + orientation().rawValue
        return TYPE_AND_ORIENTATION.init(rawValue: device)!
    }
}