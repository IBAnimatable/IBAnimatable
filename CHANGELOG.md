# Change Log
All notable changes to this project will be documented in this file.
`IBAnimatable` adheres to [Semantic Versioning](http://semver.org/).

## Versions
### Next

#### API breaking changes

- Add `AnimatableCollectionViewCell`
- Change `PanFromLeft`, `PanFromRight`, `PanFromTop`, `PanFromBottom`, `PanHorizontally` and `PanVertically` to `Pan(Left)`, `Pan(Right)`, `Pan(Top)`, `Pan(Bottom)`, `Pan(Horizontal)` and `Pan(Vertical)` for `Pan` gesture transition controller. [#125](https://github.com/JakeLin/IBAnimatable/issues/125)
 
#### Enhancements

- Add `ScreenEdgePanInteractiveAnimator` to support `PanFromRight`, `PanFromTop`, `PanFromBottom`, `PanHorizontally` and `PanVertically` to `ScreenEdgePan(Left)`, `ScreenEdgePan(Right)`, `ScreenEdgePan(Top)`, `ScreenEdgePan(Bottom)`, `ScreenEdgePan(Horizontal)` and `ScreenEdgePan(Vertical)` for `ScreenEdgePan` gesture transition controller. [125](https://github.com/JakeLin/IBAnimatable/issues/125)
- Support multiple sides for border [#168](https://github.com/JakeLin/IBAnimatable/pull/168)
- Add `ExplodeAnimator` to support Explode transition animation. It supports parameters `Explode(xFactor, minAngle, maxAngle)`, if no specified, the default values are `Explode(10, -10, 10)`. [#155](https://github.com/JakeLin/IBAnimatable/issues/155)
- Add `FoldAnimator` to support Fold transition animation. It supports parameters `Explode(direction, nbFolds)`, if no specified, the default values are `Fold(Left, 2)`. [#155](https://github.com/JakeLin/IBAnimatable/issues/155)
- Add `PortalAnimator` to support Portal transition animation. It supports parameters `Portal(direction, zoomScale)`, if no specified, the default values are `Portal(Forward, 0.8)`. [#155](https://github.com/JakeLin/IBAnimatable/issues/155)
- Add `NatGeoAnimator` to support NatGeo transition animation. It supports only a direction `NatGeo(direction)`, if no specified, the default values are `NatGeo(Left)`. [#155](https://github.com/JakeLin/IBAnimatable/issues/155)


#### Bugfixes

- Use `weak` for the `viewController` in `InteractiveAnimator` to avoid retain cycle.
- Fixed the right image of `SideImageDesignable` [#176](https://github.com/JakeLin/IBAnimatable/issues/176)
- Fix a bug to support single side of border for AnimatableTextField [#179](https://github.com/JakeLin/IBAnimatable/issues/179)

### [2.2](https://github.com/JakeLin/IBAnimatable/releases/tag/2.2)

#### API breaking changes

- Change `SystemPageCurlAnimator` to `SystemPageAnimator` to support `SystemPage(Curl)` and `SystemPage(UnCurl)` transition animations.


#### Enhancements

- `AnimatableLabel` now conforms `BorderDesignable`
- New transition animations [#126](https://github.com/JakeLin/IBAnimatable/issues/126):
    - `SystemSuckEffect`
    - `SystemRippleEffect`
    - `SystemMoveIn`
    - `SystemPush`
    - `SystemReveal`
    - `SystemRotate` to support:
         - `SystemRotate(90)`
         - `SystemRotate(90ccw)`
         - `SystemRotate(180)`
         - `SystemRotate(180ccw)`
         - => Note: It seems that only `SystemRotate(90)` is working as expected. `CATransition` issues?
    - `SystemCameraIrisAnimator` to support:
         - `SystemCameraIris`
         - `SystemCameraIris(HollowOpen)`
         - `SystemCameraIris(HollowClose)`
- Use framework in demo app [#149](https://github.com/JakeLin/IBAnimatable/pull/149)

#### Bugfixes

- Fix the sided borders issue [#150](https://github.com/JakeLin/IBAnimatable/pull/150)
- Fix the `FromTop` and `FromBottom` directions in system built-in animations [#156](https://github.com/JakeLin/IBAnimatable/pull/156)
 
### [2.1](https://github.com/JakeLin/IBAnimatable/releases/tag/2.1)

#### API breaking changes

- Remove `MaskDesignable` public methods ([#101](https://github.com/JakeLin/IBAnimatable/issues/101)): 
   	- Remove `maskCircle()`, use `view.maskType = String(MaskType.Circle)` instead
   	- Remove `maskStar(_:)`, use `view.maskType = "Star(6)"` instead
   	- Remove `maskPolygon()`, use `view.maskType = String(MaskType.Polygon)` instead
   	- Remove `maskTriangle()`, use `view.maskType = String(MaskType.Triangle)` instead
   	- Remove `maskWave(_:_:_:)`, use `view.maskType = "Wave(up, 16, 40)"` instead
- Improve the options in `TransitionAnimationType` enum. ([#137](https://github.com/JakeLin/IBAnimatable/pull/137))
   	- Remove `SystemCubeFromLeft`, use `SystemCube(Left)` 
   	- Remove `SystemCubeFromRight`, use `SystemCube(Right)` 
   	- Remove `SystemCubeFromTop`, use `SystemCube(Top)` 
   	- Remove `SystemCubeFromBottom`, use `SystemCube(Bottom)` 
   	- Remove `SystemFlipFromLeft`, use `SystemFlip(Left)` 
   	- Remove `SystemFlipFromRight`, use `SystemFlip(Right)` 
   	- Remove `SystemFlipFromTop`, use `SystemFlip(Top)` 
   	- Remove `SystemFlipFromBottom`, use `SystemFlip(Bottom)` 

#### Enhancements

- Support Xcode 7.3 and Swift 2.2
- Configurable mask polygon (sides) [#112](https://github.com/JakeLin/IBAnimatable/issues/112)
- Add `SystemPageCurlAnimator` to support `SystemPageCurlFromTop` and `SystemPageCurlFromBottom` transition animations [#126](https://github.com/JakeLin/IBAnimatable/issues/126)
- `AnimatableLabel` now conforms `CornerDesignable` and `FillDesignable`
- Support Carthage 0.15.2 [#131](https://github.com/JakeLin/IBAnimatable/issues/131)

#### Bugfixes

- Fixed a bug that was making `GradientDesignable` not filling the dedicated frame [#129](https://github.com/JakeLin/IBAnimatable/issues/129)
- Fixed a bug that was making `MaskDesignable` not filling the dedicated frame

### [2.0](https://github.com/JakeLin/IBAnimatable/releases/tag/2.0)

#### API breaking changes

- Remove `DesignableViewController`, use `AnimatableViewController` instead.

#### Enhancements

- New IBAnimatable icon 🎊
- Add `AnimatableNavigationController` to support custom Push and Pop transition animations
- Add `AnimatableViewController` to support custom Present and Dismiss transition animations
- Add `SystemCubeAnimator` to support `SystemCubeFromLeft`, `SystemCubeFromRight`, `SystemCubeFromTop` and `SystemCubeFromBottom` transition animations
- Add `SystemFlipAnimator` to support `SystemFlipFromLeft`, `SystemFlipFromRight`, `SystemFlipFromTop` and `SystemFlipFromBottom` transition animations
- Add `FadeAnimator` to support `Fade`, `FadeIn` and `FadeOut` transition animations
- Add `CALayerExtension` to simplify CALayer animations with completion closure.
- Add `Navigator` to manage Push and Pop transition animations
- Add `Presenter` to manage Present and Dismiss transition animations
- Add `PresentFadeSegue`, `PresentFadeInSegue` and `PresentFadeOutSegue` for Present transition with Fade animations
- Add `PresentFadeWithDismissInteractionSegue`, `PresentFadeInWithDismissInteractionSegue` and `PresentFadeOutWithDismissInteractionSegue` for Present transition with Fade animations and getsture interactions.
- Add `PanInteractiveAnimator` to handle Pan interaction for Dismiss and Pop
- Demo App can experiment all transition animations (tap on "Forget Password" button to see) 

#### Bugfixes

- Fix potential crash when using `GradientDesignable`
- Fix slideIn/Out animations on second screens (e.g. AirPlay)

### [1.2](https://github.com/JakeLin/IBAnimatable/releases/tag/1.2)

#### Enhancements

- Swift Package Manager support. [#5](https://github.com/JakeLin/IBAnimatable/issues/5)
- Predefined flat colors. [#71](https://github.com/JakeLin/IBAnimatable/issues/71)
- Customise mask draw from interface builder [#50](https://github.com/JakeLin/IBAnimatable/issues/50) [#8](https://github.com/JakeLin/IBAnimatable/issues/8) [#76](https://github.com/JakeLin/IBAnimatable/issues/76):
  - Star(6) -> draw star mask with 6 sides.
  - Wave(up,50,100) -> draw a wave up mask with 50 as width, and 100 as offset.
- Makes `BorderDesignable` usable in playground
- Add MoveTo and MoveBy animations [#74](https://github.com/JakeLin/IBAnimatable/issues/74)

#### Bugfixes

- Fixed `GradientDesignable` rotation. [#86](https://github.com/JakeLin/IBAnimatable/issues/86)
- Fixed `BorderDesignable` after rotation.
- Fixed mask star drawing bug. [#95](https://github.com/JakeLin/IBAnimatable/issues/95)
- Fixed the border color / width when used with a mask. [#95](https://github.com/JakeLin/IBAnimatable/issues/101)

### [1.1](https://github.com/JakeLin/IBAnimatable/releases/tag/1.1)

#### API breaking changes

- Remove `DesignableGradientView`, use `AnimatableView` to configure gradient. [#81](https://github.com/JakeLin/IBAnimatable/issues/81) and [#86](https://github.com/JakeLin/IBAnimatable/issues/86)

#### Enhancements

- New animations: Rotate, RotateCCW [#51](https://github.com/JakeLin/IBAnimatable/issues/51)
- New masks: Star, Triangle, Polygon, Wave
- SidebarImage now support right images 
- Predefined gradients [#24](https://github.com/JakeLin/IBAnimatable/issues/24)
- iOS8 support [#89](https://github.com/JakeLin/IBAnimatable/issues/89)

#### Bugfixes

- Fixed left gradient
- Fixed slideOut / slideIn animations [#46](https://github.com/JakeLin/IBAnimatable/issues/46)

### [1.0.1](https://github.com/JakeLin/IBAnimatable/releases/tag/1.0.1)

#### Enhancements

- Carthage support - [#6](https://github.com/JakeLin/IBAnimatable/issues/6)

### [1.0](https://github.com/JakeLin/IBAnimatable/releases/tag/1.0)

- Initial release
