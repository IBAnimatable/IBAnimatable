![IBAnimatable](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/Hero.png)

Design and prototype customized UI, interaction, navigation, transition and animation for App Store ready Apps in Interface Builder with IBAnimatable.

![IBAnimatable hero image](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/IBAnimatable.gif)

[![Build Status](https://travis-ci.org/IBAnimatable/IBAnimatable.svg?branch=master)](https://travis-ci.org/IBAnimatable/IBAnimatable)
[![Language](https://img.shields.io/badge/language-Swift%205-orange.svg)](https://swift.org)
[![CocoaPods](https://img.shields.io/cocoapods/v/IBAnimatable.svg?style=flat)](http://cocoadocs.org/docsets/IBAnimatable/)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Accio supported](https://img.shields.io/badge/Accio-supported-0A7CF5.svg?style=flat)](https://github.com/JamitLabs/Accio)
[![License](https://img.shields.io/github/license/IBAnimatable/IBAnimatable.svg?style=flat)](https://github.com/IBAnimatable/IBAnimatable/blob/master/LICENSE)

**The app was made in Interface Builder with `IBAnimatable` without a single line of code**. Due to the size of [the GIF file on Dribbble](https://dribbble.com/shots/2453933-IBAnimatable-Design-App-Store-ready-Apps-in-Interface-Builder), it only demonstrates a subset of features. We can also find the full HD version on [YouTube](https://www.youtube.com/watch?v=dvD8X6J1YLM) or [MP4 on Github](https://github.com/IBAnimatable/IBAnimatable-Misc/blob/master/Videos/IBAnimatable.mp4?raw=true)

## Key features
- ✅ **100% compatible with `UIKit`**. All `IBAnimatable` APIs are extensions of `UIKit`. No pollutions to `UIKit`'s APIs.
- ✅ **100% compatible with Auto Layout and Size Classes**. No custom layout system.
- ✅ **User interface design and preview in IB**: corner radius, border, mask, shadow, gradient colors, tint color, blur effect etc.
- ✅ **Animation design in IB**: slide in/out, fade in/out, zoom in/out, flip, pop, shake, rotate, move etc.
- ✅ **Transition design in IB**: fade, slide, flip, cube, portal, fold, explosion etc.
- ✅ **Interactive gesture design in IB**: pan, screen edge pan, pinch etc. 
- ✅ **Presentation design in IB**: flip, cover, zoom, dropdown etc.
- ✅ **Activity indicator design in IB**: ball beat, ball rotate, cube transition, Pacman etc.  


![StoryboardPreview](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/Storyboard.jpg)

Here is the full design in a Storyboard in Interface Builder.

With `IBAnimatable`, we can design a UI in Interface Builder like what we can do in Sketch, and prototype animations in a Swift playground like what we can do in Framer. Also, we can use the output of the design directly in the production ready App.

As a designer, we love Sketch, which is a simple but yet super powerful tool to create UI. However, Sketch can't design interaction, navigation, transition and animation, and we may need another tool like Framer to design some of them. Moreover, to make an App Store ready App, we need to use Xcode and Interface Builder to implement the UI and animations. To speed up the process and minimize the waste, we create `IBAnimatable` to make Interface Builder designable and animatable.   

## How to install
### Manually install

Copy and paste `IBAnimatable` folder in your Xcode project.

### [Swift package manager](https://swift.org/package-manager)
To integrate using Apple's Swift package manager, add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/IBAnimatable/IBAnimatable.git", .upToNextMajor(from: "6.0.0"))
```

### [CocoaPods](https://cocoapods.org)
Add the following entry in your Podfile:

```ruby
   pod 'IBAnimatable'
```

### [Carthage](https://github.com/Carthage/Carthage)
Add the following entry in your Cartfile:

```
   github "IBAnimatable/IBAnimatable"
```

### [Accio](https://github.com/JamitLabs/Accio)
Add the following entry in your Package.swift:

```swift
.package(url: "https://github.com/IBAnimatable/IBAnimatable.git", .upToNextMajor(from: "6.0.0")),
```

Next, add `IBAnimatable` to your App targets dependencies like so:

```swift
.target(
    name: "App",
    dependencies: [
        "IBAnimatable",
    ]
),
```

Please Notice, there is [a limitation of a built framework for `@IBDesignable` and `@IBInspectable`](https://github.com/Carthage/Carthage/issues/335), that will impact on `IBAnimatable` when you use Carthage or Accio. There is a workaround to use Carthage, Accio or Swift package manager with `IBAnimatable`, please have a look at [Carthage – no Animatable UI Classes appearing in Storyboard](https://github.com/IBAnimatable/IBAnimatable/issues/354)

As @DanielAsher mentioned
> I use carthage update --use-submodules --no-build --no-use-binaries and manually add the both the framework project and the framework as an embedded dependency.
>This method is robust, and fine-grained, but perhaps not as easy as dragging the built framework into your project.

### Git submodule

Add this repo as a submodule, and add the project file to your workspace. You can then link against `IBAnimatable.framework` for your application target. 

## Version 6
IBAnimatable 6 is the latest major release of IBAnimatable. This version supports Swift 5. There are no API breaking changes from migrating from version 5.x.

## Version 5.2
This version supports Swift 4.2. There are no API breaking changes from migrating from version 4.x. 

If you migrate from version 3.x. Please check out [IBAnimatable 4.0 Migration Guide](Documentation/IBAnimatable%204.0%20Migration%20Guide.md) for more information.

## Swift version
### Swift 4.2
There are no API breaking changes when migrating from Swift 4.* to Swift 4.2 using IBAnimatable.

If you are using Xcode 10 with Swift 4.2, please use the latest tagged 5.x release.

### Swift 4.1
There are no API breaking changes when migrating from Swift 4 to Swift 4.1 using IBAnimatable.

If you are using Xcode 9.3 with Swift 4.1, please use the latest tagged 5.x release.

### Swift 4
There are no API breaking changes when migrating from Swift 3.2 to Swift 4 using IBAnimatable.

If you are using Xcode 9 with Swift 4, please use the latest tagged 5.x release.

### Swift 3.2
There are no API breaking changes when migrating from Swift 3.1 to Swift 3.2 using IBAnimatable.

If you are using Xcode 9 and Swift 3.2, please use the 4.2 release.

### Swift 3 or 3.1
If you migrate from Swift 2.x, please check out [IBAnimatable 3.0 Migration Guide](Documentation/IBAnimatable%203.0%20Migration%20Guide.md) for more information about how to migrate your project to 3.0. Version 3 follows Swift 3 [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/) and contains a lot of breaking changes from version 2.x. 

If you are using Xcode 8 with Swift 3, please use the latest tagged 4.x release.

## Languages
[中文](Documentation/README.zh.md)

## Features
* From prototype to shippable App Store ready App - What you design in Interface Builder is what the App exactly looks. More details can be found in this talk [Prototype and Design App Store ready Apps in Interface Builder (/dev/world/2016)](https://youtu.be/HaB2_ki_67w)
* Designer-friendly - Sketch style configuration panel on Attributes inspector (![Attributes inspector](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/AttributesInspector.png)) to lower the learning curve for using Interface Builder.   
* Animation design support in Swift playground - Similar to Framer, we can prototype animations in Swift playground to save time for running on a simulator or actual iOS devices. 
* Built-in Auto Layout support - We can use Auto Layout and Size Classes with `IBAnimatable` to support orientations and multiple iOS devices. 
* Navigation and transition support - We can use default navigation pattern in the App. `IBAnimatable` also has custom transition animators and segues to support transition animations and gesture interactions.
* Protocol-oriented programming - `IBAnimatable` uses a protocol-oriented programming paradigm. With Swift protocol extension, it is easy to support more designable or animatable features. We can even use these protocol extensions to create other custom UI elements instead of using the default ones from `IBAnimatable`. More details can be found in this talk [Prototype and Design App Store ready Apps in Interface Builder (/dev/world/2016) - Part 2: Protocol oriented programming](https://youtu.be/HaB2_ki_67w?t=24m13s)

## Use cases
* Prototyping - Create interactive prototypes to validate ideas quickly.
* Redesigning in Interface Builder - Redesign the UI from Sketch and animations from Framer without writing any code.
* Making custom UI elements - Use `IBAnimatable` protocols to make custom UI elements. e.g. Buttons with a default color palette.

## Documentations
* [<del>Fully</del> Mostly documented API Reference](Documentation/APIs.md) 
* [How to design and prototype custom transition animation and gesture interaction in Interface Builder with IBAnimatable](Documentation/Transitions.md)
* Youtube video:  [Prototype and Design App Store ready Apps in Interface Builder (/dev/world/2016) - Part 2: Protocol oriented programming](https://youtu.be/HaB2_ki_67w)

## How to run the example App
The easy way to learn and understand how powerful of `IBAnimatable`is to run the example App and play around the settings in Interface Builder. Just a few steps we can run the App as below, to see more features, we can tap on "Forget Password" button to unlock them. 😉

1) Clone the repository

```bash
$ git clone https://github.com/IBAnimatable/IBAnimatable.git
```

2) Open the workspace in Xcode

```bash
$ cd IBAnimatable
$ open IBAnimatable.xcworkspace
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

1. Open IBAnimatable.xcworkspace
2. Select IBAnimatable Framework scheme and build it with `Command + b`
3. Select IBAnimatable.playground, choose one page in Swift playground, then click on "Assistant editor" button to split the playground. After that, select "Timeline" on the top of right-hand side to preview the animation. We can use Xcode menu "Editor" -> "Execute" to re-run the playground.

## How to animate programmatically
As you saw above, we can prototype an App fully in Interface Builder without a single line of code, but `IBAnimatable` also provides APIs to let us fully control the UI and animations. `IBAnimatable` provides simple promise-like APIs. We can easily call them in one line.

```swift
view.animate(.pop(repeatCount: 1)) // pop animation for the view
view.animate(.squeezeFade(way: .in, direction: .left)) // squeeze and fade in from left animation
```  

You can play around with all these predefined animations in the [Swift playground Page - Predefined Animations](IBAnimatable.playground/Pages/Predefined%20Animations.xcplaygroundpage)

### Animation properties
There are some properties we can change to customize the animation. What we need to do is to pass the parameters to `animate()` method to start the animation.

```swift
view.animate(.squeeze(way: .in, direction: .left), duration: 1, damping: 1, velocity: 2, force: 1)
```

You can play around with all animations with different parameters in the [Swift playground Page - Animation Properties](IBAnimatable.playground/Pages/Animation%20Properties.xcplaygroundpage)

### Chaining animations
Sometimes, we need to run more animation after the previous one. With `IBAnimatable`, we can easily use promise-like API to chain all animations together to provide a sleek user experience.

```swift
// We can chain the animations together, it is the source code of animated GIF in "Animate in Swift playground" section
view.animate(.squeezeFade(way: .in, direction: .down))
    .then(.pop(repeatCount: 1))
    .then(.shake(repeatCount: 1))
    .then(.squeeze(way: .in, direction: .down))
    .then(.wobble(repeatCount: 1))
    .then(.flip(along: .x))
    .then(.flip(along: .y))
    .then(.slideFade(way: .out, direction: .down))
```

### Delaying animations
We can use `delay` method to delay the next animation.

```swift
view.animate(.squeeze(way: .in, direction: .left))
    .delay(0.5)
    .then(.shake(repeatCount: 3))
```

We can also delay the first animation.

```swift
view.delay(2)
    .then(.squeeze(way: .in, direction: .left))
```

### Completion handler
We can add a completion handler/closure to execute when all animations are completed.

```swift
view.animate(.squeeze(way: .in, direction: .left))
    .completion { print("Animations finished!") }
```

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
* [NVActivityIndicatorView by Vinh Nguyen](https://github.com/ninjaprox/NVActivityIndicatorView) - port all activity indicator animations from this project, and migrate to Swift 3.
* [Invision ToDo App UI Kit](http://www.invisionapp.com/do), The demo App's original design is from this UI Kit and redone in Interface Builder. We also added interaction, navigation and animations.

## Change Log
Please see [CHANGELOG.md](CHANGELOG.md)

## License
`IBAnimatable` is released under the MIT license. See [LICENSE](LICENSE) for details.


