#SwiftDevice

Instantly get detailed information (such as type, orientation, and GPS capabilities) on your iOS device for doing different things in code!

SwiftDevice is a friendly implementation of Apple's UIDevice.currentDevice() methods and properties, plus a little more detailed information.

---

##Background

I wanted a much simpler, friendly way to access the device type and orientation of the iOS device an app is currently running on for programatically changing things based on what device I'm using and how I'm holding it. Hence SwiftDevice's `Device` came into existence. Since I didn't really care if the device was being held LandscapeLeft or LandscapeRight, or if it was PortraitUpsideDown, I ommitted those options and just use 'Portrait' and 'Landscape' instead.

Upon using these functions, I discovered I also wanted to know if my device physically supported GPS or not, what version of the iOS operating system I was running, and more. So I implemented other methods to report a lot more cool stuff.

---

##About and Usage

No initialization or declaration is needed to use SwiftDevice. Just use `Device` by calling `Device.[method]()` anywhere you need information about your device.

***The methods are:***

`Device.type()` - Get the "physical type" (i.e. "iPad")

```
  TYPE:
    Unspecified
    Phone
    Pad
    TV
    CarPlay
```

`Device.orientation()` - Get the "screen orientation" of the device (i.e. "Landscape")

```
  ORIENTATION:
    Unknown
    Portrait
    Landscape
```

`Device.orientationDetail()` - Get the [fully Apple-specified] "screen orientation" of the device (in case you REALLY need to know specifically which direction it was turned, but that doesn't usually matter)

```
  UIDeviceOrientation:
    Portrait
    PortraitUpsideDown
    LandscapeLeft
    LandscapeRight
    FaceUp
    FaceDown
    Unknown
```

`Device.typeAndOrientation()` - Get the "physical type and screen orientation" of the device (i.e. "PhonePortrait", "PadLandscape")

```
  TYPE_AND_ORIENTATION:
    UnspecifiedPortrait
    UnspecifiedLandscape
    UnspecifiedUnknown
    PhoneUnknown
    PhonePortrait
    PhoneLandscape
    PadUnknown
    PadPortrait
    PadLandscape
    TVUnknown
    TVPortrait
    TVLandscape
    CarPlayUnknown
    CarPlayPortrait
    CarPlayLandscape
```

`Device.batteryStatus()` - Get the "battery charging status" of the device (i.e. "Charging", "Unplugged")

```
  BATTERY_STATUS:
    Unknown
    Charging
    Full
    Unplugged
```

`Device.batteryLevel()` - Get the "current battery level" of the device (i.e. 75.0)

`Device.proximityToUser()` - Get the "proximity to the user" of proximity sensor (if enabled) of the device (i.e. "CloseToUser")

```
  PROXIMITY_TO_USER:
    Unknown
    CloseToUser
    AwayFromUser
```

`Device.name()` - Get the "name" of the device, as found in Settings > General > About 

`Device.model()` - Get the "model" of the device (i.e "iPod touch")

`Device.osName()` - Get the "operating system name" of the device (i.e. "iPhone OS")

`Device.osVersion()` - Get the "operating system version" of the device (i.e. 9.2)

`Device.os()` - Get the "operating system name and version" of the device (i.e. "iPad OS 8.1") 

`Device.idForVendor()` - Get the "identification for vendor" string of the device (i.e. "AC295404-B9DA-4645-B13F-E89E36B94153")

`Device.hasGPS()` - Get the "GPS capability" of the device (i.e. "False" means "does not have GPS!")

`Device.hardwareIdentifier()` - Get the "hardware identifier" of the device (i.e. "iPad5,3")

---

There are a few different `.[value]` enums that `Device` uses, which can be used directly with Device.[ENUM_NAME].[value], but aren't required to be

You can use these types as an assigned variable:

```
// infers variable is type Device.TYPE_AND_ORIENTATION
let myDevice = Device.typeAndOrientation()
```

Then access it later like so, without the need for `[something] == Device.TYPE_AND_ORIENTATION.PhoneLandscape`:

```
if myDevice == .PhoneLandscape {
	// do something great!
}
```

Or access it directly like so:

```
if Device.proximityToUser() == .CloseToUser {
  // do something like shut the screen off -- they can't see the screen when their phone is against their ear!
}
```

---

How does this `Device` class differ from Apple's provision? Normally if you wanted to know your device type or orientation, you'd type this:

```
// returns an enum like .LandscapeLeft or .PortraitUpsideDown
UIDevice.currentDevice().UIInterfaceOrientation

// returns an enum like .Pad or .Phone
UIDevice.currentDevice().orientation
```

With SwiftDevice's `Device` object, you can type this instead:

```
// returns a simpler enum like .Landscape or .Portrait
Device.orientation()

// still returns an enum like .Pad or .Phone
Device.type()
```

The *best part* I've added is the ability to get both type *and* orientation in the same call:

```
// returns an enum like .PadLandscape or .PhonePortrait
Device.typeAndOrientation()
```

---

## Examples of Use

Example checking if an iPad is being used in Landscape mode (because Auto Layout won't let you set constraints different for Portrait and Landscape on an iPad):

```
if Device.typeAndOrientation() == .PadLandscape {
	// do something different for Pad in Lanscape
} else {
	// do the default thing
}
```

Example checking if a device is in Landscape or Portrait for deciding if a top logo should stay showing when the keyboard pushes the view up when using Auto Layout:

```
	@IBOutlet weak var logoImage: UIImageView!  // some logo image at the top of your view
	@IBOutlet weak var signInButton: UIButton!  // outlet to the sign-in button in your view
	...
	override func viewDidLoad() {
		// your keyboard notification observer initialization code
	}
	...
	func yourKeyboardIsGoingToShowMethod(notification: NSNotification) {
	    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
	        let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
	            
	        let keyboardTop = self.view.frame.height - keyboardSize.size.height
	        let signInButtonBottom = signInButton.frame.origin.y + signInButton.frame.height
	        let changeHeight = ceil(signInButtonBottom - keyboardTop) + keyboardMargin
	            
	        if changeHeight > 0 {
	            if Device.typeAndOrientation() == .PhoneLandscape {
	                logoImage.hidden = true  // completely hide the image if using an iPhone in Lanscape
	            } else {
	            	// do something like shrink the image the same amount the sign-in button needs to come up
	            }
	            
	            self.view.frame.origin.y -= changeHeight / 2  // push the view up so the sign-in button sits on top of the keyboard
	            
	            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
	                self.view.layoutIfNeeded()
	            })
	        }
	    }
	}
```

---

## Quick Start

Add to your Xcode project's Podfile:

```
use_frameworks!

pod 'SwiftDevice', '0.2.1' 
```

...Install it to your project:

```
$ pod install
```

...Open your project in Xcode from the .xcworkspace file:

```
$ open MyProject.xcworkspace
```

...And import the SwiftDevice framework into your files:

```
import SwiftDevice
```

---

##Credits

SwiftDevice was created and is maintained by Luke A Chase [chase.luke.a@gmail.com](mailto:chase.luke.a@gmail.com) | [ChaseLukeA on Github](http://github.com/ChaseLukeA).
