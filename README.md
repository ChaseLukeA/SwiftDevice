![SwiftDevice](https://github.com/ChaseLukeA/SwiftDevice/SwiftDevice.jpg)

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

***`Device.type()`*** - Get the "physical type" (i.e. "Pad", "TV")

  ```
  TYPE:
    Unspecified
    Phone
    Pad
    TV
    CarPlay
  ```

***`Device.orientation()`*** - Get the "screen orientation" of the device (i.e. "Landscape")

  ```
  ORIENTATION:
    Unknown
    Portrait
    Landscape
  ```

***`Device.orientationDetail()`*** - Get the [fully Apple-specified] "screen orientation" of the device (in case you REALLY need to know specifically which direction it was turned, but that doesn't usually matter)

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

***`Device.typeAndOrientation()`*** - Get the "physical type and screen orientation" of the device (i.e. "PhonePortrait", "PadLandscape")

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

***`Device.batteryStatus()`*** - Get the "battery charging status" of the device (i.e. "Charging", "Unplugged"); this depends on the battery monitor being enabled, and auto-enables it if not

  ```
  BATTERY_STATUS:
    Unknown
    Charging
    Full
    Unplugged
  ```

***`Device.enableBatteryMonitor()`*** - Turns the battery monitor capability ON

***`Device.disableBatteryMonitor()`*** - Turns the battery monitor capability OFF

***`Device.batteryLevel()`*** - Get the "current battery level" of the device (i.e. 75.0)

***`Device.proximityToUser()`*** - Get the "proximity to the user" of proximity sensor (if enabled) of the device (i.e. "CloseToUser"); this depends on the proximity monitor being enabled, and auto-enables it if not

  ```
  PROXIMITY_TO_USER:
    Unknown
    CloseToUser
    AwayFromUser
  ```

***`Device.enableProximityMonitor()`*** - Turns the proximity monitor capability ON

***`Device.disableProximityMonitor()`*** - Turns the proximity monitor capability OFF

***`Device.name()`*** - Get the "name" of the device, as found in Settings > General > About 

***`Device.model()`*** - Get the "model" of the device (i.e "iPod touch")

***`Device.osName()`*** - Get the "operating system name" of the device (i.e. "iPhone OS")

***`Device.osVersion()`*** - Get the "operating system version" of the device (i.e. 9.2)

***`Device.os()`*** - Get the "operating system name and version" of the device (i.e. "iPad OS 8.1") 

***`Device.idForVendor()`*** - Get the "identification for vendor" string of the device (i.e. "AC295404-B9DA-4645-B13F-E89E36B94153")

***`Device.hasGPS()`*** - Get the "GPS capability" of the device (i.e. "False" means "does not have GPS!")

***`Device.hardwareIdentifier()`*** - Get the "hardware identifier" of the device (i.e. "iPad5,3")

---

###Method Use Examples

The different `.[value]` enums that `Device` uses could be used directly with `Device.[ENUM_NAME].[value]`, but aren't required to be. Use type inference instead!

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

Or use type inference to access it directly like so:

  ```
  if Device.proximityToUser() == .CloseToUser {
    // do something like shut the screen off -- they can't see the screen when their phone is against their ear!
  }
  ```

---

###More

So how does the `Device` class differ from Apple's provision? Readability, and additional features!

Normally if you wanted to know your device type or orientation, you'd type this:

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

A ***great feature*** added is the ability to get both type *and* orientation in the same call:

  ```
  // returns an enum like .PadLandscape or .PhonePortrait
  Device.typeAndOrientation()
  ```

How about an answer to the question "Does this device have a GPS chip in it?":

  `hasGPS()` gets the current device's hardware identifier (i.e. "iPhone1,1") and checks that against Apple's data, specifying if that device supported GPS; this is "id-based" GPS checking versus "realtime hardware-based" checking, which forces you to turn on CoreLocation and start checking numbers, which is a *lot* more involved

  ```
  // checks GPS capability of the current device's hardware identifier
  if Device.hasGPS() {
    // use CoreLocation framework to do GPS stuff
  } else {
    // Disable in-app/game GPS features
    // OR
    // try and use CoreMotion framework to "emulate" GPS instead
  }
  ```

---

##Code Samples

Example checking if an iPad is being used in Landscape mode to layout the GUI (because Auto Layout won't let you set constraints different for Portrait and Landscape on an iPad):

  ```
  if Device.typeAndOrientation() == .PadLandscape {
    // do something different for an iPad in Landscape
  } else {
    // do yer default thang
  }
  ```

Example checking if a device is in Landscape or Portrait, then controlling if a top logo should stay showing when the keyboard pushes the view up when using Auto Layout:

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

##Quick Start

Add to your Xcode project's Podfile:

  ```
  use_frameworks!

  pod 'SwiftDevice', '0.2.3'
  ```

...Install it to your project:

  ```
  $ pod install
  ```

...Open your project in Xcode from the .xcworkspace file:

  ```
  $ open [YourProjectName].xcworkspace
  ```

...And import the SwiftDevice framework into the files you want to use `Device` in:

  ```
  import SwiftDevice
  ```

---

##Credits

SwiftDevice was created and is maintained by Luke A Chase [chase.luke.a@gmail.com](mailto:chase.luke.a@gmail.com) | [ChaseLukeA on Github](http://github.com/ChaseLukeA).
