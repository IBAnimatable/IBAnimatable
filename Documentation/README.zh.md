# IBAnimatable
`IBAnimatable`是一个帮助我们在Interface Builder和Swift playground里面设计UI, 交互, 导航模式, 换场和动画的开源库。

2015年Designer News热卖文章中，前20篇里面有一半左右的文章是讨论如何快速制作可交换的原型，例如Adobe公司在开发Project Comet原型工具来补救日益被Sketch迅速占领的市场。这些工具都有一个特点：“快”。“快”成为移动开发领域为不可破的法宝，因为无论那个App都需要在不断的迭代中逐步完善和发展。但是目前这些工具都没法提供一个端到端的解决方案，很多工具生成的原型没办法直接使用在最终的App中，或者需要在Xcode和Interface Builder里重做原型中的设计，交换以及动画。这是一个很大的痛点，`IBAnimatable`的诞生是为了解决这个痛点。`IBAnimatable`提供从想法到最终App产品的设计工具，帮助我们在Interface Builder和Swift playground里面设计UI, 交互, 导航模式, 换场和动画。   

## 功能
* 一个工具覆盖原型到可提交到App Store的App - 支持所见即所得的设计功能。
* 对设计师友好 - 在Interface Builder的Attributes Inspector里提供类似Sketch配置功能。   
* 在Swift playground上设计动画 - 提供类似Framer Studio的左边编写代码，右边预览动画的功能。 
* 内置Auto Layout支持 - 使用Auto Layout和Size Classes支持翻屏和多设备。 
* 导航和换场动画支持 - 可以使用内置的导航模式，`IBAnimatable`同时提供Unwind Segue来返回前一个页面，可以省去编写代码的步骤。
* Protocol oriented编程模式 - `IBAnimatable`使用了protocol oriented编程模式，是的项目非常容易扩张，并且可以方便的制作出自己的自定义控件。  

## 怎样运行例子App
要了解和学习`IBAnimatable`，我们可运行例子App，并在Interface Builder中修改相关的配置来查看设计的结果。 

1) 克隆代码库

```
$ git clone https://github.com/JakeLin/IBAnimatable.git
```

2) 在Xcode打开xcworkspace文件

```
$ cd IBAnimatable
$ open "IBAnimatable.xcworkspace"
```

3) 编译并运行

## 如何在Interface Builder中设计UI和动画
![](https://raw.githubusercontent.com/JakeLin/IBAnimatable/master/Screenshots/DesignInInterfaceBuilder.png)

To use `IBAnimatable` to design the UI and animations in Interface Builder, just follow few steps as below:

1. Open a storyboard or Xib file.
2. Drag and drop a view or controller to a ViewController.
3. In Identity Inspector, connect the view or controller to `Animatable` classes, you can find all `Animatable` classes in APIs section.
4. Configure the UI and animations in Attribute Inspector.


## 如何在Swift playground里设计动画
![](https://github.com/JakeLin/IBAnimatable/blob/master/Screenshots/AnimateInSwiftPlayground.gif)

尽管我们可以在Attribute Inspector里配置动画，但是Interface Builder还不支持预览动画。但幸运的是我们可以在Swift playgournd里设计和预览动画。你可以在[IBAnimatable.playground](https://github.com/JakeLin/IBAnimatable/tree/master/IBAnimatable.playground)看到如何设计和预览动画。

## How to animate programmatically
As you saw above, we can prototype an App fully in Interface Builder withouth single line of code, but `IBAnimatable` also provides APIs to let us fully control the UI and animations. `IBAnimatable` provides simple APIs like `pop()`. We can simplly call them in one line.

```
view.pop() // pop animation for the view
view.squeezeFadeInLeft() // squeeze and fade in from left animation
```  

You can play around all these animations in [Swift playgournd Page - Predefined Animations](https://github.com/JakeLin/IBAnimatable/tree/master/IBAnimatable.playground/Pages/Predefined%20Animations.xcplaygroundpage)

### Animation properties
There are some properties we can change to customise the animation. What we need to do is to set the properties and call `animate()` method to start the animation.

```
// Setup the animation
view.animationType = "SqueezeInLeft"
view.delay = 0.5
view.damping = 0.5
view.velocity = 2
view.force = 1

// Start the animation
view.animate()
```

You can play around all animations with properties in [Swift playgournd Page - Animation Properties](https://github.com/JakeLin/IBAnimatable/tree/master/IBAnimatable.playground/Pages/Animation%20Properties.xcplaygroundpage)

### Chaining animations
Sometimes, we need to run one animation after another one. With `IBAnimatble`, we can easily chain animations together to provide sleek user experience.

```
// Simplly put the next animation in `{}` closure like below. It is an example to pop the view after squeeze in from the top.
view.squeezeInDown{ view.pop() }

// Heaps of animations have been chained togehter, it is source code of gif in "Animate in Swift playground" section
view.squeezeInDown{ view.pop { view.shake{ view.squeeze{ view.wobble{ view.flipX { view.flash{ view.flipY { view.fadeOutDown() } } } } } } } }
```

## How to install
### Manually install
Copy and paste `IBAnimatable` folder in your Xcode project.

### Git submodule
TBD [Issue #22 - Swift package manager support](https://github.com/JakeLin/IBAnimatable/issues/22)

### Swift package manager
TBD [Issue #5 - Swift package manager support](https://github.com/JakeLin/IBAnimatable/issues/5)

### CocoaPods
TBD [Issue #7 - CocoaPods support](https://github.com/JakeLin/IBAnimatable/issues/7)

### Carthage 
TBD [Issue #6 - Carthage support ](https://github.com/JakeLin/IBAnimatable/issues/6)


## APIs
参考[IBAnimatable APIs](https://github.com/JakeLin/IBAnimatable#apis)

## How to contribute
All of us can contribute to this project. Fewer overheads mean less time to build quality Apps and more time to enjoy coffee ☕️.

If you are a design, you can design in Interface Builder with `IBAnimatable` or redo your existing design from Sketch or Photoshop. You should be able to do <del>all</del> most of design work in Interface Builder. If you have any feature request, please [create a GitHub Issue](https://github.com/JakeLin/IBAnimatable/issues/new) and we will put it in the backlog. If you have done any design with `IBAnimatable`, please let us know via creating Pull Request or GitHub Issue. We will add it to Readme file.

If you are a developer, you can work on features or fix bugs, please check out [GitHub Issues](https://github.com/JakeLin/IBAnimatable/issues) to find out the backlog. If you have used `IBAnimatable` in you App, please let us know via creating Pull Request or GitHub Issue. We will add it to Readme file.

If you are good at English, please correct my English 😁. If you are good at other languages, please create a Readme file in those languages.

If you like the project, please share it with the other designers and developers, and star 🌟 the project. 🤗


## Inspirations
* `IBDesignable` and `IBInspectable` - The entire project is based on that.
* Sketch -  Interface Builder should be as easy as Sketch to use
* Framer
* [Spring by Meng To](https://github.com/MengTo/Spring) - steal a lot of animation parameters from this project.
* [Invision ToDo App UI Kit](http://www.invisionapp.com/do), The demo App's original design is from this UI Kit and redone in Interface Builder. We also added interaction, navigation and animations.

## License
`IBAnimatable` is released under the MIT license. See [LICENSE](https://github.com/JakeLin/IBAnimatable/blob/master/LICENSE) for details.

