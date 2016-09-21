# IBAnimatable 3.0 Migration Guide

IBAnimatable 3.0 is the latest major release of IBAnimatable, a library for designing and prototyping customized UI, interaction, navigation, transition and animation for App Store ready Apps in Interface Builder. As a major release, following Semantic Versioning conventions, 3.0 introduces API-breaking changes.

This guide is provided in order to ease the transition of existing applications using IBAnimatable 2.x to the latest APIs, as well as explaining the design and structure of new and updated functionality.

## Requirements

- iOS 8.0+
- Xcode 8.0+
- Swift 3.0+

For those of you that would like to use IBAnimatable with Swift 2.2 or 2.3, please use the latest tagged 2.x release which supports both Swift 2.2 and 2.3.

## Benefits of upgrading

- **Complete Swift 3 compatibility:** includes the full adoption of the new [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/).
- **New enum system:** uses enums to provide strongly typed APIs to replace stringly typed APIs.

## Breaking API Changes
IBAnimatable 3 has fully adopted all the new Swift 3 changes and conventions, including the new [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/). Because of this, almost every API in IBAnimatable has been modified in some way. We can't possibly document every single change, so we're going to attempt to identify the most common APIs and how they have changed to help you through those sometimes less than helpful compiler errors.

### Enums
#### All enums start with lowercase
When you run "Convert to Current Swift Syntax...", it should pick up those changes. 

#### Enum improvements
Because Interface Builder can't support enum as `@IBInspectable` property. Before version 3, we had to define the property as `String` for the enum like `AnimationType`. But @lastMove had found a nice workaround / solution to support enum for both programmatical APIs and Interface Builder, we have improved all enums to support the new pattern.

There is an example how we improve the enums. Before version 3, we define `AnimationType` enum like:

```swift
public enum AnimationType {
  case SlideInLeft
  case SlideInRight
  case SlideInDown
  case SlideInUp
  case SlideOutLeft
  case SlideOutRight
  case SlideOutDown
  case SlideOutUp
  ...
}
```

To support `@IBInspectable` property, we have to define the property `animationType` as a `String` like:

```swift
/**
  String value of `AnimationType` enum
*/
var animationType: String? { get set }
```  
  
After that we can use it for **Animation Type** in **Attributes inspector** like `SlideInLeft` or `SlideOutRight`. 

And we can use it in code like: 

```swift
var view = AnimatableView() // Set up a view from Storyboard or frame.
view.animationType = "SlideInLeft"
// view.animationType = "SlideOutRight"
```

In this case, we have to use Stringy enum value to set `animationType` property. It is not ideal. To unlock the power of Swift enum, we have changed the enum like:

```swift
public enum AnimationType {
  case slide(way: Way, from: Direction)
  ...
}
```

We can accept parameters for enum value like:
```swift
var view = AnimatableView() // Set up a           s view from Storyboard or frame.
view.animationType = .slide(.in, direction: .left)
// view.animationType = .slide(.out, direction: .right)
```

To use them in **Attributes inspector**, we can set **Animation Type** like `slide(in,left)` or `slide(out,right)`.

##### Changes for `AnimationType`

| Before in code (String value of the enum) | After in code | Before in Interface Builder | After in Interface Builder | 
| --- | --- | --- | --- |
| .SlideInLeft | .slide(way: .in, direction: .left) | SlideInLeft | slide(in,left) |
| .SlideInRight | .slide(way: .in, direction: .right) | SlideInRight | slide(in,right) |
| .SlideInDown | .slide(way: .in, direction: .down) | SlideInDown | slide(in,down) |
| .SlideInUp | .slide(way: .in, direction: .up) | SlideInUp | slide(in,up) |
| .SlideOutLeft | .slide(way: .out, direction: .left) | SlideOutLeft | slide(out,left) |
| .SlideOutLeft | .slide(way: .out, direction: .right) | SlideOutLeft | slide(out,right) |
| .SlideOutLeft | .slide(way: .out, direction: .down) | SlideOutLeft | slide(out,down) |
| .SlideOutLeft | .slide(way: .out, direction: .up) | SlideOutLeft | slide(out,up) |
| .SqueezeInLeft | .squeeze(way: .in, direction: .left) | SqueezeInLeft | squeeze(in,left) |
| .SqueezeInRight | .squeeze(way: .in, direction: .right) | SqueezeInRight | squeeze(in,right) |
| .SqueezeInDown | .squeeze(way: .in, direction: .down) | SqueezeInDown | squeeze(in,down) |
| .SqueezeInUp | .squeeze(way: .in, direction: .up) | SqueezeInUp | squeeze(in,up) |
| .SqueezeOutLeft | .squeeze(way: .out, direction: .left) | SqueezeOutLeft | squeeze(out,left) |
| .SqueezeOutLeft | .squeeze(way: .out, direction: .right) | SqueezeOutLeft | squeeze(out,right) |
| .SqueezeOutLeft | .squeeze(way: .out, direction: .down) | SqueezeOutLeft | squeeze(out,down) |
| .SqueezeOutLeft | .squeeze(way: .out, direction: .up) | SqueezeOutLeft | squeeze(out,up) |
| .FadeInLeft | .slideFade(way: .in, direction: .left) | FadeInLeft | slideFade(in,left) |
| .FadeInRight | .slideFade(way: .in, direction: .right) | FadeInRight | slideFade(in,right) |
| .FadeInDown | .slideFade(way: .in, direction: .down) | FadeInDown | slideFade(in,down) |
| .FadeInUp | .slideFade(way: .in, direction: .up) | FadeInUp | slideFade(in,up) |
| .FadeOutLeft | .slideFade(way: .out, direction: .left) | FadeOutLeft | slideFade(out,left) |
| .FadeOutLeft | .slideFade(way: .out, direction: .right) | FadeOutLeft | slideFade(out,right) |
| .FadeOutLeft | .slideFade(way: .out, direction: .down) | FadeOutLeft | slideFade(out,down) |
| .FadeOutLeft | .slideFade(way: .out, direction: .up) | FadeOutLeft | slideFade(out,up) |
| .SqueezeFadeInLeft | .squeezeFade(way: .in, direction: .left) | SqueezeFadeInLeft | squeezeFade(in,left) |
| .SqueezeFadeInRight | .squeezeFade(way: .in, direction: .right) | SqueezeFadeInRight | squeezeFade(in,right) |
| .SqueezeFadeInDown | .squeezeFade(way: .in, direction: .down) | SqueezeFadeInDown | squeezeFade(in,down) |
| .SqueezeFadeInUp | .squeezeFade(way: .in, direction: .up) | SqueezeFadeInUp | squeezeFade(in,up) |
| .SqueezeFadeOutLeft | .squeezeFade(way: .out, direction: .left) | SqueezeFadeOutLeft | squeezeFade(out,left) |
| .SqueezeFadeOutLeft | .squeezeFade(way: .out, direction: .right) | SqueezeFadeOutLeft | squeezeFade(out,right) |
| .SqueezeFadeOutLeft | .squeezeFade(way: .out, direction: .down) | SqueezeFadeOutLeft | squeezeFade(out,down) |
| .SqueezeFadeOutLeft | .squeezeFade(way: .out, direction: .up) | SqueezeFadeOutLeft | squeezeFade(out,up) |
| .FadeIn | .fade(way: .in) | FadeIn | fade(in) |
| .FadeOut | .fade(way: .out) | FadeOut | fade(out) |
| .FadeInOut | .fade(way: .inOut) | FadeInOut | fade(inOut) |
| .FadeOutIn | .fade(way: .outIn) | FadeOutIn | fade(outIn) |
| .ZoomIn | .zoom(way: .in) | ZoomIn | zoom(in) |
| .ZoomOut | .zoom(way: .out) | ZoomOut | zoom(out) |
| .ZoomInvertIn | .zoomInvert(way: .in) | ZoomInvertIn | zoomInvert(in) |
| .ZoomInvertOut | .zoomInvert(way: .out) | ZoomInvertOut | zoomInvert(out) |
| .Shake | .shake(repeatCount: 1) | Shake | shake(1) |
| .Pop | .pop(repeatCount: 1) | Pop | pop(1) |
| .Squeeze | .squash(repeatCount: 1) | Squeeze | squash(1) |
| .Morph | .morph(repeatCount: 1) | Morph | morph(1) |
| .Flash | .flash(repeatCount: 1) | Flash | flash(1) |
| .Wobble | .wobble(repeatCount: 1) | Wobble | wobble(1) |
| .Swing | .swing(repeatCount: 1) | Swing | swing(1) |
| .FlipX | .flip(along: x) | FlipX | flip(x) |
| .FlipY | .flip(along: y) | FlipY | flip(y) |
| .Rotate | .rotate(direction: .cw, repeatCount: 1) | Rotate | rotate(cw,1) |
| .Rotate | .rotate(direction: .ccw, repeatCount: 1) | Rotate | rotate(ccw,1) |
| .MoveTo | .moveTo(x: 100, y: 120) | MoveTo | moveTo(100,120) |
| .MoveBy | .moveBy(x: -10, y: 20) | MoveBy | moveBy(-10,20) |

##### Changes for `BlurEffectStyle`
`BlurEffectStyle` has been replace by `UIBlurEffectStyle`

##### Changes for `MaskType`

* Used in code

```swift
var maskType: MaskType = .circle
maskType = .triangle
maskType = .star(points: 6)
maskType = .polygon(sides: 10)
maskType = .parallelogram(angle: 60)
maskType = .wave(direction: .up, width: 50, offset: 10)
```

* Used in Interface Builder
`circle`, `star(6)`, `polygon(10)`, `parallelogram(60)` or `wave(up,50,10)`

##### Changes for `TransitionAnimationType`
* Used in code

```swift
var transitionAnimationType: TransitionAnimationType = .systemRotate
transitionAnimationType = .cards(direction: .forward)
transitionAnimationType = .fade(direction: .in)
transitionAnimationType = .explode(xFactor: 10, minAngle: 10, maxAngle: 20)
transitionAnimationType = .systemCube(from: .left)
```

* Used in Interface Builder
`systemRotate`, `cards(forward)`, `fade(in)`, `explode(10,10,20)` or `systemCube(left)`

##### Changes for `InteractiveGestureType`

* Used in code

```swift
var interactiveGestureType: InteractiveGestureType = .pan(from: .right)
interactiveGestureType = .pinch(direction: .open)
interactiveGestureType = .screenEdgePan(from: .left)
```

* Used in Interface Builder
`pan(right)`, `pinch(open)` or `screenEdgePan(left)`

##### Changes for `PresentationAnimationType`
* Used in code

```swift
var presentationAnimationType: PresentationAnimationType = .flip
presentationAnimationType = .dropDown
presentationAnimationType = .crossDissolve
presentationAnimationType = .zoom
presentationAnimationType = .cover(from: left)
```

* Used in Interface Builder
`flip`, `dropDown`, `crossDissolve`, `zoom` or `cover(left)`

##### Changes for `PresentationModalSize`
* Used in code

```swift
var presentationModalSize: PresentationModalSize = .full
presentationModalSize = .half
presentationModalSize = .custom(size: 200)
```

* Used in Interface Builder
`full`, `half`, or `custom(200)`


##### Changes for `PresentationModalPosition`
* Used in code

```swift
var presentationModalPosition: PresentationModalPosition = .center
presentationModalPosition = .leftCenter
presentationModalPosition = .bottomCenter
presentationModalPosition = .customCenter(centerPoint: 220)
presentationModalPosition = .customOrigin(origin: 100)
```

* Used in Interface Builder
`center`, `leftCenter`, `bottomCenter`, `customCenter(220)`, or `customOrigin(100)`

##### Changes for other enums
For the other enums e.g. `ActivityIndicatorType`, `ColorType` and `GradientColor`, we just need to change them to start with lower case.


### Protocols

#### Changes for protocol extension methods
All methods start with `config***` have been changed to `configure***`. e.g. `configAnimatableProperties` has been changed to `configureAnimatableProperties`. And `configMask` has been changed to configureMask`.

#### Changes for `Animatable`
* `x` and `y` properties have been removed
They have become the parameters of `moveTo(x:y:)` and `moveBy(x:y:)` enums.

```swift
// Before
view.x = 200
view.y = 300
view.animationType = "MoveTo"
view.animate()

// After
view.animationType = .moveTo(x: 200, y: 300)
view.animate()
```

* `repeatCount` property has been removed
It has become the parameter of `shake1, `pop`, `squash`, `morph`, `flash`, `wobble`, `swing` or `rotate` enums.

```swift
// Before
view.repeatCount = 5
view.animationType = "Pop"
view.animate()

// After
view.animationType = .pop(repeatCount: 1)
view.animate()
```

* Group animation methods 
Because we have improved the enum for `AnimationType`, we also group similar methods together. For example for `.slide`, we have grouped `slideInLeft()`, `slideInRight()`, `slideInDown()`, `slideInUp()`, `slideOutLeft()`, `slideOutRight()`, `slideOutDown()` and `slideOutUp()` to single method `slide(_ way: AnimationType.Way, direction: AnimationType.Direction)` 

```swift
// Before
view.slideInLeft()
view.slideOutRight()

// After
view.slide(.in, direction: .left)
view.slide(.out, direction: .right)
```

We use the same pattern to group the animation methods.

#### Changes for protocols with enum
We have change the type from `String` to actual enum for all protocols. e.g. for `Animatable`, we change `var animationType: String? { get set }` to `var animationType: AnimationType { get set }`. And change `var maskType: String? { get set }` to `var maskType: MaskType { get set }` for `MaskDesignable`. Then we can set enum values in code like:

```swift
// Before
view.animationType = "Pop"
view.maskType = "Circle"

// After
view.animationType = .pop(repeatCount: 2)
view.maskType = .circle
```


### Animatable UI elements
Because `IBAnimatable` uses protocol oriented programming paradigm, all animatable UI elements, e.g. `AnimatableView`, `AnimatableButton` use the reused protocols. And we have changed the protocols to use the new enum system as mentioned above, we need to change those properties to use enum in code like:

```swift
// Before
view.animationType = "Pop"
view.maskType = "Circle"
button.view.animationType = "Shake"

// After
view.animationType = .pop(repeatCount: 2)
view.maskType = .circle
button.animationType = .shake(repeatCount: 1)
``` 

Please find more information for [Enums](#Enums) and [Protocols](#Protocols).

### Custom UI elements
If you have created your own custom UI elements and used the protocols in `IBAnimatable` like [IBAnimatableMaterial](https://github.com/IBAnimatable/IBAnimatableMaterial) project, you need to change the implementation for some properties e.g. `animationType` and `maskType`. Here is an example for `maskType`:

```swift
class CustomView: UIView, MaskDesignable {
	// MARK: - MaskDesignable
  open var maskType: MaskType = .none {
    didSet {
      configureMask()
      configureBorder()
      configureMaskShadow()
    }
  }
  
  /// The mask type used in Interface Builder. **Should not** use this property in code.
  @IBInspectable var _maskType: String? {
    didSet {
      maskType = MaskType(string: _maskType)
    }
  }
}
```

Because Interface Builder can't support Swift enum, we have to define a property called `_maskType` as `String`. The property is `internal`, which we only use it in Interface Builder. And in the `didSet` block, we set the actual property `maskType` which is a Swift enum `MaskType`.

### Interface Builder / Storyboard
Since we have introduced new enum system, we have to change some properties like `animationType` and `maskType`. And we need to change them in the Storyboard when migrating version 3.

You may see some warnings like below:
> DemoApp.storyboard: warning: IB Designables: Ignoring user defined runtime attribute for key path "animationType" on instance of "IBAnimatable.AnimatableButton". Hit an exception when attempting to set its value: [<IBAnimatable.AnimatableButton 0x7ffc3a974800> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key animationType.

Because we have change the properties name to support Interface Builder. Most of the cases, we can just add an underscore (`_`) to fix them.

There are a couple of ways to fix them.

0. Open the *.storyboard file with your favor editor e.g. Atom, VS Code or sublime. Replace the value as below.
2. Or open the storyboard in Interface Builder, select the element (with warnings). Then open **Identity inspector**, and change the value in **User Defined Runtime Attributes**.
3. Or You can also find them by doing a search in Xcode (even doing a replace all, but that's may be dangerous)

| Before | After  |
| --- | --- |
| borderSides | _borderSides |
| blurEffectStyle | _blurEffectStyle |
| vibrancyEffectStyle | _vibrancyEffectStyle |
| predefinedGradient | _predefinedGradient |
| startPoint | _startPoint |
| maskType | _maskType |
| animationType | _animationType |
| predefinedColor | _predefinedColor |
| transitionAnimationType | _transitionAnimationType |
| interactiveGestureType | _interactiveGestureType |
| presentationAnimationType | _presentationAnimationType |
| dismissalAnimationType | _dismissalAnimationType |
| modalPosition | _modalPosition |
| modalWidth | _modalWidth |
| modalHeight | _modalHeight |
| keyboardTranslation | _keyboardTranslation |

--
If you have found any issues for the migration, please create an issue. Please create a PR if you find the solution, thanks.


