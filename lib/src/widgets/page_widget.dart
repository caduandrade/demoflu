import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/page/code_cache.dart';
import 'package:demoflu/src/page/code_section.dart';
import 'package:demoflu/src/page/section_collection.dart';
import 'package:demoflu/src/provider.dart';
import 'package:demoflu/src/widgets/breadcrumb.dart';
import 'package:demoflu/src/widgets/section_collection_widget.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Widget for page.
@internal
class DemoFluPageWidget extends StatefulWidget {
  const DemoFluPageWidget({required this.menuItem, super.key});

  final DemoMenuItem menuItem;

  @override
  State<StatefulWidget> createState() => DemoFluPageState();
}

class DemoFluPageState extends State<DemoFluPageWidget> {
  late DemoFluPage? _page;

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
      List<CodeSection> codeSections =
          SectionCollectionHelper.codeSectionsOf(sections);

      return FutureBuilder<_LoadStatus>(
          future: _load(context,
              codeSections), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<_LoadStatus> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.success) {
                return _buildPageContent(sections:sections);
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
    return _buildPageContent(sections:null);
  }

  Future<_LoadStatus> _load(
      BuildContext context, List<CodeSection> codeSections) async {
    CodeCache codeCache = DemoFluProvider.codeCacheOf(context);
    for (CodeSection section in codeSections) {
      try {
        String code = await codeCache.load(
            file: section.file,
            loadMode: section.loadMode,
            mark: section.mark,
            discardMarks: section.discardMarks,
            discardMultipleEmptyLines: section.discardMultipleEmptyLines,
            discardLastEmptyLine: section.discardLastEmptyLine);
        CodeSectionHelper.setCode(section: section, code: code);
      } catch (e) {
        return _LoadStatus(errorFile: section.file);
      }
    }
    return _LoadStatus(errorFile: null);
  }

  Widget _buildPageContent({required PageSections? sections}) {
    List<Widget> children = [];
    if (sections != null) {
      children.add(BreadcrumbWidget(menuItem: widget.menuItem));
      children.add(SizedBox(height: 24));
      children.add(SectionCollectionWidget(collection: sections));
    }

    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(32, 16, 32, 32),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children)));
  }
}

class _LoadStatus {
  _LoadStatus({required this.errorFile});

  final String? errorFile;

  bool get success => errorFile == null;
}
