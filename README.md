A sheet that aligns to the bottom of a widget and expands as scroll up.

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

### SlinkyController
A controller that can be used to programmatically control this panel.

### SlinkyPanelParameter

This class manages the parameters of the panel.

name | description
:---|:---
appBar | The widget displayed at the top in the Panel.
contents | The widget's displayed in the Panel. The widget's must be Sliver widgets.
maxSize | The maximum fractional value of the panel height to use when displaying the panel. The default value is `0.9`.
minSize | The maximum fractional value of the panel height to use when displaying the panel. The default value is `0.9`.
borderRadius | The rounded corners of panel.

### SlinkyPanelParameter

This class manages the parameters of scroll.

name | description
:---|:---
duration | Scrolling time. The default value is `Duration(milliseconds: 100)`.
curve | Animation curves. The default value is `Curves.linear`.
scrollTolerance | Scroll amount tolerance. The default value is `0.1`.

**Set the following:**

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
