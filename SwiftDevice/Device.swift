//
//  Device.swift
//  Swift
//
//  Created by Luke A Chase on 8/4/16.
//
//  Copyright © 2016 ChaseLukeA. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2016 Luke A Chase
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
    
    static func getType() -> TYPE {
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
    
    // Get all specific orientations provided by Apple
    //   - adds PortraitUpsideDown, LandscapeLeft, LandscapeRight, FaceUp, FaceDown
    static func getOrientationDetail() -> UIDeviceOrientation {
        return UIDevice.currentDevice().orientation
    }
    
    static func getOrientation() -> ORIENTATION {
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
    
    static func getTypeAndOrientation() -> TYPE_AND_ORIENTATION {
        let TYPE = getType()
        let ORIENTATION = getOrientation()
        let device = TYPE.rawValue * 10 + ORIENTATION.rawValue
        return TYPE_AND_ORIENTATION.init(rawValue: device)!
    }
}