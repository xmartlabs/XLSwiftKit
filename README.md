# XLSwiftKit

<p align="left">
<a href="https://travis-ci.org/xmartlabs/XLSwiftKit"><img src="https://travis-ci.org/xmartlabs/XLSwiftKit.svg?branch=master" alt="Build status" /></a>
<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift3-compatible-4BC51D.svg?style=flat" alt="Swift 3 compatible" /></a>
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage compatible" /></a>
<a href="https://cocoapods.org/pods/XLSwiftKit"><img src="https://img.shields.io/cocoapods/v/XLSwiftKit.svg" alt="CocoaPods compatible" /></a>
<a href="https://raw.githubusercontent.com/xmartlabs/XLSwiftKit/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
</p>

By [Xmartlabs SRL](http://xmartlabs.com).

## Introduction

XLSwiftKit is a collection of helpers and extensions we use internally. It is a constantly being updated with new snippets. Feel free to use it or to contribute.
You can see a list of helper functions and extensions [here](#implemented-functions). Please keep that list updated if you add new functions

> XLSwiftKit 2.0 is in Swift 3 syntax. If you are developing in Swift 2 please use version 1.x

## Usage

```swift
import XLSwiftKit
// your code using XLSwiftKit
```

## Requirements

* iOS 9.2+
* Xcode 9.0+
* Swift 4

## Getting involved

* If you **want to contribute** please feel free to **submit pull requests**.
* If you **found a bug** or **need help** please **check older issues, [FAQ](#faq) and threads on [StackOverflow](http://stackoverflow.com/questions/tagged/XLSwiftKit) before submitting an issue.**.

Before contribute check the [CONTRIBUTING](https://github.com/xmartlabs/XLSwiftKit/blob/master/CONTRIBUTING.md) file for more info.

If you use **XLSwiftKit** in your app, We would love to hear about it! Drop us a line on [twitter](https://twitter.com/xmartlabs).

## Examples

Follow these 3 steps to run Example project: Clone XLSwiftKit repository, open XLSwiftKit workspace and run the *Example* project.

## Installation

#### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects.

To install XLSwiftKit, simply add the following line to your Podfile:

```ruby
pod 'XLSwiftKit', '~> 3.0'
```

#### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a simple, decentralized dependency manager for Cocoa.

To install XLSwiftKit, simply add the following line to your Cartfile:

```ogdl
github "xmartlabs/XLSwiftKit" ~> 3.0
```

## Implemented functions

This is a list of the helper functions and extensions implemented in this pod.

### Extensions

#### NSData

* `func toJSON() -> AnyObject?`: serializes a NSData object to JSON representation

#### NSDate

* `func isOver18Years() -> Bool`: returns if a date is over 18 years ago
* `func monthName() -> String`: returns the month of a date in `MMMM` format
* `func year() -> String`: returns the year of a date in `yyyy` format
* `func day() -> String`: returns the day of a date in `dd` format

#### UIApplication

* `class func topViewController(base: UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController) -> UIViewController?`: returns the top most view controller in the view hierarchy considering a base rootViewController.
* `static func changeRootViewController(rootViewController: UIViewController, animated: Bool = true, from: UIViewController? = nil, completion: ((Bool) -> Void)? = nil)`: changes the rootViewController of the applications main window
* `static func changeRootViewControllerAfterDismiss(from: UIViewController? = nil, to: UIViewController, completion: ((Bool) -> Void)? = nil)`: Same as the previous one but dismisses the current view controller before changing root view controller
* `static func makePhoneCall(phoneNumber: String) -> Bool`: Creates a NSURL with the phoneNumber parameter and opens the URL if possible.
* `var bundleIdentifier: String`
* `var buildVersion: String`
* `var appVersion: String`
* `var bundleName: String`

#### UINavigationBar

* `func setTransparent(transparent: Bool)`: Makes the navigationBar transparent or not
* `func shake(duration: CFTimeInterval = 0.3)`: Executes a shake animation on a view
* `func spin(duration: CFTimeInterval, rotations: CGFloat, repeatCount: Float)`: Spins a view around its z axis
* `static public func verticalStackView(views: [UIView], alignLeading: Bool = true, alignTrailing: Bool = true, frame: CGRect? = nil, width: CGFloat = UIScreen.mainScreen().bounds.width) -> UIView`: returns a view containing the views passed as parameter as if it was a vertical stack view (putting all views vertically one after the other). Thought to be a iOS 8 alternative to real UIStackViews

#### UIViewController

* `func showError(title: String, message: String? = nil)`: shows an UIAlertController alert with error title and message

#### Double and Int

* `func currencyString() -> String?`: Returns a formatted currency String from an Int or Double. Currency formatter used is defined under `Constants.Formatters.currencyFormatter`

#### String

* `func isValidAsEmail() -> Bool`: Returns if a string is valid as email
* `func isValidAsPhone() -> Bool`: Returns if a string is valid as phone number
* `func isNumberString() -> Bool`: Returns if a string is composed just of numbers or '-' symbol
* `func findFirstNumberInString() -> String?`: Returns the first number in a String if found
* `func renderedHeightWithFont(font: UIFont, width: CGFloat) -> CGFloat`: Return the height necessary for a text given a width and font size. Same as `heightForString` extension on UIFont
* `func getFirstAndLastName() -> (String,String)?`: Parses a first and a last name from a String. Takes last whitespace as separator for these values.
* By conforming the `String` type to `ParametrizedString` protocol and specifying a parameter format like `"{i}"`:
	* `func parametrize(parameters: CustomStringConvertible...) -> String`: Replace `"{i}"` substring with the i-th element of `parameters`. For example: `"Hey {0}! It's been {1} years!".parametrize("Arnold", 3)` gives you `"Hey Arnold! It's been 3 years!"`
	* `parametrize(withDictonary dictonary: [Int: CustomStringConvertible]) -> String`: Same behaviour as above but specifying the parameters as a dictonary.

#### UIImage

* `init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1))`
* `init(view: UIView)`
* `init(image: UIImage, scaledToSize: CGSize)`
* `class func imageWithColor(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage`
* `class func imageWithView(view: UIView) -> UIImage`
* `class func imageWithImage(image: UIImage, scaledToSize size: CGSize) -> UIImage`: Returns a new image scaled to desired size
* `func imageScaledToSize(size: CGSize) -> UIImage`: Same as previous
* `func saveToCameraRoll(completion: ((succeded: Bool) -> Void)? = nil)`: Saves an image to Saved Photos Album


#### UITableView

* `func setFooterWithSpacing(view: UIView)`: Adds a footer to a tableView that covers the rest of the screen.
* `func reloadDataAnimated(duration: NSTimeInterval = 0.4, completion: (() -> ())?)`: Performs a `reloadData` call using a cross-dissolve transition.

#### Dictionary

* `mutating func merge(dict: [Key: Value])`: Merges two dictionaries of the same Key and Value type

#### UIColor

* `init(red: Int, green: Int, blue: Int)`: Creates a color from RGB values between 0 and 255
* `init(netHex:Int)`: Creates a color from a Hexa string

#### UIDevice

* `func maxScreenLength() -> CGFloat`: Returns the maximum screen length of the current device

The following helpers return if the device is of certain type depending on the devices `maxScreenLength`
* `func iPhone4() -> Bool`
* `func iPhone5() -> Bool`
* `func iPhone6() -> Bool`
* `func iPhone6Plus() -> Bool`

Other helpers:
* `fontSizeForDevice(size: CGFloat, q6: CGFloat = 0.94, q5: CGFloat = 0.86, q4: CGFloat = 0.80) -> CGFloat`: Returns the suggested font size for every device (iPhone only).

#### UIFont

* `func heightForString(string: NSString, width: CGFloat) -> CGFloat`: Return the height necessary for a text given a width and font size. Same as `renderedHeightWithFont` extension on String


### Helpers

#### Constraints

* `func suggestedVerticalConstraint(value: CGFloat, q6: CGFloat = 0.9, q5: CGFloat = 0.77, q4: CGFloat = 0.65) -> CGFloat`: Scale a value for a vertical constraint constant depending on the current device. Works for iPhone apps only. All coefficients have reasonable default values for vertical constraints
* `func suggestedHorizontalConstraint(value: CGFloat, q6: CGFloat = 0.9, q5: CGFloat = 0.77, q4: CGFloat = 0.77) -> CGFloat`: Scale a value for a horizontal constraint constant depending on the current device. Works for iPhone apps only. All coefficients have reasonable default values for horizontal constraints

#### Appearances

This is a publis struct with functions inside:
* `static func removeBackImageIndicatorFromNavigationBar()`: Removes the navigation bars backIndicator image

#### GCDHelper

* `static let mainQueue: DispatchQueue`: Returns the main queue
* `static let backgroundQueue: DispatchQueue`: Returns a background queue
* `static func delay(_ delay: Double, block: @escaping () -> ())`: Executes a block after a given delay
* `static func runOnMainThread(_ block: @escaping () -> ())`: Executes a block on the main thread
* `static func runOnBackgroundThread(_ block: @escaping () -> ())`: Executes a block on the background queue
* `static func synced(_ lock: AnyObject, closure: () -> ())`: Locks an object

#### Box

Box is a Wrapper: e.g. Used to wrap any structs in a class so that they can be used where AnyObject is required

#### Views

* `RoundedView`, `RoundedImageView` and `RoundedButton` are subclasses of `UIView`, `UIImageView` and `UIButton` with a rounded appearance.
* `GradientView` renders a gradient from an array of colors and a direction specified by the `colors` and `direction` properties. It spreads the colors evenly through the space.
* `OwnerView` is intended to wrap xib views in order to reuse them in storyboards and also instantiate them in code.
	* Usage
		* Create a subclass of `OwnerView`
		* Set it as the File's Owner of your xib.
		* Connect your xib's view outlets to your subclass if any.
		* Override `func viewForContent() -> UIView?` to provide the xib's view.
		* Override `func setup()` to initialize the view. Your xib's view will be accessible through the `contentView` property.

#### Others

* `public func JSONStringify(value: AnyObject, prettyPrinted: Bool = true) -> String`: Converts a JSON object to a printable String


## Author

* [Xmartlabs SRL](https://github.com/xmartlabs) ([@xmartlabs](https://twitter.com/xmartlabs))

# Change Log

This can be found in the [CHANGELOG.md](CHANGELOG.md) file.
