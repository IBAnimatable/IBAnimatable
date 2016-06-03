# How to design and prototype custom transition animation and gesture interaction in Interface Builder with IBAnimatable

For any non-trival apps, they may have more than one Scene (ViewController). In that case, we need to support navigation. Interface Builder is a great to prototype navigation like presenting or pushing another ViewController from current ViewController. To improve the user expeirence, we can display transition animation when navigating from one scene to another. May 30th, 2016 as of this writing, out of the box, Interface Builder only supports a small set of transition animations for present e.g. "Cover Vertical" and "Flip Horizontal". With `IBAnimatable` we can configure custom transition animation and gesture interaction in Interface Builder. As of this writing `IBAnimatable` is the first and the only one open source library supports those features.


## Configuring Present transition in Interface Builder
There are two ways to configure Present transition in Interface Builder with `IBAnimatable`. The first one is to use `AnimatableViewController`

Firstly, select a `UIViewController` then configure the constom class to `AnimatableViewController` in Identity inspector (![](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/IdentityInspector.png))

![Transition - AnimatableViewController](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/TransitionUsingAnimatableViewController.png)

Then we can configure **Transition Animation**, **Transition Duration** and **Interactive Gusture** in Attributes inspector (![](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/AttributesInspector.png)). 

| Property | Description | Example |
| ------------- | ------------- | ------------- |
| Transition Animation | The animation effect when *Present* or *Dismiss* a `ViewController`, you can find all supported transition animations in [Transition Animators]() section. Please Notices, The animators named with `System***` do not support *Present* transition. | `Fade` for fade animation, some animator can support parameters, e.g. `Portal(Forward)` for portal forward animation, and `Portal(Backward)` for portal backward animation. |
| Transition Duration | The duration of the transiion animation in seconds. The default value is `0.7` | `0.5` means half a second, `2` means two seconds |
| Interactive Gusture | The gusture to *Dismiss* the `ViewController`, you can find all supported interactive gustures in [Interactive Animators]() section. There is not guesture for *Dismiss* if it is unset (nil). Some **Transition Animator** has a default gesture, you can set this property to `Default` to use the default gesture. You can find all default gesture in [Transition Animators]()  | `Default` for `FadeAnimator` means `Pan(Horizontal)` gesture. `Pinch(Close)` means pinch close gesture. |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/PresentTransitionAnimation.png)

Once we configure these propertis, all (please notice it is all, including Exit Segue 😉) **Present Transition** for this `ViewController` will use the configured animation effect. The transition animation will look like this based on the settings above. 

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/PresentTransition.gif)

If you want to have separate animation effect for different **Present Transition**, see the section below.

## Configuring Present transition in Interface Builder via Segue
In some case, we may want to have different animation effect for different **Present Transition**. `IBAnimatable` provides a set of custom Segues to support that. You can find all supported Segues in [Segues]() section.

To use custom Segue, we can **control drag** from one `ViewController` to another `ViewController`, then select a custom Segue e.g. "present portal with dismiss interaction". Because Interface Builder doesn't support `@IBInspectable` for Segue, we are not able to change the transition direction, duration and dismissal gesture. There are one or two Segues for each **Transition Animator**. One is without dismiss interaction and one's with(if this transition animator has interactive dismissal gesture). For example, for `PortalAnimator`, we have "present portal" for **Portal aniamtion** without dismiss interaction, and have "present portal with dismiss interaction" for **Portal aniamtion** with default dismiss interaction, which is `Pinch(Close)`. 

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/PresentTransitionViaSegue.png)

After we select "present portal with dismiss interaction", we need to check the **Module** in Attributes inspector (![](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/AttributesInspector.png)). The App may crash if the field is empty. It probably is a bug of Interface Builder. To fix it just simply click on the **Module** field and hit enter, it should show **IBAnimatable**. If everything is ready, we can see the transition animation like this 😘. We can have more than one Segue within the same ViewController. They will have different transition animation based on the selected Segue.

![Transition - Present Transition via Segue](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/PresentTransitionViaSegue.gif)

## Configuring Push transition in Interface Builder
To use Push transition, we need to have a `UINavigationController`. Firstly, select a `UINavigationController ` then configure the constom class to `AnimatableNavigationController` in Identity inspector (![](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/IdentityInspector.png))

![Transition - AnimatableViewController](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/TransitionUsingAnimatableNavigationController.png)

Then we can configure **Transition Animation**, **Transition Duration** and **Interactive Gusture** in Attributes inspector (![](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/AttributesInspector.png)). Those properties are same as in [Configuring Present transition in Interface Builder]() section. There difference are we can use `System***Animator`s in **Transition Animation**, e.g. `SystemCube(Left)`

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/PushTransitionSettings.png)

Once we configure these propertis, all **Push Transition** inside the `NavigationController` will use the configured animation effect. By propose, we usually don't have different effect inside the same `NavigationController`, and we don't provide Push Segues to support different transition animations. If you still want to have different transition animations, we can use Apple default API to acheive that. Please check out `UINavigationControllerDelegate`.

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/PushTransition.gif)

## Transition Animators
`IBAnimatable` provide a set of Transition Animators. They can be used in Interface Builder as **Transition Animation** as described above, or programmatically in code. They all standard Transition Animators / Controllers conform to `UIViewControllerAnimatedTransitioning`.

### FadeAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Fade` | Cross fade | Pan(Horizontal) |
| `Fade(In)` | Fade in | Pan(Horizontal) |
| `Fade(Out)` | Fade out | Pan(Horizontal) |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/FadeTransition.gif)

### SystemCubeAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemCube(Left)` | Cube effect from left | Pan(Right) |
| `SystemCube(Right)` | Cube effect from Right | Pan(Left) |
| `SystemCube(Top)` | Cube effect from top | Pan(Bottom) |
| `SystemCube(Bottom)` | Cube effect from bottom | Pan(Top) |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/SystemCubeTransition.gif)

### SystemFlipAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemFlip(Left)` | Flip from left | Pan(Right) |
| `SystemFlip(Right)` | Flip from Right | Pan(Left) |
| `SystemFlip(Top)` | Flip from top | Pan(Bottom) |
| `SystemFlip(Bottom)` | Flip from bottom | Pan(Top) |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/SystemFlipTransition.gif)

### SystemMoveInAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemMoveIn(Left)` | Move in from left | Pan(Right) |
| `SystemMoveIn(Right)` | Move in from Right | Pan(Left) |
| `SystemMoveIn(Top)` | Move in from top | Pan(Bottom) |
| `SystemMoveIn(Bottom)` | Move in from bottom | Pan(Top) |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/SystemMoveInTransition.gif)

### SystemPushAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemPush(Left)` | Push from left | Pan(Right) |
| `SystemPush(Right)` | Push from Right | Pan(Left) |
| `SystemPush(Top)` | Push from top | Pan(Bottom) |
| `SystemPush(Bottom)` | Push from bottom | Pan(Top) |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/SystemPushTransition.gif)

### SystemRevealAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemReveal(Left)` | Reveal from left | Pan(Right) |
| `SystemReveal(Right)` | Reveal from Right | Pan(Left) |
| `SystemReveal(Top)` | Reveal from top | Pan(Bottom) |
| `SystemReveal(Bottom)` | Reveal from bottom | Pan(Top) |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/SystemRevealTransition.gif)

### SystemPageAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemPage(Curl)` | Page curl effect | None |
| `SystemPage(UnCurl)` | Page uncurl effect | None |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/SystemPageTransition.gif)

### SystemCameralrisAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemCameralris` | Cameralris close and open effect | Pinch(Close) |
| `SystemCameralris(HollowOpen)` | Cameralris open effect | Pinch(Close) |
| `SystemCameralris(HollowClose)` | Cameralris close effect | Pinch(Open) |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/SystemCameralrisTransition.gif)

### FlodAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Flod(Left)` | Flod from left | Pan(Right) |
| `Flod(Right)` | Flod from Right | Pan(Left) |
| `Flod(Top)` | Flod from top | Pan(Bottom) |
| `Flod(Bottom)` | Flod from bottom | Pan(Top) |

`PortalAnimator` also supports second parameter `folds`, which sets the number of folds. The default value is `2`. We can use it like `Flod(Left,5)`.

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/FlodTransition.gif)

### PortalAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Portal(Forward)` | Portal forward effect | Pinch(Close) |
| `Portal(Backward)` | Portal backward effect | Pinch(Open) |

`PortalAnimator` also supports second parameter `zoomScale`, which sets the origin scale of the scene, the value range is from `0` to `1`, default value is `0.8`. We can use it like `Portal(Forward,0.5)`.

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/PortalTransition.gif)

### NatGeoAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `NatGeo(Left)` | NatGeo effect to left | None |
| `NatGeo(Right)` | NatGeo effect to Right | None |


![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/NatGeoTransition.gif)

### TurnAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Turn(Left)` | Turn from left | Pan(Right) |
| `Turn(Right)` | Turn from Right | Pan(Left) |
| `Turn(Top)` | Turn from top | Pan(Bottom) |
| `Turn(Bottom)` | Turn from bottom | Pan(Top) |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/TurnTransition.gif)

### CardsAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Cards(Forward)` | Cards effect forward | None |
| `Cards(Backward)` | Cards effect backward | None |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/CardsTransition.gif)

### FlipFlipAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Flip(Left)` | Flip from left | Pan(Right) |
| `Flip(Right)` | Flip from Right | Pan(Left) |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/FlipTransition.gif)

### SlideAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Slide(Left)` | Slide to left | Pan(Left) |
| `Slide(Right)` | Slide to Right | Pan(Right) |
| `Slide(Top)` | Slide to top | Pan(Top) |
| `Slide(Bottom)` | Slide to bottom | Pan(Bottom) |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/SlideTransition.gif)

`SlideAnimator ` also supports second parameter `fade`, which set the scene to fade in. If the second parameter is not set, it doesn't have fade effect. We can use it like `Slide(left,fade)`.

### SystemRotateAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemRotate` | Rotate 90 degrees | None |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/SystemRotateTransition.gif)

### SystemRippleEffectAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemRippleEffect` | Ripple effect | None |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/SystemRippleEffectTransition.gif)

### SystemSuckEffectAnimator

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `SystemSuckEffect` | Suck effect | None |

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/SystemSuckEffectTransition.gif)

### Explode

Using in **Transition Animation**

| Value | Effect | Default Interactive Animator |
| ------------- | ------------- | ------------- |
| `Expolde` | Expolde effect | None |

`ExplodeAnimator` also supports parameters
0. `xFactor`: configures how many pieces in one row when explodes. Default value is `10`
0. `minAngle`: the minimum angle for the pieces when explodes. Default value is `-10`
0. `maxAngle`: the maximum angle for the pieces when explodes. Default value is `10`

We can use them like `Explode(20,-5,5)

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/ExpoldeTransition.gif)

## Interactive Animators

## Segues









