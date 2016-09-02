# Activity indicator animations

`IBAnimatable` provides a broad set of nice loading animations. We can use them in Interface Builder as well as in code by using `AnimatableActivityIndicatorView`.

You can see an example of each animation in the demo app. Launch the app, then tap on "Playground" button, and tap on "Activity Indicator" cell. Choose your animation, and see the result.

### Properties

| Property name | Data type | Description |
| ------------- |:-------------:| ----- |
| animationType | String | Supported activity indicator animations. Take a look at the [supported animations](#supported-animations)  |
| color | UIColor | Color of the activity indicator. Default is black. |
| hidesWhenStopped | Bool | Controls whether the receiver is hidden when the animation is stopped. Default is true |
| isAnimating | Bool | Wether the activityIndicator is animating or not |

### Methods available

| Method name | Description |
| ------------- | ----- |
| startAnimating() | Start the animation |
| stopAnimating() | Stop the animation. The activityIndicator will be hidden if `hidesWhenStopped` value is `true`. |


###Supported animation:

1. [AudioEqualizer](#audioequalizer)
2. [BallBeat](#ballbeat)
3. [BallClipRotate](#ballcliprotate)
4. [BallClipRotateMultiple](#ballcliprotatemultiple)
5. [BallClipRotatePulse](#ballcliprotatepulse)
6. [BallGridBeat](#ballgridbeat)
7. [BallGridPulse](#ballgridpulse)
8. [BallPulse](#ballpulse)
9. [BallPulseRise](#ballpulserise)
10. [BallPulseSync](#ballpulsesync)
11. [BallRotate](#ballrotate)
12. [BallRotateChase](#ballrotatechase)
13. [BallScale](#ballscale)
14. [BallScaleMultiple](#ballscalemultiple)
15. [BallScaleRipple](#ballscaleripple)
16. [BallScaleRippleMultiple](#ballscaleripple)
17. [BallSpinFadeLoader](#ballspinfadeloader)
18. [BallTrianglePath](#balltrianglepath)
19. [BallZigZag](#ballzigzag)
20. [BallZigZagDeflect](#ballzigzagDeflect)
21. [CubeTransition](#cubetransition)
22. [LineScale](#linescale)
23. [LineScaleParty](#linescaleparty)
24. [LineScalePulseOut](#linescalepulseout)
25. [LineScalePulseOutRapid](#linescalepulseoutrapid)
26. [LineSpinFadeLoader](#linespinfadeloader)
27. [Orbit](#orbit)
28. [Pacman](#pacman)
29. [SemiCircleSpin](#semicirclespin)
30. [SquareSpin](#squarespin)
31. [TriangleSkewSpin](#triangleskewspin)

### AudioEqualizer

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorAudioEqualizer.gif)

### BallBeat

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallBeat.gif)

### BallClipRotate

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallClipRotate.gif)

### BallClipRotateMultiple

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallClipRotateMultiple.gif)

### BallClipRotatePulse

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallClipRotatePulse.gif)

### BallGridBeat

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallGridBeat.gif)

### BallGridPulse

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallGridPulse.gif)

### BallPulse

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallPulse.gif)

### BallPulseRise

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallPulseRise.gif)

### BallPulseSync

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallPulseSync.gif)

### BallRotate

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallRotate.gif)

### BallRotateChase

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallRotateChase.gif)

### BallScale

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallScale.gif)

### BallScaleMultiple

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallScaleMultiple.gif)

### BallScaleRipple

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallScaleRipple.gif)

### BallScaleRippleMultiple

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallScaleRippleMultiple.gif)

### BallSpinFadeLoader

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallSpinFadeLoader.gif)

### BallTrianglePath

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallTrianglePath.gif)

### BallZigZag

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallZigZag.gif)

### BallZigZagDeflect

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorBallZigZagDeflect.gif)

### CubeTransition

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorCubeTransition.gif)

### LineScale

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorLineScale.gif)

### LineScaleParty

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorLineScaleParty.gif)

### LineScalePulseOut

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorLineScalePulseOut.gif)

### LineScalePulseOutRapid

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorLineScalePulseOutRapid.gif)

### LineSpinFadeLoader

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorLineSpinFadeLoader.gif)

### Orbit

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorOrbit.gif)

### Pacman

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorPacman.gif)

### SemiCircleSpin

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorSemiCircleSpin.gif)

### SquareSpin

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivitySquareSpin.gif)

### TriangleSkewSpin

![ActivityIndicator - LineScalePulseOut](https://raw.githubusercontent.com/IBAnimatable/IBAnimatable-Misc/master/IBAnimatable/ActivityIndicatorTriangleSkewSpin.gif)