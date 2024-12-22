import 'package:flutter/material.dart';

mixin TextSectionMixin {
  final List<TextSpan> text = [];

  void add(String value, {bool bold = false}) {
    text.add(TextSpan(
        text: value,
        style: bold ? TextStyle(fontWeight: FontWeight.bold) : null));
  }

  void addStyled({required String text, required String boldDelimiter}) {
    this.text.add(_parseStyledText(text, boldDelimiter));
  }

  TextSpan _parseStyledText(String input, String boldDelimiter) {
    List<TextSpan> spans = [];
    int start = 0;

    while (start < input.length) {
      int openIndex = input.indexOf(boldDelimiter, start);
      if (openIndex == -1) {
        spans.add(TextSpan(text: input.substring(start)));
        break;
      }

      if (openIndex > start) {
        spans.add(TextSpan(text: input.substring(start, openIndex)));
      }

      int closeIndex =
          input.indexOf(boldDelimiter, openIndex + boldDelimiter.length);
      if (closeIndex == -1) {
        spans.add(TextSpan(text: input.substring(openIndex)));
        break;
      }

      spans.add(TextSpan(
        text: input.substring(openIndex + boldDelimiter.length, closeIndex),
        style: TextStyle(fontWeight: FontWeight.bold),
      ));

      start = closeIndex + boldDelimiter.length;
    }

    return TextSpan(children: spans);
  }
}
