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

Once we configure these propertis, all **Present Transition** for this `ViewController` will use the configured animation effect. If you want to have separate animation effect for different **Present Transition**, see the section below.

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/PresentTransition.gif)


## Configuring Present transition in Interface Builder via Segue
In some case, we may want to have different animation effect for different **Present Transition**. `IBAnimatable` provides a set of custom Segues to support that. You can find all supported Segues in [Segues]() section.

To use custom Segue, we can **control drag** from one `ViewController` to another `ViewController`, then select a custom Segue e.g. "present portal with dismiss interaction". Because Interface Builder doesn't support `@IBInspectable` for Segue, we are not able to change the transition direction, duration and dismissal gesture. There are one or two Segues for each **Transition Animator**. One is without dismiss interaction and one's with(if this transition animator has interactive dismissal gesture). For example, for `PortalAnimator`, we have "present portal" for **Portal aniamtion** without dismiss interaction, and have "present portal with dismiss interaction" for **Portal aniamtion** with default dismiss interaction, which is `Pinch(Close)`. 

![Transition - Present Transition](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/PresentTransitionViaSegue.png)

After we select "present portal with dismiss interaction", we need to check the **Module** in Attributes inspector (![](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/AttributesInspector.png)). The App may crash if the field is empty. It probably is a bug of Interface Builder. To fix it just simply click on the **Module** field and hit enter, it should show **IBAnimatable**. If everything is ready, we can see the transition animation like this 😘. We can have more than one Segue within the same ViewController. They will have different transition animation based on the selected Segue.

![Transition - Present Transition via Segue](https://raw.githubusercontent.com/JakeLin/IBAnimatable-Misc/master/IBAnimatable/PresentTransitionViaSegue.gif)

## Transition Animators

## Interactive Animators

## Segues









