import 'package:demoflu/src/model.dart';
import 'package:demoflu/src/provider.dart';
import 'package:demoflu/src/theme.dart';
import 'package:demoflu/src/widgets/link_widget.dart';
import 'package:demoflu/src/widgets/logo.dart';
import 'package:demoflu/src/widgets/menu_widget.dart';
import 'package:demoflu/src/widgets/page_widget.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Demo app widget
@internal
class DemoFluAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);
    DemoFluTheme theme = DemoFluProvider.themeOf(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: model.title,
        theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(fontSizeFactor: 1.2),
            scaffoldBackgroundColor: theme.appBackground),
        home: Scaffold(
            appBar: AppBar(
                title:
                    Text(model.title, style: TextStyle(color: theme.textColor)),
                scrolledUnderElevation: 0,
                shadowColor: Colors.black,
                backgroundColor: theme.appBackground,
                shape: Border(
                    bottom: BorderSide(color: Colors.grey[300]!, width: 2)),
                elevation: 0,
                actions: [
                  /*  IconButton(
                      onPressed: () =>
                          model.settingsVisible = !model.settingsVisible,
                      icon: Icon(Icons.settings),
                      tooltip: 'Settings'),*/
                  DemoFluLogo()
                ]),
            body: _buildBody(context)));
  }

  Widget _buildBody(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);
    return ListenableBuilder(
        listenable: model,
        builder: (BuildContext context, Widget? child) {
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            double menuWidth = 300;

            Widget menu = ConstrainedBox(
                constraints:
                    BoxConstraints(minWidth: menuWidth, maxWidth: menuWidth),
                child: MenuWidget());

            Widget body;
            if (constraints.maxWidth > menuWidth) {
              body = Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [menu, Expanded(child: _buildPageArea(context))]);
            } else {
              body = _buildPageArea(context);
            }
            return body;
          });
        });
  }

  Widget _buildPageArea(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);
    List<Widget> children = [];
    children.add(Positioned.fill(key: model.selectedMenuItem.key, child: DemoFluPageWidget(menuItem: model.selectedMenuItem)));
    if(model.link!=null){
      children.add(Positioned.fill(child: LinkWidget(link:model.link!)));
    }
     return Stack(children: children);
  }
}
