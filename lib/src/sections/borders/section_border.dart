import 'package:flutter/material.dart';

abstract class SectionBorder {

  const SectionBorder();

  BoxBorder? build();

}

class Borderless extends SectionBorder{

  const Borderless();

  @override
  BoxBorder? build() => null;
}