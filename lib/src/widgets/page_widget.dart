import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/page/code_cache.dart';
import 'package:demoflu/src/page/section_collection.dart';
import 'package:demoflu/src/provider.dart';
import 'package:demoflu/src/widgets/breadcrumb.dart';
import 'package:demoflu/src/widgets/section_collection_widget.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Widget for page.
@internal
class DemoFluPageWidget extends StatefulWidget {
   DemoFluPageWidget({required this.menuItem}):super(key:menuItem.key);

  final DemoMenuItem menuItem;

  @override
  State<StatefulWidget> createState() => DemoFluPageState();
}

class DemoFluPageState extends State<DemoFluPageWidget> {
  late DemoFluPage? _page;
  double _offset =0;

  @override
  void initState() {
    super.initState();
    if (widget.menuItem.page != null) {
      _page = widget.menuItem.page!();
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_page != null) {
      PageSections sections = PageSections();
      _page!.buildSections(context, sections);
      List<String> codeFiles =
          SectionCollectionHelper.codeFilesOf(sections);
      return FutureBuilder<_LoadStatus>(
          key: ValueKey<int>(sections.hashCode),
          future: _load(context, codeFiles),
          builder: (BuildContext context, AsyncSnapshot<_LoadStatus> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.success) {
                return _buildPageContent(sections: sections);
              } else {
                return Center(
                    child: Text('Unable to load ${snapshot.data!.errorFile!}',
                        style: TextStyle(color: Colors.red[900])));
              }
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Unknown error',
                      style: TextStyle(color: Colors.red[900])));
            }
            return Center(child: Text('Loading...'));
          });
    }
    return _buildPageContent( sections: null);
  }

  Future<_LoadStatus> _load(
      BuildContext context, List<String> codeFiles) async {
    CodeCache codeCache = DemoFluProvider.codeCacheOf(context);
    for (String file in codeFiles) {
      try {
        await codeCache.load(file: file);
      } catch (e) {
        return _LoadStatus(errorFile: file);
      }
    }
    return _LoadStatus(errorFile: null);
  }

  Widget _buildPageContent({ required PageSections? sections}) {
    List<Widget> children = [];
    if (sections != null) {
      children.add(BreadcrumbWidget(menuItem: widget.menuItem));
      children.add(SizedBox(height: 24));
      children.add(SectionCollectionWidget(collection: sections));
    }

    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification pos) {
          if(pos is ScrollEndNotification) {
            _offset=pos.metrics.pixels;
          }
          return false;
        }, child:
      SingleChildScrollView(
      controller: ScrollController(initialScrollOffset: _offset),
               child: Padding(
            padding: EdgeInsets.fromLTRB(32, 16, 32, 32),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children))));
  }



}

class _LoadStatus {
  _LoadStatus({required this.errorFile});

  final String? errorFile;

  bool get success => errorFile == null;
}
