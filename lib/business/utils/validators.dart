String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter a valid Email Address';
  else
    return null;
}

String validateYear(String value) {
  Pattern pattern = r'^[2][0]{1}[1-2]{1}[0-9]{1}$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return 'invalid year';
  } else {
    return null;
  }
}

String validateURL(String value) {
  Pattern pattern =
      r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&=]*)";
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return "Invalid url.";
  } else {
    return null;
  }
}
