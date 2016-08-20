# How to design and prototype custom presentation animation in Interface Builder with IBAnimatable

For most of the non-trivial apps, we have to present modally some Scene (`ViewController`). August 20th, 2016 as of this writing, out of the box, Interface Builder only supports fullscreen modals with limited animations e.g. "Cover Vertical" and "Flip Horizontal". Using `IBAnimatable` we can configure in the interface builder the presentation animation, the dismissal animation, the modal size, the `dimmingView` appearance, and a lot more.


## Configuring a Presentation in Interface Builder

In order to configure a presentation in Interface Builder with `IBAnimatable`, you have to use `AnimatableModalViewController`

Firstly, select a `UIViewController` then configure the custom class to `AnimatableModalViewController` in Identity inspector (![Identity inspector](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/IdentityInspector.png))

![Transition - AnimatableViewController](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationUsingAnimatableViewController.png)

Then we can configure the **Presentation Animations**, **Transition Duration** and **Modal specs** properties in Attributes inspector (![Attributes inspector](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/AttributesInspector.png)). 

| Property | Description | Example |
| ------------- | ------------- | ------------- |
| Presentation Animation | The animation effect when *Present* a `ViewController`, you can find all supported transition animations in [Presentation Animators](#presentation-animators) section. | `CrossDissolve` for fade animation, some animator can support parameters, e.g. `Cover(Left)`, `Cover(Right)`,`Cover(Bottom)`, and `Cover(Top)` for a slide in from a specific direction. The default value is `Cover(Bottom)` |
| Dismissal Animation | The animation effect when *Dismiss* a `ViewController`, you can find all supported transition animations in [Presentation Animators](#presentation-animators) section. By default, it will use the `Presentation animation` value | `CrossDissolve` for fade animation, some animator can support parameters, e.g. `Cover(Left)`, `Cover(Right)`,`Cover(Bottom)`, and `Cover(Top)` for a slide in from a specific direction. |
| Transition Duration | The duration of the transition animation in seconds. The default value is `0.4` | `0.5` means half a second, `2` means two seconds |
| Modal Position | The modal position when it will be presented, you can find all supported position in [Modal Position](#modal-position) section. |  |
| Modal width | The modal width when it will be presented, you can find all supported size in [Modal Size](#modal-size) section. |  |
| Modal height | The modal height when it will be presented, you can find all supported size in [Modal Size](#modal-size) section. |  |
| Corner Radius | Corner radius of your modal  |  |
| Dismiss On Tap | Dismiss the modal when tapping on the dimmingView  |  |
| Background Color | Background of the dimmingView. Default value is black |  |
| Opacity | Opacity of the background color specified above. the default value is 0.7, the value range is from 0.0 to 1.0. |  |
| Blur Effect style | Support three different blur effects: ExtraLight, Light and Dark, also can be found in emum `https://github.com/IBAnimatable/IBAnimatable/blob/master/IBAnimatable/BlurEffectStyle.swift`. The look of blur effect in Interface Builder is different from Simulator or device. |  |
| Blur Opacity | Opacity of the blur effect specified above. the default value is CGFloat.NaN, the value range is from 0.0 to 1.0. |  |
| Shadow Color | Shadow color |  |
| Opacity Radius | Shadow corner radius. The default value is CGFloat.NaN, the value is greater than 0. |  |
| Shadow Opacity | Shadow opacity. The default value is 0.7, the value is from 0.0 to 1.0. |  |
| Shadow Offset | x is horizontal offset and y is vertical offset. |  |
| Keyboard Translation | The translation applied when the keyboard is opening, you can find all supported translations in [Keyboard Translations](#keyboard-translations) section. |  |

![Transition - Present Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationSetup.png)

To present your controller, you can do either using segues as well as presenting it programatically. 
**Note:** If you don't want to use the interface builder, you can fully customise your presentation by code. The system is the same.

![Transition - Present Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationDemo.gif)

You can find that example in the demo application by choosing "Playground", then tap on "presentations". Config your presentation by choosing the your favorite setup, then just press "Present" in order to see the result.

## Modal Position

`IBAnimatable` provide a broad set of prebuild position for your modal. We can use them in Interface Builder as **Modal Position** as described in [Configuring a Presentation in Interface Builder](#configuring-a-presentation-in-interface-builder), or programmatically in code.

### Center

| Value | Effect |
| ------------- | ------------- |
| `Center` | Center the modal in the screen |

![Modal position - Center](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/Presentation Center.png)

### TopCenter

| Value | Effect |
| ------------- | ------------- |
| `TopCenter` | Horizontally center but stay at the top |

![Modal position - TopCenter](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/Presentation TopCenter.png)

### BottomCenter

| Value | Effect |
| ------------- | ------------- |
| `BottomCenter ` | Horizontally center but stay at the bottom |

![Modal position - BottomCenter](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/Presentation BottomCenter.png)

### LeftCenter

| Value | Effect |
| ------------- | ------------- |
| `LeftCenter ` | Vertically center but stay at the left |

![Modal position - LeftCenter](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/Presentation LeftCenter.png)

### RightCenter

| Value | Effect |
| ------------- | ------------- |
| `RightCenter ` | Vertically center but stay at the right |

![Modal position - RightCenter](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationCustomOrigin.png)

### CustomCenter

| Value | Effect |
| ------------- | ------------- |
| `CustomCenter(centerPoint: CGPoint)` | Custom origin (position relative to the center of the modal |

![Modal position - CustomCenter](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationCustomOrigin.png)

### CustomOrigin

| Value | Effect |
| ------------- | ------------- |
| `CustomOrigin(origin: CGPoint)` | Custom origin |

![Modal position - CustomOrigin](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationCustomOrigin.gif)

## Modal Size

`IBAnimatable` provide a broad set of prebuild size for your modal. We can use them in Interface Builder as **Modal Width** and **Modal Height** as described in [Configuring a Presentation in Interface Builder](#configuring-a-presentation-in-interface-builder), or programmatically in code.

### Half

| Value | Effect |
| ------------- | ------------- |
| `Half` | Half screen (width or height) |

![Modal size - Half](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationHalf.png)

### Full

| Value | Effect |
| ------------- | ------------- |
| `Full` | Use the full size of the screen (width or height) |

![Modal size - Full](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationFull.png)

### Custom

| Value | Effect |
| ------------- | ------------- |
| `Custom(Float)` | Set a custom value |

![Modal size - Custom](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationSizeCustom.png)

## Presentation Animators

`IBAnimatable` provide a broad set of Presentation Animators. We can use them in Interface Builder as **Presentation Animation** and **Dismiss Animation** as described in [Configuring a Presentation in Interface Builder](#configuring-a-presentation-in-interface-builder), or programmatically in code. They are all standard Transition Animators conform to `UIViewControllerAnimatedTransitioning`.

You can see all supported Transition Animators in the demo App, open the App and tap on "Playground" button, then tap on "presentations", then play with the different options.

### Flip

| Value | Effect |
| ------------- | ------------- |
| `Flip ` | |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationFlip.gif)

### CrossDissolve

| Value | Effect |
| ------------- | ------------- |
| `CrossDissolve` | Cross fade |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/CrossdissolveAnimator.gif)

### Cover

| Value | Effect |
| ------------- | ------------- |
| `Cover(Top)` | Slide in / out from top |
| `Cover(Right)` | Slide in / out from right |
| `Cover(Bottom)` | Slide in / out from bottom |
| `Cover(Left)` | Slide in / out from left |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/CoverAnimator.gif)

### Zoom

| Value | Effect |
| ------------- | ------------- |
| `Zoom` | Zoom effect |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ZoomAnimator.gif)

### DropDown

| Value | Effect |
| ------------- | ------------- |
| `DropDown` | Slide in then slide out with a drop effect |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/DropDownAnimator.gif)

## Keyboard Translations

If your modal contains an `UITextField` / `UITextView`, you can adapt its origin when the keyboard is opening
`IBAnimatable` provide a broad set of translation when the keyboard is opening. We can use them in Interface Builder as **Keyboard Transalation** as described in [Configuring a Presentation in Interface Builder](#configuring-a-presentation-in-interface-builder), or programmatically in code.

### MoveUp

| Value | Effect |
| ------------- | ------------- |
| `MoveUp` | Move the modal up of the keyboard height |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/KeyboardTranslationMoveUp.gif)

### AboveKeyboard

| Value | Effect |
| ------------- | ------------- |
| `AboveKeyboard` | Position the modal above the keyboard |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/KeyboardTranslationAboveKeyboard.gif)

You can see all supported Keyboard Translation in the demo App, open the App and tap on "Playground" button, then tap on "presentations", then play with the different options.

## Contribution

If you'd like to add more presentation animations to `IBAnimatable`, it is super easy, please have a look at [How to develop an animator (animation controller)](https://github.com/IBAnimatable/IBAnimatable/wiki/How-to-develop-an-animator-(animation-controller)). Let's have some fun 😉. If you have any question, please open an issue. 