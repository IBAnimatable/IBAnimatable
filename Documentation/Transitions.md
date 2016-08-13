# How to design and prototype custom transition animation and gesture interaction in Interface Builder with IBAnimatable

For most of the non-trivial apps, they may have more than one Scene (ViewController). In that case, we need to support navigation. Interface Builder is a great to prototype navigation like presenting or pushing another ViewController from current ViewController. To improve the user experiences, we can display transition animation when navigating from one scene to another. May 30th, 2016 as of this writing, out of the box, Interface Builder only supports a small set of transition animations for Present e.g. "Cover Vertical" and "Flip Horizontal". With `IBAnimatable` we can configure custom transition animation and gesture interaction in Interface Builder. As of this writing, `IBAnimatable` is the first and the only one open source library supports those features.


## Configuring Present transition in Interface Builder

There are two ways to configure Present transition in Interface Builder with `IBAnimatable`. The first one is to use `AnimatableViewController`

Firstly, select a `UIViewController` then configure the custom class to `AnimatableViewController` in Identity inspector (![Identity inspector](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/IdentityInspector.png))

![Transition - AnimatableViewController](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/TransitionUsingAnimatableViewController.png)

Then we can configure **Transition Animation**, **Transition Duration** and **Interactive Gesture** properties in Attributes inspector (![Attributes inspector](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/AttributesInspector.png)). 

| Property | Description | Example |
| ------------- | ------------- | ------------- |
| Transition Animation | The animation effect when *Present* or *Dismiss* a `ViewController`, you can find all supported transition animations in [Transition Animators](#transition-animators) section. Please notices, The animators named with `System***` do not support the *Present* transition. | `Fade` for fade animation, some animator can support parameters, e.g. `Portal(Forward)` for portal forward animation, and `Portal(Backward)` for portal backward animation. |
| Transition Duration | The duration of the transition animation in seconds. The default value is `0.7` | `0.5` means half a second, `2` means two seconds |
| Interactive Gesture | The gesture used to *Dismiss* the `ViewController`, you can find all supported interactive gestures in [Interactive Animators](#interactive-animators) section. There is no gesture for *Dismiss* if it is unset (nil). Some **Transition Animator** has a default gesture, you can set this property to `Default` to use the default gesture. You can find all default gesture in [Transition Animators](#transition-animators)  | `Default` for `FadeAnimator` is `Pan(Horizontal)` gesture which means pan horizontally. And `Pinch(Close)` means pinch close gesture. |

![Transition - Present Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentTransitionAnimation.png)

Once we configure those properties, **ALL Transition** (please notice it is all, including Present and Exit Segues) for this `ViewController` will use the configured animation effect. The transition animation will look like this based on the settings above. 

![Transition - Present Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentTransition.gif)

You can see the example in "TransitionsInInterfaceBuilder.storyboard" and play around different configurations. Then open the App and tap on "Playground" button, and tap on "transitions" cell to navigate to Transitions Scene. Tap on "IB" button to see the configurations you made in "TransitionsInInterfaceBuilder.storyboard".

If you want to have separate animation effect for different **Present Transition**, see the section [Configuring Present transition in Interface Builder via Segue](#configuring-present-transition-in-interface-builder-via-segue).

## Configuring Present transition in Interface Builder via Segue

In some case, we may want to have different animation effect for various **Present Transition**. `IBAnimatable` provides a set of custom Segues to support that. You can find all supported Segues in [Segues](#segues) section.

To use custom Segue, we can **control drag** from one `ViewController` to another `ViewController`, then select a custom Segue e.g. "present portal with dismiss interaction". Because Interface Builder doesn't support `@IBInspectable` for Segue, we are not able to change the transition direction, duration and dismissal gesture. There are one or two Segues for each **Transition Animator**. One is without dismissal interaction, and one's with (if this transition animator has interactive dismissal gesture). For example, for `PortalAnimator`, we have "present portal" for **Portal animation** without dismissal interaction, and have "present portal with dismiss interaction" for **Portal animation** with default dismissal interaction, which is `Pinch(Close)`. 

![Transition - Present Transition via Segue](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentTransitionViaSegue.png)

After we select "present portal with dismiss interaction", we need to check the **Module** in Attributes inspector (![Attributes inspector](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/AttributesInspector.png)). The App may crash if the field is empty. It probably is a bug of Interface Builder. To fix it just simply click on the **Module** field and hit enter, it should show **IBAnimatable**. If everything is ready, we can see the transition animation like this as below. We can have more than one Segue within the same ViewController. They will have different transition animation based on the selected Segue.

![Transition - Present Transition via Segue](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentTransitionViaSegue.gif)

You can see the example in "TransitionsInInterfaceBuilder.storyboard" and play around different configurations.

## Configuring Push transition in Interface Builder

To use Push transition, we need to have a `UINavigationController`. Firstly, select a `UINavigationController` then set the class to `AnimatableNavigationController` in Identity inspector (![Identity inspector](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/IdentityInspector.png))

![Transition - Transition using AnimatableNavigationController](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/TransitionUsingAnimatableNavigationController.png)

Then we can configure **Transition Animation**, **Transition Duration** and **Interactive Gesture** properties in Attributes inspector (![Attributes inspector](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/AttributesInspector.png)). Those properties are as same as in [Configuring Present transition in Interface Builder](#configuring-present-transition-in-interface-builder) section. The differences are we can use `System***Animator` classes in **Transition Animation**, e.g. `SystemCube(Left)` for System Cube transtion.

![Transition - Push Transition settings](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PushTransitionSettings.png)

Once we configure those properties, all **Push Transitions** inside the `NavigationController` will use the configured animation effect. We usually don't have different effects inside the same `NavigationController`, so we don't provide Push Segues to support different transition animations. If you still want to have different transition animations, we can use Apple default API to achieve that. Please check out `UINavigationControllerDelegate`.

![Transition - Push Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PushTransition.gif)

You can see the example in "TransitionsInInterfaceBuilder.storyboard" and play around different configurations.

## Transition Animators

`IBAnimatable` provide a broad set of Transition Animators / Controllers. We can use them in Interface Builder as **Transition Animation** as described in [Configuring Present transition in Interface Builder](#configuring-present-transition-in-interface-builder) and [Configuring Push transition in Interface Builder](#configuring-push-transition-in-interface-builder), or programmatically in code. They are all standard Transition Animators / Controllers conform to `UIViewControllerAnimatedTransitioning`.

You can see all supported Transition Animators in the demo App, open the App and tap on "Playground" button, then tap on "transitions" cell to see all transitions.

### FadeAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Fade` | Cross fade | Pan(Horizontal) |
| `Fade(In)` | Fade in | Pan(Horizontal) |
| `Fade(Out)` | Fade out | Pan(Horizontal) |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/FadeTransition.gif)

### SystemCubeAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemCube(Left)` | Cube effect from left | Pan(Right) |
| `SystemCube(Right)` | Cube effect from Right | Pan(Left) |
| `SystemCube(Top)` | Cube effect from top | Pan(Bottom) |
| `SystemCube(Bottom)` | Cube effect from bottom | Pan(Top) |

Please notice, it doesn't support the Present transition.

![Transition - System Cube Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/SystemCubeTransition.gif)

### SystemFlipAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemFlip(Left)` | Flip from left | Pan(Right) |
| `SystemFlip(Right)` | Flip from Right | Pan(Left) |
| `SystemFlip(Top)` | Flip from top | Pan(Bottom) |
| `SystemFlip(Bottom)` | Flip from bottom | Pan(Top) |

Please notice, it doesn't support the Present transition.

![Transition - System Flip Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/SystemFlipTransition.gif)

### SystemMoveInAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemMoveIn(Left)` | Move in from left | Pan(Right) |
| `SystemMoveIn(Right)` | Move in from Right | Pan(Left) |
| `SystemMoveIn(Top)` | Move in from top | Pan(Bottom) |
| `SystemMoveIn(Bottom)` | Move in from bottom | Pan(Top) |

Please notice, it doesn't support the Present transition.

![Transition - System Move In Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/SystemMoveInTransition.gif)

### SystemPushAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemPush(Left)` | Push from left | Pan(Right) |
| `SystemPush(Right)` | Push from right | Pan(Left) |
| `SystemPush(Top)` | Push from top | Pan(Bottom) |
| `SystemPush(Bottom)` | Push from bottom | Pan(Top) |

Please notice, it doesn't support the Present transition.

![Transition - System Push Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/SystemPushTransition.gif)

### SystemRevealAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemReveal(Left)` | Reveal from left | Pan(Right) |
| `SystemReveal(Right)` | Reveal from Right | Pan(Left) |
| `SystemReveal(Top)` | Reveal from top | Pan(Bottom) |
| `SystemReveal(Bottom)` | Reveal from bottom | Pan(Top) |

Please notice, it doesn't support the Present transition.

![Transition - System Reveal Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/SystemRevealTransition.gif)

### SystemPageAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemPage(Curl)` | Page curl effect | None |
| `SystemPage(UnCurl)` | Page uncurl effect | None |

Please notice, it doesn't support Present transtion.

![Transition - System Page Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/SystemPageTransition.gif)

### SystemCameralrisAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemCameralris` | Cameralris close and open effect | Pinch(Close) |
| `SystemCameralris(HollowOpen)` | Cameralris open effect | Pinch(Close) |
| `SystemCameralris(HollowClose)` | Cameralris close effect | Pinch(Open) |

Please notice, it doesn't support the Present transition.

![Transition - System Cameralris Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/SystemCameralrisTransition.gif)

### FoldAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Fold(Left)` | Fold from left | Pan(Right) |
| `Fold(Right)` | Fold from Right | Pan(Left) |
| `Fold(Top)` | Fold from top | Pan(Bottom) |
| `Fold(Bottom)` | Fold from bottom | Pan(Top) |

`FoldAnimator` also supports second parameter `folds`, which sets the number of folds. The default value is `2`. We can use it like `Fold(Left,5)`.

![Transition - Fold Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/FoldTransition.gif)

### PortalAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Portal(Forward)` | Portal forward effect | Pinch(Close) |
| `Portal(Backward)` | Portal backward effect | Pinch(Open) |

`PortalAnimator` also supports second parameter `zoomScale`, which sets the origin scale of the scene, the value range is from `0` to `1`, the default value is `0.8`. We can use it like `Portal(Forward,0.5)`.

![Transition - Portal Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PortalTransition.gif)

### NatGeoAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `NatGeo(Left)` | NatGeo effect to left | None |
| `NatGeo(Right)` | NatGeo effect to Right | None |

![Transition - NatGeo Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/NatGeoTransition.gif)

### TurnAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Turn(Left)` | Turn from left | Pan(Right) |
| `Turn(Right)` | Turn from Right | Pan(Left) |
| `Turn(Top)` | Turn from top | Pan(Bottom) |
| `Turn(Bottom)` | Turn from bottom | Pan(Top) |

![Transition - Turn Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/TurnTransition.gif)

### CardsAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Cards(Forward)` | Cards effect forward | None |
| `Cards(Backward)` | Cards effect backward | None |

![Transition - Cards Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/CardsTransition.gif)

### FlipAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Flip(Left)` | Flip from left | Pan(Right) |
| `Flip(Right)` | Flip from Right | Pan(Left) |

![Transition - Flip Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/FlipTransition.gif)

### SlideAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Slide(Left)` | Slide to left | Pan(Left) |
| `Slide(Right)` | Slide to Right | Pan(Right) |
| `Slide(Top)` | Slide to top | Pan(Top) |
| `Slide(Bottom)` | Slide to bottom | Pan(Bottom) |

![Transition - Slide Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/SlideTransition.gif)

`SlideAnimator ` also supports second parameter `fade`, which set the scene to fade in. If we don't specify the second parameter, it doesn't have a fade effect. We can use it like `Slide(left,fade)`.

### SystemRotateAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemRotate` | Rotate 90 degrees | None |

Please notice, it doesn't support the Present transition.

![Transition - System Rotate Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/SystemRotateTransition.gif)

### SystemRippleEffectAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemRippleEffect` | Ripple effect | None |

Please notice, it doesn't support the Present transition.

![Transition - System Ripple Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/SystemRippleEffectTransition.gif)

### SystemSuckEffectAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemSuckEffect` | Suck effect | None |

Please notice, it doesn't support the Present transition.

![Transition - System Suck Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/SystemSuckEffectTransition.gif)

### Explode

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Explode` | Explode effect | None |

`ExplodeAnimator` also supports parameters
0. `xFactor`: How many pieces in one row when explodes. The default value is `10`
0. `minAngle`: The minimum angle for the pieces when the explode animation runs. The default value is `-10`
0. `maxAngle`: The maximum angle for the pieces when the explode animation runs. The default value is `10`

We can use them like `Explode(20,-5,5)

![Transition - Explode Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ExplodeTransition.gif)

## Interactive Animators

We can use Interactive Animators / Controllers to configure gesture for Dismiss or Pop transition in Interface Builder or use them programmatically, please refer to `UINavigationControllerDelegate` and `UIViewControllerTransitioningDelegate`.

### PanInteractiveAnimator

| Value | Gesture |
| ------------- | ------------- |
| `Pan(Horizontal)` | Pan horizontally |
| `Pan(Vertical)` | Pan vertically |
| `Pan(Left)` | Pan from left |
| `Pan(Right)` | Pan from right |
| `Pan(Top)` | Pan from top |
| `Pan(Bottom)` | Pan from bottom |

### ScreenEdgePanInteractiveAnimator

| Value | Gesture |
| ------------- | ------------- |
| `ScreenEdgePan(Horizontal)` | ScreenEdgePan horizontally |
| `ScreenEdgePan(Vertical)` | ScreenEdgePan vertically |
| `ScreenEdgePan(Left)` | ScreenEdgePan from left |
| `ScreenEdgePan(Right)` | ScreenEdgePan from right |
| `ScreenEdgePan(Top)` | ScreenEdgePan from top |
| `ScreenEdgePan(Bottom)` | ScreenEdgePan from bottom |

Please notice, `ScreenEdgePan(Vertical)`, `ScreenEdgePan(Top)` and `ScreenEdgePan(Bottom)` are reserved by iOS system. In most of cases, we should not use them.

### PinchInteractiveAnimator

| Value | Gesture |
| ------------- | ------------- |
| `Pinch` | Pinch open or close |
| `Pinch(Close)` | Pinch close |
| `Pinch(Open)` | Pinch open |

You can play around the configurations in "TransitionsInInterfaceBuilder.storyboard".

## Segues

To support different animation effect for different Prsent transition, `IBAnimatable` provides a set of Present Segues.

### Present Segues

| Value | Description |
| ------------- | ------------- |
| `PresentFadeSegue` | Present segue with fade transition |
| `PresentFadeWithDismissInteractionSegue` | Present segue with fade transition, using `Pan(Horizontal)` gesture to dismiss |
| `PresentFoldSegue` | Present segue with fold from left transition |
| `PresentFoldWithDismissInteractionSegue` | Present segue with fold from left transition, using `Pan(Right)` gesture to dismiss |
| `PresentPortalSegue` | Present segue with portal forward transition |
| `PresentPortalWithDismissInteractionSegue` | Present segue with portal forward transition, using `Pinch(Close)` gesture to dismiss |
| `PresentTurnSegue` | Present segue with turn from left transition |
| `PresentTurnWithDismissInteractionSegue` | Present segue with turn from left transition, using `Pan(Right)` gesture to dismiss |
| `PresentFlipSegue` | Present segue with flip from left transition |
| `PresentFlipWithDismissInteractionSegue` | Present segue with flip from left transition, using `Pan(Right)` gesture to dismiss |
| `PresentSlideSegue` | Present segue with slide to left transition |
| `PresentSlideWithDismissInteractionSegue` | Present segue with slide to left transition, using `Pan(Left)` gesture to dismiss |
| `PresentCardsSegue` | Present segue with cards effect transition |
| `PresentNatGeoSegue` | Present segue with NatGeo effect transition |
| `PresentExplodeSegue` | Present segue with explode effect transition |

### Exit Segues

`IBAnimatale` provide some Exit Segues to help the user configure Exit / Unwind actions. To do that, we can "control drag" from a button to "Exit" icon (on top of the ViewController), then select the Segue.

![Transition - Exit Segue](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ExitSegue.png)

| Value | Description |
| ------------- | ------------- |
| `dismissCurrentViewController` | dismiss current ViewController, it is an exit action for Present transition |
| `popToRootViewController` | pop to root ViewController, it can directly pop to root of the NavigationController |
| `unwindToViewController` | unwind to previous ViewController |


## Contribution
Great thanks to [@tbaranes](https://github.com/tbaranes) who ported all transitions from [VCTransitionsLibrary](https://github.com/ColinEberhardt/VCTransitionsLibrary) and added parameters support for some transition animators.

If you'd like to add more transition animations to `IBAnimatable`, it is super easy, please have a look at [How to develop an animator (animation controller)](https://github.com/IBAnimatable/IBAnimatable/wiki/How-to-develop-an-animator-(animation-controller)). Let's have some fun 😉. You can also discuss that in [Issue 155 - Custom transition animators (animation controllers)](https://github.com/IBAnimatable/IBAnimatable/issues/155). If you have any question, please contact [@JakeLin](https://github.com/JakeLin). 


