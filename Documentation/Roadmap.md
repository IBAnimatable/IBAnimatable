# Vision, Technical Considerations and Roadmap

## Vision
IBAnimatable is an open source library to help designers and developers design and prototype customized UI, interaction, navigation, transition and animation for App Store ready Apps in Interface Builder.

## Approaches
* Adding convenient `@IBInspectable` properties to reduce numerous amount of code. e.g.`fillColor`, `cornerRadius`, `shadowColor` and `shadowOffset`.
* Providing predefined UI elements and animations. e.g. Flat UI colors, Gradient colors, and animations.
* Extending existing behaviors, e.g. More transition animations like "Fade", "Explode", "Fold" and "Portal".

## Technical Considerations
* **UIKit** - All `IBAnimatable` UI elements are based on `UIKit`.
 	* **Dos**
		* All UI elements should support Auto Layout.
		* Support existing navigation pattern like present/dismiss, push/pop.
	* **Don'ts**
		* Creating another layout system. e.g. CSS Flexbox.
		* Creating new custom navigation pattern.

* **`@IBDesginable` and `@IBInspectable`** - To design in Interface Builder, all properties should be `@IBDesginable`. Some properties cannot render properly in Interface Builder, e.g. `rotate`. Moreover, animations are not able to preview in Interface Builder. However, once Interface Builder supports, those features works properly in Interface Builder.

* **Platform - iOS** - Currently, we focus on iOS. Once iOS support is mature, we can implement more protocol extensions to support other platforms like MacOS, WatchOS, and tvOS.


* **iOS version** - Currently, `IBAnimatable` supports iOS 8 and above.
    	* **Dos**
		* Supporting latest version first and disabling them in the previous version if required.
    	* **Don'ts**
		* Sacrificing features for backward compatibilities.

* **Swift** - Currently, `IBAnimatable` supports Swift only.
	* **Dos**
		* Using Swift features and best practice like protocol extensions, enum and optional.
	* **Don'ts**
		* Avoiding Swift features to support Objective-C.

## Roadmap
### Versions
* <del>Version 1: Designable and animatable elements</del>
* Version 2: Custom transition animations and more animatable elements
* Version 3: Swift 3
* Version 4: More designable and animatable elements
* Version 5: More animations
* Version 6: Sketch plugin & Xcode plugin

You can find more details in https://github.com/IBAnimatable/IBAnimatable/milestones

### Designable elements
* Bar Button Item:
	* <del>roundedImage</del>

* Blur:
	* <del>blurEffectStyle</del>
	* <del>blurOpacity</del>
	* Motion Blur - https://github.com/IBAnimatable/IBAnimatable/issues/65

* Border:
	* <del>borderColor</del>
	* <del>borderWidth</del>
	* <del>borderSide</del>
	* <del>Border with more than one side and less than 4 sides</del>

* Checkbox:
	* <del>checked</del>
	* <del>checkedImage</del>
	* <del>uncheckedImage</del>
	* Animations for state changes - https://github.com/IBAnimatable/IBAnimatable/issues/67
	* Default checked and unchecked icon (Using path to avoid image assets?) - https://github.com/IBAnimatable/IBAnimatable/issues/68
	* Checked color - https://github.com/IBAnimatable/IBAnimatable/issues/69

* Corner:
	* <del>cornerRadius</del>

* Fill:
	* <del>fillColor</del>
	* <del>opacity</del>

* Gradient:
	* <del>startColor</del>
	* <del>endColor</del>
	* <del>startPoint</del>
	* <del>Default gradient colors</del>

* Navigation Bar:
	* <del>solidColor</del>

* Mask:
	* <del>Circle</del>
	* <del>Star</del>
	* <del>Polygon</del>
	* <del>Triangle</del>
	* <del>Wave</del>
	* <del>Parallelogram</del>

* Padding:
	* <del>paddingLeft</del>
	* <del>paddingRight</del>
	* <del>paddingSide</del>

* Placeholder:
	* <del>placeholderColor</del>

* Root Window:
	* <del>rootWindowBackgroundColor</del>

* Rotation:
	* <del>rotate</del>

* Shadow:
	* <del>shadowColor</del>
	* <del>shadowRadius</del>
	* <del>shadowOpacity</del>
	* <del>shadowOffset</del>

* SideImage:
	* <del>leftImage</del>
	* <del>leftImageLeftPadding</del>
	* <del>leftImageRightPadding</del>
	* <del>leftImageTopPadding</del>
	* <del>rightImage</del>
	* <del>RightImageLeftPadding</del>
	* <del>RightImageRightPadding</del>
	* <del>RightImageTopPadding</del>

* Status Bar:
	* <del>lightStatusBar</del>

* Table View Cell:
	* <del>removeSeparatorMargins</del>

* Tint:
	* <del>tintOpacity</del>
	* <del>shadeOpacity</del>
	* <del>toneColor</del>
	* <del>toneOpacity</del>

* View Controller:
	* <del>hideNavigationBar</del>

* Collection View and Collection View Cell - https://github.com/IBAnimatable/IBAnimatable/issues/53
* Animatable Slider - https://github.com/IBAnimatable/IBAnimatable/issues/70
* Material Design elements - and https://github.com/IBAnimatable/IBAnimatable/issues/16 and  https://github.com/IBAnimatable/IBAnimatable/issues/55
* <del>Flat colors</del>
* Motion effect, parallax effect - https://github.com/IBAnimatable/IBAnimatable/issues/18
* Segmented Control - https://github.com/IBAnimatable/IBAnimatable/issues/72
* Custom dynamic type (text style) - https://github.com/IBAnimatable/IBAnimatable/issues/73

### Animatable elements
* Animations types:
	* <del>SlideInLeft</del>
	* <del>SlideInRight</del>
	* <del>SlideInDown</del>
	* <del>SlideInUp</del>
	* <del>SlideOutLeft</del>
	* <del>SlideOutRight</del>
	* <del>SlideOutDown</del>
	* <del>SlideOutUp</del>
	* <del>SqueezeInLeft</del>
	* <del>SqueezeInRight</del>
	* <del>SqueezeInDown</del>
	* <del>SqueezeInUp</del>
	* <del>SqueezeOutLeft</del>
	* <del>SqueezeOutRight</del>
	* <del>SqueezeOutDown</del>
	* <del>SqueezeOutUp</del>
	* <del>FadeIn</del>
	* <del>FadeOut</del>
	* <del>FadeOutIn</del>
	* <del>FadeInOut</del>
	* <del>FadeInLeft</del>
	* <del>FadeInRight</del>
	* <del>FadeInDown</del>
	* <del>FadeInUp</del>
	* <del>FadeOutLeft</del>
	* <del>FadeOutRight</del>
	* <del>FadeOutDown</del>
	* <del>FadeOutUp</del>
	* <del>SqueezeFadeInLeft</del>
	* <del>SqueezeFadeInRight</del>
	* <del>SqueezeFadeInDown</del>
	* <del>SqueezeFadeInUp</del>
	* <del>SqueezeFadeOutLeft</del>
	* <del>SqueezeFadeOutRight</del>
	* <del>SqueezeFadeOutDown</del>
	* <del>SqueezeFadeOutUp</del>
	* <del>ZoomIn</del>
	* <del>ZoomOut</del>
	* <del>Shake</del>
	* <del>Pop</del>
	* <del>FlipX</del>
	* <del>FlipY</del>
	* <del>Morph</del>
	* <del>Squeeze</del>
	* <del>Flash</del>
	* <del>Wobble</del>
	* <del>Swing</del>
	* <del>Rotate</del>
	* <del>MoveTo</del>
	* <del>MoveBy</del>
	* <del>scale</del> - https://github.com/IBAnimatable/IBAnimatable/issues/121
	* Jump - https://github.com/IBAnimatable/IBAnimatable/issues/75

* Animation properties:
	* <del>animationType</del>
	* <del>autoRun</del>
	* <del>duration</del>
	* <del>delay</del>
	* <del>damping</del>
	* <del>velocity</del>
	* <del>force</del>
	* <del>repeatCount</del>
	* Animating forever? `repeatCount = Float.Infinit`
	* <del>timing: linear and easing</del>

### Interaction elements
* <del>Unwind Segue</del>
* <del>Dismiss current ViewController Segue</del>
* <del>Pop to root ViewController Segue</del>
* `AnimatablePresentationController`: [#198](https://github.com/IBAnimatable/IBAnimatable/issues/198)
	* gestureToDismiss (UIDynamics)

* `AnimatableAlertController` for `UIAlertController`
	* Standard Alert
	* Action Sheet

* Ripple effect for user interaction like https://www.google.com/design/spec/animation/responsive-interaction.html#responsive-interaction-user-input

* Dismissing keyboard automatically when tap outside of the `AnimatableTextField`.

* Automatically scrolling the view to follow the keyboard's focus.

### Navigation, transitioning animators and custom Segues
* <del>Configurable custom transition animations for Push and Pop. </del>
* <del>Configurable custom transition animations for Present and Dismiss. </del>
* <del>Configurable gesture interactions for Dismiss and Pop. </del>
* Meaningful transition like https://www.google.com/design/spec/animation/meaningful-transitions.html
* More transition like <del>https://github.com/ColinEberhardt/VCTransitionsLibrary</del> and http://transitiontreasury.com/


### Misc.
* Mock data generator
* Importing Sketch to Swift playground
* Importing Sketch to Storyboard? Maybe too hard.
* Sketch plugin to export `IBAnimatable` styles from Sketch, e.g. generating `Opacity=0.5; fillColor=#336699;` from Sketch and easily apply in Interface Builder.

**Any suggestions for the vision are welcome**, please modify the Roadmap.md file and create a PR. BTW: you can edit it on Github online and create a PR without manually forking the project now.
