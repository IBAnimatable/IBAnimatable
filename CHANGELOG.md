# Change Log
All notable changes to this project will be documented in this file.
`IBAnimatable` adheres to [Semantic Versioning](http://semver.org/).

## Versions

### Next

#### API breaking changes
TBD

#### Enhancements

-  Swift Package Manager support. [#5](https://github.com/JakeLin/IBAnimatable/issues/5)
- Predefined flat colors. [#71](https://github.com/JakeLin/IBAnimatable/issues/71)
- Customise mask draw from interface builder [#50](https://github.com/JakeLin/IBAnimatable/issues/50) [#8](https://github.com/JakeLin/IBAnimatable/issues/8) [#76](https://github.com/JakeLin/IBAnimatable/issues/76):
  - Star(6) -> draw star mask with 6 sides.
  - Wave(up,50,100) -> draw a wave up mask with 50 as width, and 100 as offset.
- `BorderDesignable` can be used directly in playground

#### Bugfixes

- Fixed `GradientDesignable` rotation. [#86](https://github.com/JakeLin/IBAnimatable/issues/86)
- Fixed `BorderDesignable` after rotation.
- Fixed mask star drawing bug. [#95](https://github.com/JakeLin/IBAnimatable/issues/95)
- Fixed the border color / width when using with a mask. [#95](https://github.com/JakeLin/IBAnimatable/issues/101)

### [1.1](https://github.com/JakeLin/IBAnimatable/releases/tag/V1.1)

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

### [1.0.1](https://github.com/JakeLin/IBAnimatable/releases/tag/V1.0.1)

#### Enhancements

- Carthage support - [#6](https://github.com/JakeLin/IBAnimatable/issues/6)

### [1.0](https://github.com/JakeLin/IBAnimatable/releases/tag/V1.0)

- Initial release
