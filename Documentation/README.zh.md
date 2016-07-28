![IBAnimatable](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/Hero.png)
`IBAnimatable` 是一个帮助我们在 Interface Builder 和 Swift Playground 里面设计 UI, 交互, 导航模式, 换场和动画的开源库。

![IBAnimatable hero image](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/IBAnimatable.gif)

**整个 App 都是通过 `IBAnimatable` 在 Interface Builder 设计完成，没有任何一行代码**。由于 [Dribbble GIF 文件](https://dribbble.com/shots/2453933-IBAnimatable-Design-App-Store-ready-Apps-in-Interface-Builder)大小的限制，这只演示了部分功能，完整功能可以在 [YouTube](https://www.youtube.com/watch?v=dvD8X6J1YLM) 或者 [MP4 on Github](https://github.com/IBAnimatable/IBAnimatable-Misc/blob/master/Videos/IBAnimatable.mp4?raw=true) 上看到。

![StoryboardPreview](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/Storyboard.jpg)

上面是该 App 在 Interface Builder 的 Storyboard 中的设计。

2015 年 Designer News 热门文章中，前 20 篇里面有一半左右的文章是讨论如何快速制作可交换的原型，例如 Adobe 公司在开发 Project Comet 原型工具来补救日益被 Sketch 迅速占领的市场。这些工具都有一个特点：“快”。“快”成为移动开发领域唯不可破的法宝，因为无论那个 App 都需要在不断的迭代中逐步完善和发展。但是目前这些工具都没法提供一个端到端的解决方案，很多工具生成的原型没办法直接使用在最终的 App 中，或者需要在 Xcode 和 Interface Builder 里重做原型中的设计，交换以及动画。这是一个很大的痛点，`IBAnimatable` 的诞生是为了解决这个痛点。`IBAnimatable` 提供从想法到最终 App 产品的设计工具，帮助我们在 Interface Builder 和 Swift Playground 里面设计 UI, 交互, 导航模式, 换场和动画。

## 主要功能
* 一个工具覆盖原型到可提交到 App Store 的 App - 支持所见即所得的设计功能。
* 对设计师友好 - 在 Interface Builder 的 Attributes Inspector 里提供类似 Sketch 配置功能。
* 在 Swift Playground 上设计动画 - 提供类似 Framer Studio 的左边编写代码，右边预览动画的功能。
* 内置 Auto Layout 支持 - 使用 Auto Layout 和 Size Classes 支持翻屏和多设备。
* 导航和换场动画支持 - 可以使用内置的导航模式，`IBAnimatable` 同时提供 Unwind Segue 来返回前一个页面，可以省去编写代码的步骤。
* Protocol-Oriented 编程模式 - `IBAnimatable` 使用了 protocol-oriented 编程模式，使得项目非常容易扩张，并且可以方便的制作出自己的自定义控件。

## 使用场景
* 制作原型 － 使用 `IBAnimatable` 快速地执行可交互的原型。
* 在 Interface Builder 里面快速实现 － 把 Sketch 的 UI 或者 Framer Studio 的原型在 Interface Builder 快速实现，不需要编写任何代码。
* 制作自定义控件 － 使用 `IBAnimatable` 的 extension 制作另外的控件库，例如 Material 控件等。


## 怎样运行例子App
要了解和学习 `IBAnimatable`，我们可运行示例 App，并在 Interface Builder 中修改相关的配置来查看设计的结果。

1) 克隆代码库

```bash
$ git clone https://github.com/IBAnimatable/IBAnimatable.git
```

2) 在 Xcode 打开 .xcworkspace 文件

```bash
$ cd IBAnimatable
$ open IBAnimatableApp.xcodeproj
```

3) 编译并运行

## 如何在 Interface Builder 中设计 UI 和动画
![](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/DesignInInterfaceBuilder.png)

使用 `IBAnimatable` 在 Interface Builder 里设计 UI 和动画，只需要下面简单的几步：

1. 打开 storyboard 或者 Xib。
2. 把 UIView 或其他 UI 控件拖放到 ViewController 里面。
3. 在 Identity Inspector 里把相应的 UI 控件关联到 `Animatable` 的 UI 控件类，`Animatable` 的文档可以在 [APIs.md](APIs.md) 找到。
4. 在 Attribute Inspector 里配置UI和动画。


## 如何在 Swift Playground 里设计动画
![](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/AnimateInSwiftPlayground.gif)

尽管我们可以在 Attribute Inspector 里配置动画，但是 Interface Builder 还不支持预览动画。但幸运的是我们可以在 Swift Playground 里设计和预览动画。你可以在 [IBAnimatable.playground](../IBAnimatable.playground) 看到如何设计和预览动画。首先选择一个Playground 的页，然后点击 "Assistant editor" 按钮来呈现右边的预览页。接着选择右上角的 "Timeline" 来预览动画。我们可以使用 Xcode 的 "Editor" -> "Execute" 菜单来重新执行 Playground 的动画。


## 手工运行动画
在上面我们已经看到，我们可以不需要任何代码就能在 Interface Builder 进行设计，但是 `IBAnimatable` 还提供编程接口来让我们完全控制UI和动画。`IBAnimatable` 提供了例如 `pop()` 那样简单的 API，我们只需要一行代码就能执行动画。

```
view.pop() // pop animation for the view
view.squeezeFadeInLeft() // squeeze and fade in from left animation
```

在 [Swift Playground Page - Predefined Animations](../IBAnimatable.playground/Pages/Predefined%20Animations.xcplaygroundpage) 里面我们可以尝试不同的动画。

### 动画的属性
我们可以通过修改动画的属性来进一步个性化我们的动画。我们只需要修改这项属性，然后调用 `animate()` 方法来运行动画。

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

我们可以在 [Swift Playgrourd Page - Animation Properties](../IBAnimatable.playground/Pages/Animation%20Properties.xcplaygroundpage) 里面尝试不同的动画属性。

### 串联动画
有时候我们需要把多个动画串联起来执行，`IBAnimatable` 提供非常简易的方式来把动画串联起来。

```
// 只要把下一个动画放在 `{}` closure 就可以了，下面的例子是当执行完从上而下的滑动后 Pop 的动画。
view.squeezeInDown{ view.pop() }

// 这是 "Animate in Swift Playground" Gif 动画的源代码，把好几个动画串联起来执行。
view.squeezeInDown{ view.pop { view.shake{ view.squeeze{ view.wobble{ view.flipX { view.flash{ view.flipY { view.fadeOutDown() } } } } } } } }
```

## 怎样安装
### 手工安装
把 `IBAnimatable` 文件夹拷贝到你的 Xcode 项目中

### Swift package manager
在 `Package.swift` 中添加 `.Package(url: "https://github.com/IBAnimatable/IBanimatable.git", majorVersion: 1)` 。

### CocoaPods

在 `Podfile` 中添加 `pod 'IBAnimatable'` 。

### Carthage

在 `Cartfile` 中添加 `github "IBAnimatable/IBAnimatable" ~> 2` 。

### Git submodule
你一定很熟悉 Git，应该不用我多说了，把这个 Repo 作为一个 submodule ，并把项目文件加到你的 workspace 里面，然后把 `IBAnimatable.framework` 放到你的应用程序的 Target 里面。

## 文档
完整的文档请参考 [IBAnimatable APIs](APIs.md)。

## 怎样贡献
我们每个人都可以为这个项目进行贡献。高效的工具使得我们有更多的时间来开发高质量的App，当然也有更多的时间享受生活🍻。

* 如果你是一名设计师，你可以使用 `IBAnimatable` 在 Interface Builder 里进行设计，甚至不需要任何像 Sketch 这样设计工具，或者把现有的 Sketch 或 Photoshop 在 Interface Builder 快速实现。有了 `IBAnimatable`，绝大部分的功能都可以 Interface Builder 里面完成。如果你需要新功能，请[提交一个 GitHub Issue](https://github.com/IBAnimatable/IBAnimatable/issues/new)。如果你使用 `IBAnimatable` 进行设计，请通过 Pull Request 或者 GitHub Issue 来通知我们，我们可以把它放在 Readme 文件里面。

* 如果你是一名开发者，你可以实现功能或者修改 Bug，Backlog 可以在[GitHub Issues](https://github.com/IBAnimatable/IBAnimatable/issues) 找到。如果你在你的 App 里面使用了 `IBAnimatable`，请通过 Pull Request 或者 GitHub Issue 来通知我们，我们可以把它放在 Readmd 文件里面。

* 如果你英语不错，来改一下我的英语吧😁。如果你还会其他语言，创建或者修改其他语言的 Readme 文件吧。

* 如果你喜欢这个项目，请告诉其他设计师和开发者，记住 Star🌟 这个项目哦。 🤗


## Inspirations & Credits
请查看 [IBAnimatable Inspirations](../README.md#inspirations--credits)

## License
`IBAnimatable` is released under the MIT license. See [LICENSE](../LICENSE) for details.

