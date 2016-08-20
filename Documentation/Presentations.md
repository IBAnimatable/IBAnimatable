# How to design and prototype custom presentation animation in Interface Builder with IBAnimatable

For most of the non-trivial apps, we have to present modally some Scene (`ViewController`). August 20th, 2016 as of this writing, out of the box, Interface Builder only supports fullscreen presentation with limited animations e.g. "Cover Vertical" and "Flip Horizontal". With `IBAnimatable` we can configure in the interface builder the presentation animation, the dismissal animation, the modal size, the `dimmingView` appearance, and even more.


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
| Modal Position |   |  |
| Modal width |   |  |
| Modal height |   |  |
| Corner Radius |   |  |
| Dismiss On Tap |   |  |
| Background Color |   |  |
| Opacity |   |  |
| Blur Effect style |   |  |
| Blur Opacity |   |  |
| Shadow Color |   |  |
| Opacity Radius |   |  |
| Shadow Opacity |   |  |
| Shadow Offset |   |  |
| Keyboard Translation |   |  |

![Transition - Present Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentTransitionAnimation.png)

Once we configure those properties, **ALL Transition** (please notice it is all, including Present and Exit Segues) for this `ViewController` will use the configured animation effect. The transition animation will look like this based on the settings above. 

![Transition - Present Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentTransition.gif)

You can see the example in "TransitionsInInterfaceBuilder.storyboard" and play around different configurations. Then open the App and tap on "Playground" button, and tap on "transitions" cell to navigate to Transitions Scene. Tap on "IB" button to see the configurations you made in "TransitionsInInterfaceBuilder.storyboard".

If you want to have separate animation effect for different **Present Transition**, see the section [Configuring Present transition in Interface Builder via Segue](#configuring-present-transition-in-interface-builder-via-segue).

## Configuring a Presentation in Interface Builder via Segue

<!--In some case, we may want to have different animation effect for various **Present Transition**. `IBAnimatable` provides a set of custom Segues to support that. You can find all supported Segues in [Segues](#segues) section.

To use custom Segue, we can **control drag** from one `ViewController` to another `ViewController`, then select a custom Segue e.g. "present portal with dismiss interaction". Because Interface Builder doesn't support `@IBInspectable` for Segue, we are not able to change the transition direction, duration and dismissal gesture. There are one or two Segues for each **Transition Animator**. One is without dismissal interaction, and one's with (if this transition animator has interactive dismissal gesture). For example, for `PortalAnimator`, we have "present portal" for **Portal animation** without dismissal interaction, and have "present portal with dismiss interaction" for **Portal animation** with default dismissal interaction, which is `Pinch(Close)`. 

![Transition - Present Transition via Segue](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentTransitionViaSegue.png)

After we select "present portal with dismiss interaction", we need to check the **Module** in Attributes inspector (![Attributes inspector](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/AttributesInspector.png)). The App may crash if the field is empty. It probably is a bug of Interface Builder. To fix it just simply click on the **Module** field and hit enter, it should show **IBAnimatable**. If everything is ready, we can see the transition animation like this as below. We can have more than one Segue within the same ViewController. They will have different transition animation based on the selected Segue.

![Transition - Present Transition via Segue](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/PresentTransitionViaSegue.gif)

You can see the example in "Presentations.storyboard" and play around with the different configurations.-->

## Presentation Animators

`IBAnimatable` provide a broad set of Presentation Animators. We can use them in Interface Builder as **Presentation Animation** and **Dismiss Animation** as described in [Configuring Present transition in Interface Builder](#configuring-present-transition-in-interface-builder), or programmatically in code. They are all standard Transition Animators conform to `UIViewControllerAnimatedTransitioning`.

You can see all supported Transition Animators in the demo App, open the App and tap on "Playground" button, then tap on "presentations", then play with the different options.

### Flip

| Value | Effect |
| ------------- | ------------- |
| `Flip ` | TODO |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/FadeTransition.gif)

### CrossDissolve

| Value | Effect |
| ------------- | ------------- |
| `CrossDissolve` | Cross fade |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/FadeTransition.gif)

### Cover

| Value | Effect |
| ------------- | ------------- |
| `Cover` | Slide in / out |

### Zoom

| Value | Effect |
| ------------- | ------------- |
| `Zoom` | TODO |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/FadeTransition.gif)

### DropDown

| Value | Effect |
| ------------- | ------------- |
| `DropDown` | TODO |

![Transition - Fade Transition](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/FadeTransition.gif)


## Contribution

If you'd like to add more presentation animations to `IBAnimatable`, it is super easy, please have a look at [How to develop an animator (animation controller)](https://github.com/IBAnimatable/IBAnimatable/wiki/How-to-develop-an-animator-(animation-controller)). Let's have some fun 😉. If you have any question, please open an issue. 