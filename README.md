# IBAnimatable
IBAnimatable helps designers and developers design UI, navigations, interactions and animations in Interface Builder.

As a designer, we love Sketch, which is simple but yet super powerful tool to design UI. But Sketch doesn't support navigations, interactions and animations, we may need another tool like Framer to design them. Also, to make a shippable App, we need to use Xcode and Interface Builder to redo the UI and animations. To smooth the process and minimise the waste, we create `IBAnimatable` to make Interface Builder designable and animatable.   

## Features
* From design to shippable App - What you design on Interface Builder is what the App exactly looks like. Fewer overheads mean less time to build quality Apps and more time to enjoy coffee☕️.
* Designer friendly - Sketch-ish configuration panel on Attributes Inspector to lower the learning curve to use Interface Builder.   
* Animation desigin support in Swift playground - Design motion/animation on Swift playground to save time for runing on simulator or actual iOS devices.
* Built-in Auto Layout support - We can use Auto Layout with `IBAnimatable` to support multiple iOS devices. 
* Navigation support - We can use default navigation pattern in the App and `IBAnimatable` also adds unwind segues to to unwind or dismiss scene without code.
* Protocol oriented programming - `IBAnimatable` used protocol oriented programming paradigm. Thanks to Swift protocol extension, it is very easy to support more designable or animatable features. We can even use protocol extension create own set of AnimatableViews instead of using the default ones from `IBAnimatable`.  

## How to use



## Design in Interface Builder


## Animate in Swift playground



## How to animate programmatically



## How to install


## APIs


## How to contribute

## Inspirations
* `IBDesignable` and `IBInspectable` - The entire project is based on that.
* Sketch -  Interface Builder should be as easy as Sketch to use
* Framer
* [Spring by Meng To](github.com/MengTo/Spring) - steal a lot of animation parameters from this project.
* [Invision ToDo App UI Kit](http://www.invisionapp.com/do), The demo App's original design is from this UI Kit and redone in Interface Builder. We also added interaction, navigation and animations.
