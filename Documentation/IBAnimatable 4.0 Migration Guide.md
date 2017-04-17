# IBAnimatable 4.0 Migration Guide

IBAnimatable 4.0 is the latest major release of IBAnimatable, a library for designing and prototyping customized UI, interaction, navigation, transition and animation for App Store ready Apps in Interface Builder. As a major release, following Semantic Versioning conventions, 4.0 introduces API-breaking changes.

This guide is provided in order to ease the transition of existing applications using IBAnimatable 3.x to the latest APIs, as well as explaining the design and structure of new and updated functionality.

## Requirements

- iOS 8.0+
- Xcode 8.0+
- Swift 3.0+

## Benefits of upgrading
- **New promise-like animation APIs:** uses promise-like animation API to replace nested closures syntax.

## Breaking API Changes
IBAnimatable 4 has introduced new promise-like animation APIs. If you used the old animation APIs in code before, this document can help you identify most changes for those APIs.

### Animation APIs
#### Animations in Interface Builder
If your animations are configured in Interface Builder. There are no breaking changes at all 🎉 

#### Animations in code

This is an example of how we've improved the animation APIs. Before version 4, we created chain-able animations like

```swift
view.squeezeFade(.in, direction: .down) {
  view.pop(repeatCount: 1) {
    view.shake(repeatCount: 1) {
      view.squeeze(repeatCount: 1) {
        view.wobble(repeatCount: 1) {
          view.flip(axis: .x) {
            view.flip(axis: .y) {
              view.slideFade(.out, direction: .down)
            }
          }
        }
      }
    }
  }
}
```

It is ugly since we have to nest all animation within closures.

If we need to customize the animation e.g. velocity. We need to change the view's property like 

```swift
view.squeezeFade(.in, direction: .down) {
  view.velocity = 2
  view.pop(repeatCount: 1) {
    // There is a side effect, the `velocity` for the next animation is also `2`
  	  view.shake(repeatCount: 1)
  }
}
```
After we set `velocity` for animation `pop`, we create a side effect to pass the value to the next animation. In this case, which is `shake`.

To fix those issues, we created promise-like animation APIs.

We can implement the same animation effect as above like

```swift
view.animate(.squeezeFade(way: .in, direction: .down))
    .then(.pop(repeatCount: 1))
    .then(.shake(repeatCount: 1))
    .then(.squeeze(way: .in, direction: .down))
    .then(.wobble(repeatCount: 1))
    .then(.flip(along: .x))
    .then(.flip(along: .y))
    .then(.slideFade(way: .out, direction: .down))
    .completion { print("Animations finished!") }
```

That's nice, clean and more understandable.

#### Animation API Changes
##### No more completion closures
As you have seen above, we remove all completion closures. We can use nice syntax `animate`, `delay` and `then` to compose the chain-able animations.

##### Removing individual animation API
We remove all individual animation API like `slide(.in, direction: .left)`, `pop(repeatCount: 1)` and so on. They are replaced by `animate()` method with `AnimationType` enum like `animate(.slide(way: .in, direction: .left))` and `animate(.pop(repeatCount: 1))`. You can find all changes in [this commit: Update "Predefined Animations" to new animation API](https://github.com/IBAnimatable/IBAnimatable/commit/17e1f9c6c77fea56ac2a47d0fb48fba6c5da972d)

##### Customizing animation in parameters
Before, to customize the animation, we needed to change the view's properties and then call `animate()` method.

```swift
view.animationType = .squeeze(way: .in, direction: .left)
view.duration = 0.8
view.delay = 0.5
view.damping = 0.5
view.velocity = 2
view.force = 1
view.animate()
``` 

But now, changing those properties in code won't take effect any more. We need to pass them as parameters

```swift
let animationType: AnimationType = .squeeze(way: .in, direction: .left)
let duration: TimeInterval = 1
let delay: TimeInterval = 1
let damping: CGFloat = 0.5
let velocity: CGFloat = 2
let force: CGFloat = 1
view.animate(animationType, duration: duration, damping: damping, velocity: velocity, force: force)
    .delay(delay)
    .then(.shake(repeatCount: 1))
```

To delay the first animation, we can call `delay` method first.

```swift
view.delay(delay)
    .then(animationType, duration: duration, damping: damping, velocity: velocity, force: force)
```

More details can be found in [this commit: Update "Animation Properties" playground to new animation API.](https://github.com/IBAnimatable/IBAnimatable/commit/d0e05864962617a121600c66b8fad9baed77dbf5)

## Other breaking changes
There are some other breaking changes, please see [CHANGELOG.md](../CHANGELOG.md).

## Credits
Great thanks to @lastMove and @tbaranes for driving and implementing these changes 👍👍👍

--
If you have found any issues for the migration, please create an issue. Please create a PR if you find the solution, thanks.


