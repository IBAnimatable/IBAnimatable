# IBAnimatable - Vision, Technical Considerations and Roadmap

## Vision
IBAnimatable is an Open Source library to help designers and developers design and prototype UI, interaction, navigation, transition and animation for App Store ready Apps in Interface Builder.

## Approaches
* Adding convience `@IBInspectable` properties to reduce numerous amount of manual code. e.g. e.g. `fillColor`, `cornerRadius`, `shadowColor` and `shadowOffset`.
* Providing predefined UI elements and animations. e.g. Flat UI colors, Gradient colors and pop animation.
* Extending existing behaviours, e.g. More transition animations than "Cover Vertical", "Flip Horizontal" and "Cross Dissolve".


## Technical Considerations
* **UIKit** - All `IBAnimatable` UI elements are based on UIkit.
 	* **Dos**
		* All UI elements should support Auto Layout.
	* **Don'ts**
		* Creating another layout system. e.g. flexbox.
		* Creating custom navigation pattern. 
	
* **`@IBDesginable` and `@IBInspectable`** - To design in Interface Builder, all properties should be `@IBDesginable`. Some properties can not render properly in Interface Builder, e.g. `rotate`. And animations are not able to previewed in Interface Builder. But once Interface Builder supports, those features will work properly in Interface Builder.

* **Platform - iOS** - 

	
* **iOS version** - Currently, `IBAnimatable` supports iOS 8 and above. 
    * **Dos**
		* Supporting latest version first and disabling them in previous version if required.
	* **Don'ts**
		* Sacrificing features for backfowrd compitibilities

* **Swift** - Currently, `IBAnimatable` supports Swift only. When implementing new features, we consider to use Swift features and best practice like protocol extensions and optional. Would not avoid to use 


## Roadmap
### Designable elememts
* Designable `UIAlert​Controller`, Standard Alert and Action Sheet. 

### Animatable elememts

### Interaction elements

### Navigation and Transitioning animators

