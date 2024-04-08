## 2.1.0

* Improving console, code and widget session settings. 

## 2.0.0

Introducing a revised version of DemoFlu. In this update, each menu item now directs users
to a page with multiple sections, such as texts, banners, and code samples.
This enhancement offers a more comprehensive documentation experience, allowing users
to explore various aspects of the package's functionality in a structured manner.
This update significantly improves the usability and experimentation capabilities of the package.

## 1.2.1

* Bugfix
  * Failing to find first menu item with example.

## 1.2.0

* `DemoFluApp`  
  * New parameters: `minMenuWidth` and `maxMenuWidth`.
  * Menu item wrapping.

## 1.1.0

* `DemoMenuItem`
  * Has been changed to store the menu children.
* `DemoFluApp`  
  * The `menuItems` parameter has been renamed to `rootMenus`.

## 1.0.0

* New layout
* Refactor
    * `DemoFluApp`
        * The `appMenuBuilder` parameter has been replaced by `menuItems` (list of `DemoMenu`).
        * The `widgetBackground` parameter has been renamed to `exampleBackground`.
    * `DemoMenuItem`
        * The `codeFile`, `resizable`, `maxSize` and `consoleEnabled` parameters has been moved to
          class `AbstractExample`.
        * The `builder` parameter has been replaced by `example`.
        * The `indentation` parameter has been renamed to `indent`.

## 0.16.0

* `multi_split_view` dependency updated to 2.2.0
* `flex_color_picker` dependency updated to 3.0.0

## 0.15.0

* `multi_split_view` dependency updated to 2.1.0
* Code view filling parent width.

## 0.14.0

* `MenuItem` renamed to `DemoMenuItem`
* `url_launcher` dependency updated to 6.1.2
* `flex_color_picker` dependency updated to 2.5.0

## 0.13.0

* `multi_split_view` dependency updated to 2.0.0

## 0.12.0

* `multi_split_view` dependency updated to 1.13.0

## 0.11.0+1

* Removing unnecessary imports

## 0.11.0

* `url_launcher` dependency updated to 6.0.18
* `multi_split_view` dependency updated to 1.11.0

## 0.10.0

* Feature to add extra Widgets that can communicate with the main Widget in the example

## 0.9.0

* New layout and resizing widget
* `multi_split_view` dependency updated to 1.10.0
* `url_launcher` dependency updated to 6.0.13

## 0.8.3

* `multi_split_view` dependency updated to 1.9.0

## 0.8.2

* `multi_split_view` dependency updated to 1.8.0

## 0.8.1

* `multi_split_view` dependency updated to 1.7.2

## 0.8.0

* Black and white color picker

## 0.7.2

* `multi_split_view` dependency updated to 1.7.1

## 0.7.1

* Bugfix
    * `MultiSplitViewTheme` being propagated to example widgets

## 0.7.0

* Update of dependencies
* Indentation in menu items

## 0.6.1

* Exporting Dart file correctly

## 0.6.0

* Simplifying widget injection in the menu

## 0.5.0

* Initial width and height weights
* Background color picker

## 0.4.0

* Custom buttons on the example menu.

## 0.3.0

* New menu style
* Improving performance

## 0.2.0

* Configurable menu item
* Console view area
* Copy code to clipboard
* Resizable areas

## 0.1.0

* Initial release
