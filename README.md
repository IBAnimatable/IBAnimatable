![IBAnimatable](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/Hero.png)

Design and prototype customized UI, interaction, navigation, transition and animation for App Store ready Apps in Interface Builder with IBAnimatable.

![IBAnimatable hero image](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/IBAnimatable.gif)

[![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=56abf6d42c882e010057b182&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/56abf6d42c882e010057b182/build/latest)
[![Build Status](https://travis-ci.org/IBAnimatable/IBAnimatable.svg?branch=master)](https://travis-ci.org/IBAnimatable/IBAnimatable)
[![Language](https://img.shields.io/badge/language-Swift%202.2-orange.svg)](https://swift.org)
[![CocoaPods](https://img.shields.io/cocoapods/v/IBAnimatable.svg?style=flat)](http://cocoadocs.org/docsets/IBAnimatable/)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/github/license/IBAnimatable/IBAnimatable.svg?style=flat)](https://github.com/IBAnimatable/IBAnimatable/blob/master/LICENSE)

**The app was made in Interface Builder with `IBAnimatable` without a single line of code**. Due to the size of [the GIF file on Dribbble](https://dribbble.com/shots/2453933-IBAnimatable-Design-App-Store-ready-Apps-in-Interface-Builder), it only demonstrates a subset of features. We can also find the full HD version on [YouTube](https://www.youtube.com/watch?v=dvD8X6J1YLM) or [MP4 on Github](https://github.com/IBAnimatable/IBAnimatable-Misc/blob/master/Videos/IBAnimatable.mp4?raw=true)

![StoryboardPreview](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/Storyboard.jpg)

Here is the full design in a Storyboard in Interface Builder.

With `IBAnimatable`, we can design a UI in Interface Builder like what we can do in Sketch, and prototype animations in a Swift playground like what we can do in Framer. Also, we can use the output of the design directly in the production ready App.

As a designer, we love Sketch, which is a simple but yet super powerful tool to create UI. However, Sketch can't design interaction, navigation, transition and animation, and we may need another tool like Framer to design some of them. Moreover, to make an App Store ready App, we need to use Xcode and Interface Builder to implement the UI and animations. To speed up the process and minimize the waste, we create `IBAnimatable` to make Interface Builder designable and animatable.   

## Interested in Swift 3?
Please check out [swift3 branch](https://github.com/IBAnimatable/IBAnimatable/tree/swift3), we are working on cool stuff.

You can also check out [swift2.3 branch](https://github.com/IBAnimatable/IBAnimatable/tree/swift2.3) for Swift 2.3 support.

## Languages
[中文](Documentation/README.zh.md)

## Features
* From prototype to shippable App Store ready App - What you design in Interface Builder is what the App exactly looks. 
* Designer-friendly - Sketch style configuration panel on Attributes inspector (![Attributes inspector](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/AttributesInspector.png)) to lower the learning curve for using Interface Builder.   
* Animation design support in Swift playground - Similar to Framer, we can prototype animations in Swift playground to save time for running on a simulator or actual iOS devices. 
* Built-in Auto Layout support - We can use Auto Layout and Size Classes with `IBAnimatable` to support orientations and multiple iOS devices. 
* Navigation and transition support - We can use default navigation pattern in the App. `IBAnimatable` also has custom transition animators and segues to support transition animations and gesture interactions.
* Protocol-oriented programming - `IBAnimatable` uses a protocol-oriented programming paradigm. With Swift protocol extension, it is easy to support more designable or animatable features. We can even use these protocol extensions to create other custom UI elements instead of using the default ones from `IBAnimatable`.  

## Use cases
* Prototyping - Create interactive prototypes to validate ideas quickly.
* Redesigning in Interface Builder - Redesign the UI from Sketch and animations from Framer without writing any code.
* Making custom UI elements - Use `IBAnimatable` protocols to make custom UI elements. e.g. Buttons with a default color palette.

## Documentations
* [<del>Fully</del> Mostly documented API Reference](Documentation/APIs.md) 
* [How to design and prototype custom transition animation and gesture interaction in Interface Builder with IBAnimatable](Documentation/Transitions.md)

## How to run the example App
The easy way to learn and understand how powerful of `IBAnimatable`is to run the example App and play around the settings in Interface Builder. Just a few steps we can run the App as below, to see more features, we can tap on "Forget Password" button to unlock them. 😉

1) Clone the repository

```bash
$ git clone https://github.com/IBAnimatable/IBAnimatable.git
```

2) Open the workspace in Xcode

```bash
$ cd IBAnimatable
$ open IBAnimatableApp.xcodeproj
```

3) Compile and run the app on your simulator or iOS device

## How to design in Interface Builder
![](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/DesignInInterfaceBuilder.png)

To use `IBAnimatable` to design the UI and animations in Interface Builder, just follow a few steps as below:

1. Open a Storyboard or Xib file.
2. Drag and drop a UIKit element e.g. `UIView` to a `UIViewController`.
3. In Identity inspector (![Identity inspector](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/IdentityInspector.png)), configure the UI element to `Animatable` custom UI class e.g. `AnimatableView`, you can find all `Animatable` classes in [APIs.md](Documentation/APIs.md).
4. Configure the UI and animations in Attribute Inspector.


## How to animate in Swift playground
![](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/AnimateInSwiftPlayground.gif)

We can configure the animation settings in Attribute inspector. However, Interface Builder doesn't support previewing Animations, but we can still prototype animations in Swift playground. There are three sample pages to demonstrate how to design animation in Swift playground. You can find them in [IBAnimatable.playground](IBAnimatable.playground). 

1. Open IBAnimatableApp.xcodeproj
2. Select IBAnimatable Framework scheme and build it with `Command + b`
3. Select IBAnimatable.playground, choose one page in Swift playground, then click on "Assistant editor" button to split the playground. After that, select "Timeline" on the top of right-hand side to preview the animation. We can use Xcode menu "Editor" -> "Execute" to re-run the playground.

## How to animate programmatically
As you saw above, we can prototype an App fully in Interface Builder without a single line of code, but `IBAnimatable` also provides APIs to let us fully control the UI and animations. `IBAnimatable` provides simple APIs like `pop()`. We can easily call them in one line.

```swift
view.pop() // pop animation for the view
view.squeezeFadeInLeft() // squeeze and fade in from left animation
```  

You can play around with all these predefined animations in the [Swift playground Page - Predefined Animations](IBAnimatable.playground/Pages/Predefined%20Animations.xcplaygroundpage)

### Animation properties
There are some properties we can change to customize the animation. What we need to do is to set the properties and call `animate()` method to start the animation.

```swift
// Setup the animation
view.animationType = "SqueezeInLeft"
view.delay = 0.5
view.damping = 0.5
view.velocity = 2
view.force = 1

// Start the animation
view.animate()
```

You can play around with all animations with different properties in the [Swift playground Page - Animation Properties](IBAnimatable.playground/Pages/Animation%20Properties.xcplaygroundpage)

### Chaining animations
Sometimes, we need to run another animation after the previous one. With `IBAnimatable`, we can easily chain animations together to provide a sleek user experience.

```swift
// Simply put the next animation within `{}` closure as below. It is an example to pop the view after the squeeze in from the top effect.
view.squeezeInDown{ view.pop() }

// Heaps of animations have been chained together, it is the source code of animated GIF in "Animate in Swift playground" section
view.squeezeInDown{ view.pop { view.shake{ view.squeeze{ view.wobble{ view.flipX { view.flash{ view.flipY { view.fadeOutDown() } } } } } } } }
```

## How to install
### Manually install

Copy and paste `IBAnimatable` folder in your Xcode project.

### [Swift package manager](https://swift.org/package-manager)

Add `.Package(url: "https://github.com/IBanimatable/IBanimatable.git", majorVersion: 2)` to your `Package.swift`

### [CocoaPods](https://cocoapods.org)

Add `pod 'IBAnimatable'` to your Podfile.

### [Carthage](https://github.com/Carthage/Carthage)

Add `github "IBanimatable/IBAnimatable" ~> 2` to your Cartfile.

Please Notice, there is [a limitation of a built framework for `@IBDesignable` and `@IBInspectable`](https://github.com/Carthage/Carthage/issues/335), that will impact on `IBAnimatable` when you use Carthage.

### Git submodule

Add this repo as a submodule, and add the project file to your workspace. You can then link against `IBAnimatable.framework` for your application target. 

## How to contribute
All of us can contribute to this project. Fewer overheads mean less time to build quality Apps and more time to enjoy coffee ☕️.

* If you are a designer, you can design in Interface Builder with `IBAnimatable` without a design tool like Sketch, or implement your existing design from Sketch or Photoshop in Interface Builder rapidly. With `IBAnimatable`, you should be able to do <del>all</del> most of the design work in Interface Builder. If you have any feature request, please [create a GitHub Issue](https://github.com/IBAnimatable/IBAnimatable/issues/new) and we will put it in the backlog. If you have done any design with `IBAnimatable`, please let us know via creating Pull Request or GitHub Issue. We will add it to README file.

* If you are a developer, you can work on features or fix bugs, please check out [Vision, Technical Considerations and Roadmap](Documentation/Roadmap.md) and [GitHub Issues](https://github.com/IBAnimatable/IBAnimatable/issues) to find out the backlogs. If you have used `IBAnimatable` in your App, please let us know via creating Pull Request or GitHub Issue. We will add it to README file.

* If you are good at English, please correct my English 😁. If you are good at other languages, please create a README file in those languages.

* If you like the project, please share it with the other designers and developers, and star 🌟 the project. 🤗

Many thanks to [all contributors](https://github.com/IBAnimatable/IBAnimatable/graphs/contributors) 🤗 especially to [@tbaranes](https://github.com/tbaranes) who develops a lot of features and maintains the project.

## Roadmap
[Vision, Technical Considerations and Roadmap](Documentation/Roadmap.md)

## Inspirations / Credits
* `IBDesignable` and `IBInspectable` - The entire project is based on that.
* Sketch -  Interface Builder should be as easy as Sketch to use.
* Framer Studio - Design and preview animations in one place.
* [Spring by Meng To](https://github.com/MengTo/Spring) - steal a lot of animation parameters from this project.
* [VCTransitionsLibrary by Colin Eberhardt](https://github.com/ColinEberhardt/VCTransitionsLibrary) - port all transition animations from this project, and add parameters support and fix bugs.
* [Invision ToDo App UI Kit](http://www.invisionapp.com/do), The demo App's original design is from this UI Kit and redone in Interface Builder. We also added interaction, navigation and animations.

## Change Log
Please see [CHANGELOG.md](CHANGELOG.md)

## License
`IBAnimatable` is released under the MIT license. See [LICENSE](LICENSE) for details.


