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
}