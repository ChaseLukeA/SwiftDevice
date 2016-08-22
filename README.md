#SwiftDevice

Instantly get the type and orientation of your iOS device for doing different things in code!

SwiftDevice is a friendly implementation of Apple's UIDevice.currentDevice().orientation and UIDevice.currentDevice().UIInterfaceOrientation return values.

---

##Background

I wanted a much simpler, friendly way to access the device type and orientation of the iOS device an app is currently running on for programatically changing things based on what device I'm using and how I'm holding it. Hence SwiftDevice's `Device` came into existence. Since I didn't really care if the device was being held LandscapeLeft or LandscapeRight, or if it was PortraitUpsideDown, I ommitted those options and just use 'Portrait' and 'Landscape' instead.

---

##About and Usage

No initialization or declaration is needed to use SwiftDevice. Just use `Device` by calling `Device.[method]` anywhere you need to get the device's type (`Device.type()`), orientation (`Device.orientation()`), or both (`Device.typeAndOrientation()`)

There are three different `.[value]` enums that `Device` uses (which can be used directly with Device.[ENUM_NAME].[value] but aren't required to be):

```
TYPE:
  Unspecified
  Phone
  Pad
  TV
  CarPlay

ORIENTATION:
  Unknown
  Portrait
  Landscape

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

---

How does this differ from Apple's way? Normally if you wanted to know your device type, you'd type:

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

...And if you still really wanted the exact, detailed orientations that Apple provides instead:

```
// returns same as UIDevice.currentDevice().orientation
Device.orientationDetail()
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

pod 'SwiftDevice', '0.1.4' 
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
