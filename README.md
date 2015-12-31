# IBAnimatable
IBAnimatable helps designers and developers design UI, navigations, interactions and animations in Interface Builder.

As a designer, we love Sketch, which is a simple but yet super powerful tool to design UI. However, Sketch doesn't support navigations, interactions and animations, we may need another tool like Framer to design them. Also, to make a shippable App, we need to use Xcode and Interface Builder to redo the UI and animations. To smooth the process and minimise the waste, we create `IBAnimatable` to make Interface Builder designable and animatable.   

## Features
* From design to shippable App - What you design in Interface Builder is what the App exactly looks like. 
* Designer friendly - Sketch-ish configuration panel on Attributes Inspector to lower the learning curve to use Interface Builder.   
* Animation desigin support in Swift playground - Design animations on Swift playground to save time for runing on simulator or actual iOS devices.
* Built-in Auto Layout support - We can use Auto Layout and Size Classes with `IBAnimatable` to support multiple iOS devices. 
* Navigation support - We can use default navigation pattern in the App and `IBAnimatable` also adds unwind segues to unwind or dismiss scene without any code.
* Protocol oriented programming - `IBAnimatable` used protocol oriented programming paradigm. Thanks to Swift protocol extension, it is very easy to support more designable or animatable features. We can even use protocol extension create own set of AnimatableViews instead of using the default ones from `IBAnimatable`.  

## How to run sample project


## Design in Interface Builder
![](https://raw.githubusercontent.com/JakeLin/IBAnimatable/master/Screenshots/DesignInInterfaceBuilder.png)

To use `IBAnimatable` to design the UI and animations in Interface Builder, just follow few steps as below:

1. Open a storyboard or Xib file.
2. Drag and drop a view or controller to a ViewController.
3. In Identity Inspector, connect the view or controller to `Animatable` classes, you can find all `Animatable` classes in APIs section.
4. Configure the UI and animations in Attribute Inspector.


## Animate in Swift playground
![](https://github.com/JakeLin/IBAnimatable/blob/master/Screenshots/AnimateInSwiftPlayground.gif)

We can configure the animation settings in Attribute Inspector. However, Interface Builder doesn't support preview Animations, but we can still prototype animations in Swift playgournd. There are three sample pages to demostrate how to animate in Swift playground. You can find them in [IBAnimatable.playground](https://github.com/JakeLin/IBAnimatable/tree/master/IBAnimatable.playground)

## How to animate programmatically
As you saw above, we can prototype an App fully in Interface Builder withouth single line of code, but if `IBAnimatable` also provides programmable APIs to let us fully control the UI and animations. `IBAnimatable` provides simple APIs like `pop()`. We can simplly call them in one line.

```
view.pop() // pop animation for the view
view.squeezeFadeInLeft() // squeeze and fade in from left animation
```  

You can play around all these animations in [Swift playgournd Page - Predefined Animations](https://github.com/JakeLin/IBAnimatable/tree/master/IBAnimatable.playground/Pages/Predefined%20Animations.xcplaygroundpage)

### Animation Properties
There are some properties we can change to customise the animation. What we need to do is to set the properties and call `animate()` method to start the animation.

```
// Setup the animation
view.animationType = "SqueezeInLeft"
view.delay = 0.5
view.damping = 0.5
view.velocity = 2
view.force = 1

// Start the animation
view.animate()
```

You can play around all animations with properties in [Swift playgournd Page - Animation Properties](https://github.com/JakeLin/IBAnimatable/tree/master/IBAnimatable.playground/Pages/Animation%20Properties.xcplaygroundpage)

### Chaining Animations
Sometimes, we need to run one animation after another one. With `IBAnimatble`, we can easily chain animations together to provide sleek user experience.

```
// Simplly put the next animation in `{}` closure like below. It is an example to pop the view after squeeze in from the top.
view.squeezeInDown{ view.pop() }

// Heaps of animations have been chained togehter, it is source code of gif in "Animate in Swift playground" section
view.squeezeInDown{ view.pop { view.shake{ view.squeeze{ view.wobble{ view.flipX { view.flash{ view.flipY { view.fadeOutDown() } } } } } } } }
```

## How to install
### Manually install
Copy and paste `IBAnimatable` folder in your Xcode project.

### Git submodule
TBD [Issue #22 - Swift package manager support](https://github.com/JakeLin/IBAnimatable/issues/22)

### Swift package manager
TBD [Issue #5 - Swift package manager support](https://github.com/JakeLin/IBAnimatable/issues/5)

### CocoaPods
TBD [Issue #7 - CocoaPods support](https://github.com/JakeLin/IBAnimatable/issues/7)

### Carthage 
TBD [Issue #6 - Carthage support ](https://github.com/JakeLin/IBAnimatable/issues/6)


## APIs


## How to contribute
All of us can contribute to this project. Fewer overheads mean less time to build quality Apps and more time to enjoy coffee ☕️.

If you are a design, you can design in Interface Builder with `IBAnimatable` or redo your existing design from Sketch or Photoshop. You should be able to do <del>all</del> most of design work in Interface Builder. If you have any feature request, please [create a GitHub Issue](https://github.com/JakeLin/IBAnimatable/issues/new) and we will put it in the backlog. If you have done any design with `IBAnimatable`, please let us know via creating Pull Request or GitHub Issue. We will add it to Readme file.

If you are a developer, you can work on features or fix bugs, please check out [GitHub Issues](https://github.com/JakeLin/IBAnimatable/issues) to find out the backlog. If you have used `IBAnimatable` in you App, please let us know via creating Pull Request or GitHub Issue. We will add it to Readme file.

If you are good at English, please correct my English 😁. If you are good at other languages, please create a Readme file in those languages.

If you like the project, please share it with the other designers and developers, and star 🌟 the project. 🤗


## Inspirations
* `IBDesignable` and `IBInspectable` - The entire project is based on that.
* Sketch -  Interface Builder should be as easy as Sketch to use
* Framer
* [Spring by Meng To](github.com/MengTo/Spring) - steal a lot of animation parameters from this project.
* [Invision ToDo App UI Kit](http://www.invisionapp.com/do), The demo App's original design is from this UI Kit and redone in Interface Builder. We also added interaction, navigation and animations.

## License
`IBAnimatable` is released under the MIT license. See [LICENSE](https://github.com/JakeLin/IBAnimatable/blob/master/LICENSE) for details.

