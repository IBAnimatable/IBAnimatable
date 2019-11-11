### Animatable UI elements
To use `IBAnimatable`, we can drag and drop a UIKit element and connect it with `Animatable` UI element in Identity inspector. Here are the supported `Animatable` UI elements to map UIKit elements.

| UIKit elements | Animatable UI elements | Description |
| ------------- |:-------------:| ----- |
| UIView | AnimatableView | |
| UIScrollView | AnimatableScrollView | |
| UIBarButtonItem | AnimatableBarButtonItem | |
| UIButton | AnimatableButton | |
| UIButton | AnimatableCheckBox | Connect UIButton as AnimatableCheckBox to make CheckBox control |
| UIImageView | AnimatableImageView | |
| UILabel | AnimatableLabel | To style the text in Label, we can use Interface Builder built-in Attributed Text |
| UIStackView | AnimatableStackView | |
| UITableView | AnimatableTableView | |
| UITableViewCell | AnimatableTableViewCell | |
| UITextField | AnimatableTextField | |
| UITextView | AnimatableTextView | |
| UINavigationBar | DesignableNavigationBar | |
| UIViewController | AnimatableViewController | |
| UINavigationController | AnimatableNavigationController | |
| UITableViewController | AnimatableTableViewController| |
| UISlider | AnimatableSlider | |
| UIActivityIndicatorView | AnimatableActivityIndicatorView | [List of animations available](./ActivityIndicators.md) |

### Designable protocols
`IBAnimatable` provides a set of Designable protocols as below. Because of the power of protocol-oriented programming in Swift, we don't even have to use Animatable default UI elements e.g. `AnimatableView` to unlocked the power of `IBAnimatable`. We can conform to `IBAnimatable` protocols to use the default implementation in protocol extension to create other custom UI elements.

#### `BarButtonItemDesignable`
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| roundedImage | Optional&lt;UIImage> | By default, Interface Builder can only support outline images for Bar Button Item. With `roundedImage`, we can display a rounded image. The image can not be previewed in Interface Builder. |


#### `BlurDesignable`
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| blurEffectStyle | Optional&lt;String> | Support three different blur effects: `ExtraLight`, `Light` and `Dark`, also can be found in emum [`BlurEffectStyle`](../Sources/Enums/BlurEffectStyle.swift). The look of blur effect in Interface Builder is different from Simulator or device. |
| vibrancyEffectStyle | Optional&lt;String> | Support three different blur effects: `ExtraLight`, `Light` and `Dark`, also can be found in emum [`BlurEffectStyle`](../Sources/Enums/BlurEffectStyle.swift). Once specify the Vibrancy effect style, all subviews will apply this vibrancy effect. Pleace notice that once the vibrancy effect is applied, all the subviews will loose their constraints. The workaround for this is to reset programatically each of them. |
| blurOpacity | CGFloat | Opacity of the blur effect specified above. the default value is `CGFloat.NaN`, the value range is from 0.0 to 1.0. |


#### `BorderDesignable`
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| borderType | Optional&lt;String> | border type: `solid`, `dash`, also can be found in emum [`BorderSide`](../Sources/Enums/BorderType.swift). If not specified, then display solid borders. **Please notice**: If we use `maskType` property then `borderType` will be ignored. |
| borderColor | Optional&lt;UIColor> | border color |
| borderWidth | CGFloat | border width. Default value is `CGFloat.NaN`, the value is greater than 0. |
| borderSide | Optional&lt;String> | border side: `top`, `right`, `bottom` or `left`, also can be found in emum [`BorderSide`](../Sources/Enums/BorderSide.swift). Multiple sides can be configured with a comma separated list of sides (e.g. `top,bottom`). If not specified, then display four sides. **Please notice**: If we use `maskType` property then `borderSide` will be ignored. |


#### `CheckBoxDesignable`
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| checked | Bool | Default value is `false` |
| checkedImage | Optional&lt;UIImage> | The image to display when CheckBox is checked. |
| uncheckedImage | Optional&lt;UIImage> | The image to display when CheckBox is unchecked. |

#### `CornerDesignable`
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| cornerRadius | CGFloat | rounded corner radius. The default value is `CGFloat.NaN`, the value is greater than 0. |
| cornerSides | Optional&lt;String> | corner side: `topLeft`, `topRight`, `bottomLeft` or `bottomRight`, also can be found in emum [`CornerSide`](../Sources/Enums/CornerSide.swift). Multiple sides can be configured with a comma separated list of sides (e.g. `topLeft,topRight`). If not specified, then display four sides. **Please notice**: If we use `maskType` property then it will be replaced by `cornerSide`. |

#### `FillDesignable`
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| fillColor | Optional&lt;UIColor> | fill color of the UI Element |
| opacity | CGFloat | opacity, alpha of the UI Element, the default value is `CGFloat.NaN`, the value is from 0.0 to 1.0. |
| predefinedColor | Optional&lt;String> | Predefined color. All predefined colors are in enum [`ColorType`](../Sources/Enums/ColorType.swift). To find the predefined flat colors, you can use [flatuicolors.com](https://flatuicolors.com), all flat color start with `Flat`, e.g. `PETER RIVER` on the website maps to `FlatPeterRiver` in the enum. |


#### `GradientDesignable`
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| gradientMode | Optional&lt;GradientMode> | Gradient mode. All gradient mode are in enum [`GradientMode`](../Sources/Enums/GradientMode.swift), default value is `.linear`. |
| startColor | Optional&lt;UIColor> | start gradient color |
| endColor | Optional&lt;UIColor> | end gradient color |
| predefinedGradient | Optional&lt;String> | Predefined gradients. All predefined gradients are in enum [`GradientType`](../Sources/Enums/GradientType.swift), To find the predefined gradients, you can use [uigradients.com](http://uigradients.com), e.g. `Juicy Orange` on the website maps to `JuicyOrange` in the enum. |
| startPoint | Optional&lt;String> | start direction point, can find in enum [`GradientStartPoint `](../Sources/Enums/GradientStartPoint.swift). |

#### `NavigationBarDesignable`
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| solidColor | Bool | whether to display solid color only. The default value is `false`. Need to manually uncheck translucent in Interface Builder, otherwise, it will have constraint issue in IB although it is correct in run time. |

#### `MaskDesignable`
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| maskType | Optional&lt;String> | Supported maks type: All predefined animations are in enum [`MaskType`](../Sources/Enums/MaskType.swift) |

**Supported MaskType:**

* `circle`
* `ellipse`
* `polygon`: Can also specify the number of sides of the polygon, e.g. use `Polygon(6)` to have a polygon with 6 sides. If not specified, the default is 6 sides.
* `triangle`
* `star`: Can also specify the points of the Star, e.g. use `Star(6)` to have a star with 6 points. If not specified, the default is 5 points.
* `wave`: Can use parameters to customize the `Wave`. `Wave(down, 20, 5)` means the Wave faces down, width is 20 and offset is 5. If not specified, the default value is `Wave(up, 40, 0)`.
* `parallelogram`: Can use parameters to customize the `Parallelogram`. `Parallelogram(60)` means the top left angle of the Parallelogram will have an angle of 60 degrees. The default value is `Parallelogram(60)`. if angle == 90 it will be a rectangular Mask. if angle < 90 the parallelogram will be oriented to left.
* `heart`
* `ring`: Can also specify the radius of the Ring, e.g. use `Ring(6)` to have a ring with 6 as radius.
* `gear`: Can also specify the radius of the Gear and the number of cogs , e.g. use `Gear(6, 8)` to have a gear with 6 as radius and 8 cogs.
* `superellipse`: Can also specify the curve of [Superellipse](https://en.wikipedia.org/wiki/Superellipse), e.g use `superellipse(1)` to have a diamond.
* `drop`
* `plussign`: Can also specify the thickness of the plus sign, e.g. use `Plussign(10)` to have a plug sign with 10 as thickness.
* `moon`: Can also specify the angle to change the Moon shape.
* `insetBy`: Must use the parameters to defined the inset for the inner rectangle e.g. use `insetBy(10, 12)`.
* `rounded`: Choose the radius to define the corner radius, eg. use `rounded(10)`. Can also specify the `CornerSides` to choose rouned the corner, eg. use `rounded(10, topLeft)`.
* `roundedPolygon`: Could specify the number of sides of the polygon and the radius to define the corner radius, eg. use `roundedPolygon(6, 10)`. 
* `kite`: Can use parameters to customize the `kite`. `kite(60)` means the top angle of the kite with its median will have an angle of 60 degrees. The default value is `kite(74)`. if angle == 90 it will be a triangle Mask. if angle > 90 the kite will be a "dart" or "arrowhead".
* `custom`: Allows you to use your own bezier path as mask. Only usable from code (not from IB). You have to pass in parameter a closure that takes a `CGSize` (the current's view Size) and returns the `UIBezierPath`


#### `PaddingDesignable`
It is used in `AnimatableTextField` to add padding on either or both sides.

| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| paddingLeft | CGFloat | padding on left-hand side. The default value is `CGFloat.NaN`. |
| paddingRight | CGFloat | padding on right-hand side. The default value is `CGFloat.NaN`. |
| paddingSide | CGFloat | padding on both sides. The default value is `CGFloat.NaN`. |

#### `PlaceholderDesignable`
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| placeholderColor | Optional&lt;UIColor> | placeholder text color in `AnimatableTextField` and `AnimatableTextView`. |
| placeholderText | Optional&lt;String> | placeholder text in `AnimatableTextView`. |

#### `RootWindowDesignable`
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| rootWindowBackgroundColor | Optional&lt;UIColor> | root window background color. Can be seen when we use flip transition. |

#### `RotationDesignable`
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| rotate | CGFloat | rotation of the UI element in degrees. The default value is `CGFloat.NaN`, value is from -360 to 360, if the value is negative, it rotates reverse. |

#### `ShadowDesignable`
Drop shadow of the UI element, it is popular in Material Design. These properties are not able to render in IB correctly, it probably is an Interface Builder's bug.

| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| shadowColor | Optional&lt;UIColor> | shadow color |
| shadowRadius | CGFloat | shadow corner radius. The default value is `CGFloat.NaN`, the value is greater than 0. |
| shadowOpacity | CGFloat | shadow opacity. The default value is `CGFloat.NaN`, the value is from 0.0 to 1.0. |
| shadowOffset | CGPoint | `x` is horizontal offset and `y` is vertical offset. |

#### `SideImageDesignable`
Display a side hint image in `AnimatableTextField`

| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| leftImage | Optional&lt;UIImage> | the image to display on the left-hand side. |
| leftImageLeftPadding | CGFloat | left padding of hint image. The default value is `CGFloat.NaN`. |
| leftImageRightPadding | CGFloat | right padding of hint image. The default value is `CGFloat.NaN`. |
| leftImageTopPadding | CGFloat | top padding of hint image. The default value is `CGFloat.NaN`. If not specified, the image will center vertically. |
| rightImage | Optional&lt;UIImage> | the image to display on the right-hand side. |
| rightImageLeftPadding | CGFloat | left padding of hint image. The default value is `CGFloat.NaN`. |
| rightImageRightPadding | CGFloat | right padding of hint image. The default value is `CGFloat.NaN`. |
| rightImageTopPadding | CGFloat | top padding of hint image. The default value is `CGFloat.NaN`. If not specified, the image will center vertically. |

#### `StatusBarDesignable`
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| lightStatusBar | Bool | to display white or black text status bar. The default value is `false` to display black text. |

#### `TableViewCellDesignable`
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| removeSeparatorMargins | Bool | whether to remove separator margins in `AnimatableTableViewCell`. The default value is `false`. There maybe a bug of Interface Builder when setting "Separator Insert" to 0 doesn't work. |

#### `TintDesignable`
Easily add color layer on top of the UI element especially `AnimatableImageView`.

| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| tintOpacity | CGFloat | opacity of tint color (white color). The default value is `CGFloat.NaN`. |
| shadeOpacity | CGFloat | opacity of shade color (black color). The default value is `CGFloat.NaN`. |
| toneColor | Optional&lt;UIColor> | tone color|
| toneOpacity | CGFloat | opacity of tone color. The default value is `CGFloat.NaN`. |

#### `ViewControllerDesignable`

| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| hideNavigationBar | Bool | whether to hide navigation bar. The default value is `false`. |

#### `RefreshControlDesignable`


| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| hasRefreshControl | Bool | whether to add a `UIRefreshControl`. The default value is `false`. |
| refreshControlTintColor | Optional&lt;UIColor> | tint color of the `UIRefreshControl` |
| refreshControlBackgroundColor | Optional&lt;UIColor> | background color of the `UIRefreshControl`  |

**Note:** `AnimatableTableView` conforms to that protocol, **but** if your deployment target is less than 10, you will have to add your `UIRefreshControl` yourself:

```
let refreshControl: UIRefreshControl?
if #available(iOS 10.0, *) {
  refreshControl = tableView.refreshControl
} else {
  refreshControl = UIRefreshControl()
  tableView.addSubview(refreshControl!)
  tableView.configureRefreshController()
}
refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
```

#### `SliderImagesDesignable`

| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| thumbImage | Optional&lt;UIImage> | the thumb image when slider state is `normal`. |
| thumbHighlightedImage | Optional&lt;UIImage> | the thumb image when slider state is `highlighted`. |
| minimumTrackImage | Optional&lt;UIImage> | the minimum track image when slider state is `normal`. |
| minimumTrackHighlightedImage | Optional&lt;UIImage> | the minimum track image when slider state is `highlighted`. |
| maximumTrackImage | Optional&lt;UIImage> | the maximum track image when slider state is `normal`. |
| maximumTrackHighlightedImage | Optional&lt;UIImage> | the maximum track image when slider state is `highlighted`. |

### Animatable protocol
#### Properties
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| animationType | Optional&lt;String> | Supported animations. All predefined animations are in enum [`AnimationType`](../Sources/Enums/AnimationType.swift) |
| autoRun | Bool | Whether to automatically start the animation. The default value is `true`. if it is true, the animation will automatically run when the view is loaded. If want to manually start the animation should set it to `false`. |
| duration | CGFloat | Animation duration in seconds. The default value is 0.7. |
| delay | Double | Delay to start the animation in seconds. The default value is 0. |
| damping | CGFloat | Used in UIView Spring animation (0 ~ 1 seconds). To smoothly decelerate the animation without oscillation, use a value of 1. Employ a damping ratio closer to zero to increase oscillation. The default value is 0.7. Notice: FadeOutIn, FadeInOut, Shake, Pop, Morph, Squeeze, Flash, Wobble and Swing animations do not use damping. |
| velocity | CGFloat | used in UIView Spring animation. A value of 1 corresponds to the total animation distance traversed in one second. For example, if the total animation distance is 200 points and you want the start of the animation to match a view velocity of 100 pt/s, use a value of 0.5. The default is 0.7. Notice: FadeOutIn, FadeInOut, Shake, Pop, Morph, Squeeze, Flash, Wobble and Swing animations do not use damping. |
| force | CGFloat | used to apply force to the animation. The number is higher, the animation property has more changes. e.g. for Pop animation, the higher force causes the view popping bigger. The default value is 1. |
| timingFunction | TimingFunctionType | used to specifies the speed curve of an animation. For Spring animation only `linear`, `easeIn`, `easeOut` and `easeInOut` could be used and `velocity` and `damping` parameters will be ignored. The default value is `none`. |
| repeatCount | Float | Used to specify the count to repeat the animation. Can only be used in Shake, Pop, Morph, Squeeze, Flash, Wobble, Swing, Rotate and RotateCCW (rotate counterclockwise) animations. The default value is 1.  |
| x | CGFloat | Used to specify the absolute x to move in `MoveTo` animation and x offset in `MoveBy`. When used in `MoveBy`, negative means moving left and positive means moving right. The default value is `CGFloat.NaN` |
| y | CGFloat | Used to specify the absolute y to move in `MoveTo` animation and y offset in `MoveBy`. When used in `MoveBy`, negative means moving up and positive means moving down. The default value is `CGFloat.NaN`|

### TransitionAnimatable protocol
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| transitionAnimationType | Optional&lt;String> | Supported transition animations. Tap on "Playground" button to see all predefined transition animations, e.g. `Fade`, `SystemCube(Left)` and `SystemPageCurl(Bottom)`. The transition type starts with `System` can only use in Push/Pop transitions, not Present/Dismiss transitions. Note: For `SystemRotate` seems that only `SystemRotate(90)` is working. |
| transitionDuration | Double | transition duration. The default value is defined in [`Constants`](../Sources/Common/Constants.swift) (0.7 seconds) |
| interactiveGestureType | Optional&lt;String> | interactive gesture type. used to specify the gesture to dismiss/pop current scence. All supported interactive gesture types are in [`InteractiveGestureType`](../Sources/Enums/InteractiveGestureType.swift) |

Also see [Transition Animators](Transitions.md#transition-animators) and [Interactive Animators](Transitions.md#interactive-animators)

### ActivityIndicatorAnimatable

Fully documented in [Activity indicator animations](ActivityIndicators.md)

### Extension
#### UIViewController
With these methods, we can navigate back or dismiss current ViewController without any code in Interface Builder.

| Method name | Description |
| ------------- | ----- |
| func unwindToViewController(sender: UIStoryboardSegue) | Used in Interface Builder to unwind from Navigation Controller |
| func dismissCurrentViewController(sender: UIStoryboardSegue) | Used in Interface Builder to dismiss current ViewController |

#### CALayer
| Method name | Description |
| ------------- | ----- |
| class func animate(animation: AnimatableExecution, completion: AnimatableCompletion? = nil) | Simplify CALayer animations with completion closure |

### TransitionAnimatable protocol
| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| transitionAnimationType | Optional&lt;String> | Supported transition animations. Tap on "Forgot Password" button to see all predefined transition animations, e.g. `Fade`, `SystemCube(Left)` and `SystemPageCurl(Bottom)`. The transition type starts with `System` can only use in Push/Pop transitions, not Present/Dismiss transitions. Note: For `SystemRotate` seems that only `SystemRotate(90)` is working. |
| transitionDuration | Double | transition duration. The default value is defined in [`Constants`](../Sources/Common/Constants.swift) (0.7 seconds) |
| interactiveGestureType | Optional&lt;String> | interactive gesture type. used to specify the gesture to dismiss/pop current scence. All supported interactive gesture types are in [`InteractiveGestureType`](../Sources/Enums/InteractiveGestureType.swift) |

Also see [Transition Animators](Transitions.md#transition-animators) and [Interactive Animators](Transitions.md#interactive-animators)

### Segues
See [Segues](Transitions.md#segues)
