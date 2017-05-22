# How to design and prototype custom presentation animation in Interface Builder with IBAnimatable

For most of the non-trivial apps, we have to present some modal view controller (Scene in Interface Builder). August 20th, 2016 as of this writing, out of the box, Interface Builder only supports fullscreen modals with limited animations e.g. "Cover Vertical" and "Flip Horizontal". Using `IBAnimatable` we can configure how to present a modal in the interface builder, for example, the presentation animation, the dismissal animation, the modal size, the `dimmingView` appearance, and a lot more.


## Configuring a Presentation in Interface Builder

In order to configure a presentation in Interface Builder with `IBAnimatable`, you need to use `AnimatableModalViewController`

Firstly, select a `UIViewController` then configure the custom class to `AnimatableModalViewController` in Identity inspector (![Identity inspector](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/IdentityInspector.png))

![Transition - AnimatableViewController](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationUsingAnimatableViewController.png)

Then we can configure the **Presentation Animations**, **Transition Duration** and **Modal specs** properties in Attributes inspector (![Attributes inspector](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/AttributesInspector.png)). 

| Property | Description |
| ------------- | ------------- |
| Presentation Animation | The animation effect when *Present* a `ViewController`, you can find all supported transition animations in [Presentation Animators](#presentation-animators) section. |
| Dismissal Animation | The animation effect when *Dismiss* a `ViewController`, you can find all supported transition animations in [Presentation Animators](#presentation-animators) section. By default, it will use the Presentation animation value. For example, if the Presentation animation is cover down from the top, then the default Dismissal Animation is cover up to the top. |
| Transition Duration | The duration of the transition animation in seconds. The default value is `0.4` |
| Modal Position | The modal position when it will be presented, you can find all supported position in [Modal Position](#modal-position) section. The default value is `Center` |  |
| Modal width | The modal width when it will be presented, you can find all supported size in [Modal Size](#modal-size) section. The default value is `Half` |  |
| Modal height | The modal height when it will be presented, you can find all supported size in [Modal Size](#modal-size) section. The default value is `Half` |  |
| Corner Radius | Corner radius of your modal  |  |
| Dismiss On Tap | Dismiss the modal when tapping on the dimmingView  |  |
| Background Color | Background of the dimmingView. Default value is black |  |
| Opacity | Opacity of the background color specified above. the default value is 0.7, the value range is from 0.0 to 1.0. |  |
| Blur Effect style | Support three different blur effects: ExtraLight, Light and Dark, also can be found in enum `https://github.com/IBAnimatable/IBAnimatable/blob/master/IBAnimatable/BlurEffectStyle.swift`. The look of blur effect in Interface Builder is different from Simulator or device. |  |
| Blur Opacity | Opacity of the blur effect specified above. the default value is CGFloat.NaN, the value range is from 0.0 to 1.0. |  |
| Shadow Color | Shadow color |  |
| Opacity Radius | Shadow corner radius. The default value is CGFloat.NaN, the value is greater than 0. |  |
| Shadow Opacity | Shadow opacity. The default value is 0.7, the value is from 0.0 to 1.0. |  |
| Shadow Offset | x is horizontal offset and y is vertical offset. |  |
| Keyboard Translation | The translation applied when the keyboard is opening, you can find all supported translations in [Keyboard Translations](#keyboard-translations) section. |  |

![Transition - Present Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationSetup.png)

To present your controller, you can do either using segues as well as presenting it programmpatically. 
**Note:** If you don't want to use the interface builder, you can fully customise your presentation by code. The system is the same.

![Transition - Present Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationDemo.gif)

You can find that example in the demo application by choosing "Playground", then tap on "presentations". Config your presentation by choosing the your favorite setup, then just press "Present" in order to see the result.

## Modal Position

`IBAnimatable` provides a broad set of prebuild position for your modal. We can use them in Interface Builder as **Modal Position** as described in [Configuring a Presentation in Interface Builder](#configuring-a-presentation-in-interface-builder), or programmatically in code.

### Center

| Value | Effect |
| ------------- | ------------- |
| `Center` | Center the modal in the screen |

![Modal position - Center](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationCenter.png)

### TopCenter

| Value | Effect |
| ------------- | ------------- |
| `TopCenter` | Horizontally center but stay at the top |

![Modal position - TopCenter](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationTopCenter.png)

### BottomCenter

| Value | Effect |
| ------------- | ------------- |
| `BottomCenter ` | Horizontally center but stay at the bottom |

![Modal position - BottomCenter](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationBottomCenter.png)

### LeftCenter

| Value | Effect |
| ------------- | ------------- |
| `LeftCenter ` | Vertically center but stay at the left |

![Modal position - LeftCenter](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationLeftCenter.png)

### RightCenter

| Value | Effect |
| ------------- | ------------- |
| `RightCenter ` | Vertically center but stay at the right |

![Modal position - RightCenter](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationRightCenter.png)

### CustomCenter

| Value | Effect |
| ------------- | ------------- |
| `CustomCenter(centerPoint: CGPoint)` | Custom origin (position relative to the center of the modal |

*The following screenshot is using `CustomCenter(120,320)`*

![Modal position - CustomCenter](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationCustomCenter.png)

### CustomOrigin

| Value | Effect |
| ------------- | ------------- |
| `CustomOrigin(origin: CGPoint)` | Custom origin |

*The following screenshot is using `CustomOrigin(20,20)`*

![Modal position - CustomOrigin](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationCustomOrigin.png)

## Modal Size

`IBAnimatable` provides a broad set of prebuild size for your modal. We can use them in Interface Builder as **Modal Width** and **Modal Height** as described in [Configuring a Presentation in Interface Builder](#configuring-a-presentation-in-interface-builder), or programmatically in code.

### Half

| Value | Effect |
| ------------- | ------------- |
| `Half` | Half screen (width or height) |

*The following screenshot is using `Full` as with, and `Half` as height*

![Modal size - Half](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationFullHalf.png)

### Full

| Value | Effect |
| ------------- | ------------- |
| `Full` | Use the full size of the screen (width or height) |

*The following screenshot is using `Full` as with, and `Full` as height*

![Modal size - Full](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationFull.png)

### Custom

| Value | Effect |
| ------------- | ------------- |
| `Custom(Float)` | Set a custom value |

*The following screenshot is using `Custom(300)` as with, and `Custom(300)` as height*

![Modal size - Custom](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationSizeCustom.png)

## Presentation Animators

`IBAnimatable` provides a broad set of Presentation Animators. We can use them in Interface Builder as **Presentation Animation** and **Dismissal Animation** as described in [Configuring a Presentation in Interface Builder](#configuring-a-presentation-in-interface-builder), or programmatically in code. They are all standard Transition Animators conform to `UIViewControllerAnimatedTransitioning`.

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

If your modal contains a `UITextField` or `UITextView`, you can adjust its position when the keyboard is opening. `IBAnimatable` provides a broad set of translation when the keyboard is opening. We can use them in Interface Builder as **Keyboard Transalation** as described in [Configuring a Presentation in Interface Builder](#configuring-a-presentation-in-interface-builder), or programmatically in code.

### moveUp

| Value | Effect |
| ------------- | ------------- |
| `moveUp` | Move the modal up of the keyboard height |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/KeyboardTranslationMoveUp.gif)

### aboveKeyboard

| Value | Effect |
| ------------- | ------------- |
| `aboveKeyboard` | Position the modal above the keyboard |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/KeyboardTranslationAboveKeyboard.gif)

### stickOrMoveUp

| Value | Effect |
| ------------- | ------------- |
| `stickOrMoveUp` | Move up the modal above the keyboard if the modal maxY is higher than keyboard minY |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/KeyboardTranslationStickOrMoveUpKeyboard.gif)

You can see all supported Keyboard Translation in the demo App, open the App and tap on "Playground" button, then tap on "presentations", then play with the different options.

## Presenting over current context

Using the above configuration, you can't have the same result as using `UIModalPresentationStyle.overCurrentContext`, but `IBAnimatable` have a workaround to support it while supporting *all the above customisation*.

That can be useful in a few cases, for example: having a split view controller, but you may want to present a controller over the first one, and let the second one clickable. You can see an example in the demo app: Playground -> Presentation -> Over context.

![Presentation - Over Current Context](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentationOverCurrentContext.gif)

### Using storyboards and segues

In order to use this feature in storyboards, you have to use a custom segue. To use custom Segue, we can **control drag** from one `ViewController` to another `ViewController`, then select a custom Segue and set its class to `PresentOverCurrentContextSegue`.

Using that usage allow you to use all the features of a custom presentation while writing 0 lines of code.

You can see an example in "Presentation.storyboard".

### Programatically

For this special case, `AnimatableModalViewController` has another property that's not designable:

| Property | Description |
| ------------- | ------------- |
| context frame for presentation | If not nil, the presented view controller will have use this frame, imitates `UIModalPresentationStyle.overCurrentContext`  If nil, the presented view controller will be in fullscreen. *Note:* The modal position / size will be calculated based on this if not nil. |

Anywhere before `presenting` your viewController, just set the `contextFrameForPresentation` that it should have.
For example, if you want your presented view controller to have the same frame as the `viewController` presenting it, you will just have to do:

```
modalViewController.contextFrameForPresentation = presentingVC.view.frame
modalViewController.present(presentingVC, animated: true)
```

That's all. You have presented a controller over the current context with a custom configuration!

## Contribution

If you'd like to add more presentation options to `IBAnimatable`, it is super easy, please have a look at:

- [How to develop a presentation animator](https://github.com/IBAnimatable/IBAnimatable/wiki/How-to-develop-a-presentation-animator). 
- [How to develop a keyboard translation](https://github.com/IBAnimatable/IBAnimatable/wiki/How-to-develop-a-keyboard-translation). 
- [How to develop a custom modal size](https://github.com/IBAnimatable/IBAnimatable/wiki/How-to-develop-a-custom-modal-size). 
- [How to develop a custom modal position](https://github.com/IBAnimatable/IBAnimatable/wiki/How-to-develop-a-custom-modal-position). 

Let's have some fun 😉. If you have any question, please open an issue. 