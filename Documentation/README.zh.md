# IBAnimatable
`IBAnimatable`是一个帮助我们在Interface Builder和Swift playground里面设计UI, 交互, 导航模式, 换场和动画的开源库。

![](https://github.com/JakeLin/IBAnimatable/blob/master/Screenshots/IBAnimatable.gif)

**整个App都是通过`IBAnimatable`在Interface Builder设计完成，没有任何一行代码**。由于Gif文件大小的限制，这只演示了部分功能，完整功能可以在[YouTube](https://www.youtube.com/watch?v=dvD8X6J1YLM)或者[MP4 on Github]()上看到。

![](https://github.com/JakeLin/IBAnimatable/blob/master/Screenshots/Storyboard.png)

这是整个App都是在Interface Builder的Storyboard中的设计。

2015年Designer News热门文章中，前20篇里面有一半左右的文章是讨论如何快速制作可交换的原型，例如Adobe公司在开发Project Comet原型工具来补救日益被Sketch迅速占领的市场。这些工具都有一个特点：“快”。“快”成为移动开发领域为不可破的法宝，因为无论那个App都需要在不断的迭代中逐步完善和发展。但是目前这些工具都没法提供一个端到端的解决方案，很多工具生成的原型没办法直接使用在最终的App中，或者需要在Xcode和Interface Builder里重做原型中的设计，交换以及动画。这是一个很大的痛点，`IBAnimatable`的诞生是为了解决这个痛点。`IBAnimatable`提供从想法到最终App产品的设计工具，帮助我们在Interface Builder和Swift playground里面设计UI, 交互, 导航模式, 换场和动画。   

## 主要功能
* 一个工具覆盖原型到可提交到App Store的App - 支持所见即所得的设计功能。
* 对设计师友好 - 在Interface Builder的Attributes Inspector里提供类似Sketch配置功能。   
* 在Swift playground上设计动画 - 提供类似Framer Studio的左边编写代码，右边预览动画的功能。 
* 内置Auto Layout支持 - 使用Auto Layout和Size Classes支持翻屏和多设备。 
* 导航和换场动画支持 - 可以使用内置的导航模式，`IBAnimatable`同时提供Unwind Segue来返回前一个页面，可以省去编写代码的步骤。
* Protocol oriented编程模式 - `IBAnimatable`使用了protocol oriented编程模式，是的项目非常容易扩张，并且可以方便的制作出自己的自定义控件。  

## 使用场景
* 制作原型 － 使用`IBAnimatable`快速地执行可交互的原型。
* 在Interface Builder里面快速实现 － 把Sketch的UI或者Framer Studio的原型在Interface Builder快速实现，不需要编写任何代码。
* 制作客户化控件 － 使用`IBAnimatable`的extension制作另外的控件库，例如Material控件等。


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

使用`IBAnimatable`在Interface Builder里设计UI和动，只需要下面简单的几步：

1. 打开storyboard或者Xib。
2. 把UIview或其他UI控件拖放到ViewController里面。
3. 在Identity Inspector里把相应的UI控件关联到`Animatable`的UI控件类，`Animatable`的文档可以在 [APIs section](https://github.com/JakeLin/IBAnimatable#apis) 找到。
4. 在Attribute Inspector里配置UI和动画。


## 如何在Swift playground里设计动画
![](https://github.com/JakeLin/IBAnimatable/blob/master/Screenshots/AnimateInSwiftPlayground.gif)

尽管我们可以在Attribute Inspector里配置动画，但是Interface Builder还不支持预览动画。但幸运的是我们可以在Swift playgournd里设计和预览动画。你可以在[IBAnimatable.playground](https://github.com/JakeLin/IBAnimatable/tree/master/IBAnimatable.playground)看到如何设计和预览动画。首先选择一个playground的页，然后点击"Assistant editor"按钮来呈现右边的预览页。接着选择右上角的"Timeline"来预览动画。我们可以使用Xcode的"Editor" -> "Execute"菜单来重新执行Playground的动画。


## 手工运行动画
在上面我们已经看到，我们可以不需要任何代码就能在Interface Builder进行设计，但是`IBAnimatable`还提供编程接口来让我们完全控制UI和动画。`IBAnimatable`提供了例如`pop()`那样简单的API，我们只需要一行代码就能执行动画。

```
view.pop() // pop animation for the view
view.squeezeFadeInLeft() // squeeze and fade in from left animation
```  

在[Swift playgournd Page - Predefined Animations](https://github.com/JakeLin/IBAnimatable/tree/master/IBAnimatable.playground/Pages/Predefined%20Animations.xcplaygroundpage)里面我们可以尝试不同的动画。

### 动画的属性
我们可以通过修改动画的属性来进一步个性化我们的动画。我们只需要修改这项属性，然后调用`animate()`方法来运行动画。

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

我们可以在[Swift playgournd Page - Animation Properties](https://github.com/JakeLin/IBAnimatable/tree/master/IBAnimatable.playground/Pages/Animation%20Properties.xcplaygroundpage)里面尝试不同的动画属性。

### 串联动画
有时候我们需要把多个动画串联起来执行，`IBAnimatble`提供非常简易的方式来把动画串联起来。

```
// 只要把下一个动画放在 `{}` closure就可以了，下面的例子是当执行完从上而下的滑动后Pop的动画。
view.squeezeInDown{ view.pop() }

// 这是"Animate in Swift playground"Gif动画的源代码，把好几个动画串联起来执行。
view.squeezeInDown{ view.pop { view.shake{ view.squeeze{ view.wobble{ view.flipX { view.flash{ view.flipY { view.fadeOutDown() } } } } } } } }
```

## 怎样安装
### 手工安装
把`IBAnimatable`文件夹拷贝到你的Xcode项目中

### Git submodule
在开发中，请看[Issue #22 - Swift package manager support](https://github.com/JakeLin/IBAnimatable/issues/22)

### Swift package manager
在开发中，请看[Issue #5 - Swift package manager support](https://github.com/JakeLin/IBAnimatable/issues/5)

### CocoaPods
在开发中，请看[Issue #7 - CocoaPods support](https://github.com/JakeLin/IBAnimatable/issues/7)

### Carthage 
在开发中，请看[Issue #6 - Carthage support ](https://github.com/JakeLin/IBAnimatable/issues/6)

## APIs
完整的API文档请参考[IBAnimatable APIs](https://github.com/JakeLin/IBAnimatable#apis)

## 怎样贡献
我们每个人都可以为这个项目进行贡献。高效的工具使得我们有更多的时间来开发高质量的App，当然也有更多的时间享受生活🍻。

* 如果是你一名设计师，你可以使用`IBAnimatable`在Interface Builder里进行设计，甚至不需要任何像Sketch这样设计工具，或者把现有的Sketch或Photoshop在Interface Builder快速实现。有了`IBAnimatable`，绝大部分的功能都可以Interface Builder里面完成。如果你需要新功能，请[提交一个GitHub Issue](https://github.com/JakeLin/IBAnimatable/issues/new)。如果你使用`IBAnimatable`进行设计，请通过Pull Request或者GitHub Issue来通知我们，我们可以把它放在Readme文件里面。

* 如果你是一名开发者，你可以实现功能或者修改Bug，Backlog可以在[GitHub Issues](https://github.com/JakeLin/IBAnimatable/issues)找到。如果你在你的App里面使用了`IBAnimatable`，请通过Pull Request或者GitHub Issue来通知我们，我们可以把它放在Readme文件里面。

* 如果你英语不错，来改一下我的英语吧😁。如果你还会其他语言，创建或者修改其他语言的Readme文件吧。

* 如果你喜欢这个项目，请告诉其他设计师和开发者，记住Star🌟这个项目哦。 🤗


## Inspirations
请查看[IBAnimatable Inspirations](https://github.com/JakeLin/IBAnimatable#inspirations)

## License
`IBAnimatable` is released under the MIT license. See [LICENSE](https://github.com/JakeLin/IBAnimatable/blob/master/LICENSE) for details.

