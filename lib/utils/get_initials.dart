String getInitials({required String string, required int limitTo}) {
  if (string.isEmpty) {
    return '';
  }

  var buffer = StringBuffer();
  var split = string.split(' ');

  //For one word
  if (split.length == 1) {
    return string.substring(0, 1);
  }

  for (var i = 0; i < (limitTo ?? split.length); i++) {
    buffer.write(split[i][0]);
  }

  return buffer.toString();
}
