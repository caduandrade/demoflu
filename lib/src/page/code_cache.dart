import 'package:demoflu/src/page/code_section.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

@internal
class CodeCache {
  /// fila / raw code
  Map<String, String> _cache = {};

  void clearCache() {
    _cache.clear();
  }

  Future<void> load(
      {required String file}) async {
    String? rawCode = _cache[file];
    if (rawCode == null) {
      rawCode = await rootBundle.loadString(file);
      _cache[file] = rawCode;
    }
  }

  String getRawCodeFrom(
      {required String file})  {
    String? rawCode = _cache[file];
    if (rawCode == null) {
      throw StateError('Cache is not loaded: $file');
    }
    return rawCode;
  }

  String process(
      {required String rawCode,
      required LoadMode loadMode,
      required String? mark,
      required bool discardMarks,
      required bool discardMultipleEmptyLines,
      required bool discardLastEmptyLine}) {
    List<String> code;
    code = rawCode.split('\n');
    String? markStart, markEnd;
    if (mark != null) {
      markStart = '//@demoflu_start:' + mark;
      markEnd = '//@demoflu_end:' + mark;
    }
    if (loadMode != LoadMode.readAll && markStart != null && markEnd != null) {
      if (loadMode == LoadMode.readOnlyMarked) {
        code = _keepStringsBetweenStartAndEnd(
            list: code, start: markStart, end: markEnd);
      } else if (loadMode == LoadMode.ignoreMarked) {
        code = _removeStringsBetweenStartAndEnd(
            list: code, start: markStart, end: markEnd);
      }
    }
    if (discardMarks) {
      code = code.where((line) {
        line = line.trim();
        return !(line.startsWith('//@demoflu_start:') ||
            line.startsWith('//@demoflu_end:'));
      }).toList();
    }
    if (discardMultipleEmptyLines) {
      int i = 0;
      while (i < code.length) {
        if (i < code.length - 2 &&
            code[i].trim().isEmpty &&
            code[i + 1].trim().isEmpty) {
          code.removeAt(i);
        } else {
          i++;
        }
      }
    }
    if (discardLastEmptyLine) {
      if (code.isNotEmpty && code.last.isEmpty) {
        code.removeLast();
      }
    }

    int minSpaces = _findMinSpaces(code);
    if (minSpaces > 0) {
      code = _alignStrings(code, minSpaces);
    }

    return code.join('\n');
  }

  int _findMinSpaces(List<String> strings) {
    int? minSpaces;
    for (String str in strings) {
      int spaces = _countLeadingSpaces(str);
      if (minSpaces == null) {
        minSpaces = spaces;
      } else if (spaces < minSpaces) {
        minSpaces = spaces;
      }
    }
    return minSpaces ?? 0;
  }

  int _countLeadingSpaces(String str) {
    int count = 0;
    for (int i = 0; i < str.length; i++) {
      if (str[i] == ' ') {
        count++;
      } else {
        break;
      }
    }
    return count;
  }

  List<String> _alignStrings(List<String> strings, int minSpaces) {
    List<String> alignedStrings = [];
    for (String str in strings) {
      if (minSpaces > 0 && str.length >= minSpaces) {
        alignedStrings.add(str.substring(minSpaces));
      } else {
        alignedStrings.add(str);
      }
    }
    return alignedStrings;
  }

  List<String> _removeStringsBetweenStartAndEnd(
      {required List<String> list,
      required String start,
      required String end}) {
    bool removing = false;
    List<String> resultList = [];
    for (var str in list) {
      if (str.trim() == start) {
        removing = true;
      } else if (str.trim() == end) {
        removing = false;
      } else if (!removing) {
        resultList.add(str);
      }
    }
    return resultList;
  }

  List<String> _keepStringsBetweenStartAndEnd(
      {required List<String> list,
      required String start,
      required String end}) {
    bool keeping = false;
    List<String> resultList = [];
    for (var str in list) {
      if (str.trim() == start) {
        keeping = true;
      } else if (str.trim() == end) {
        keeping = false;
      } else if (keeping) {
        resultList.add(str);
      }
    }
    return resultList;
  }
}
