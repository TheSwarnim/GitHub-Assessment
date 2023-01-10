
import 'package:flutter/material.dart';

class Util {
  static String getMaxString(String? str, int max) {
    str = removeWhiteSpaces(str);
    if (str.length > max) {
      return '${str.substring(0, max)}...';
    }
    return str;
  }

  static String getFormattedDate(DateTime? date) {
    if (date == null) {
      return '';
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  // create a function that remove whitespaces from start and end
  static String removeWhiteSpaces(String? str) {
    if (str == null) {
      return '';
    }
    return str.trim();
  }

  static Color createUniqueColorForEachLanguage(String? language) {
    if (language == null) {
      return Colors.white;
    }
    final int hash = language.hashCode;
    final int r = (hash & 0xFF0000) >> 16;
    final int g = (hash & 0x00FF00) >> 8;
    final int b = hash & 0x0000FF;
    return Color.fromARGB(255, r, g, b);
  }
}