# slinky_view
![Pub Version](https://img.shields.io/pub/v/slinky_view)
[![Test](https://github.com/idonuntius/slinky_view/actions/workflows/test.yml/badge.svg)](https://github.com/idonuntius/slinky_view/actions/workflows/test.yml)

A sheet that aligns to the bottom of a widget and expands as scroll up.

<img src="https://user-images.githubusercontent.com/10494192/201906827-a0eab41c-59c3-48de-8398-08d44d32d68c.gif" width="240">

## Getting started
Add dependency.

```yaml
dependencies:
  slinky_view: ^1.0.0
```

## Usage
### Super simple to use

```dart
import 'package:slinky_view/slinky_view.dart';

SlinkyView(
  controller: SlinkyController(),
  panelParameter: SlinkyPanelParameter(
    contents: [
      SliverFixedExtentList(
        itemExtent: 150.0,
        delegate: SliverChildListDelegate([const Text('test')]),
      ),
      const SliverFillRemaining(
        hasScrollBody: false,
        child: ColoredBox(color: Colors.white),
      ),
    ],
  ),
  body: Container(
    color: Colors.blue.shade100,
    width: double.infinity,
    height: double.infinity,
  ),
);
```

### SlinkyView
A container for a DraggableScrollableSheet that responds to drag gestures by resizing the scrollable until a limit is reached, and then scrolling.  
The body is masked and cannot be manipulated when scrolling upward.

name | description
:---|:---
`SlinkyPanelParameter panelParameter` | More detail is explained below.
`SlinkyController controller` | More detail is explained below.
`SlinkyScrollParameter scrollParameter` | More detail is explained below.
`Widget body` | The body is displayed below the panel.
`Color maskColor` | The maskColor is the color of MaskView. MaskView is a Widget that is displayed between the panel and body when the panel is scrolled. The default value is `Color(0x99000000)`.
`bool barrierDismissible` | The barrierDismissible argument is used to indicate whether tapping on the barrier will scroll down the panel. The default value is `true`.

### SlinkyController
A controller that can be used to programmatically control this panel.

### SlinkyPanelParameter

This class manages the parameters of the panel.

name | description
:---|:---
`SliverAppBar appBar` | The widget displayed at the top in the Panel.
`List<Widget> contents` | The widget's displayed in the Panel. The widget's must be Sliver widgets.
`double maxSize` | The maximum fractional value of the panel height to use when displaying the panel. The default value is `0.9`.
`double minSize` | The maximum fractional value of the panel height to use when displaying the panel. The default value is `0.9`.
`BorderRadiusGeometry borderRadius` | The rounded corners of panel. The default value is `BorderRadius.all(Radius.circular(32)`

### SlinkyPanelParameter

This class manages the parameters of scroll.

name | description
:---|:---
`Duration duration` | Scrolling time. The default value is `Duration(milliseconds: 100)`.
`Curves curve` | Animation curves. The default value is `Curves.linear`.
`double scrollTolerance` | Scroll amount tolerance. The default value is `0.1`.

**The setting method is as follows:**

```dart
import 'package:slinky_view/slinky_view.dart';

SlinkyView(
  // ...
  scrollParameter: const SlinkyScrollParameter(
    duration: Duration(microseconds: 200),
    curve: Curves.bounceIn,
    scrollTolerance: 0.05
  ),
  // ...
);
```
