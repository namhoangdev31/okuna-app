import 'package:flutter/material.dart';

class LogDebug {
  String fileName = '';

  LogDebug(String name) {
    this.fileName = name;
  }

  show(String nameFunction) {
    debugPrint('#OKUNA #$fileName #$nameFunction');
  }
}
