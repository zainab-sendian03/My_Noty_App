validInput(String val, int max, int min, {String? type}) {
  if (val.isEmpty) {
    return "This field cannot be empty";
  }
  if (val.length > max) {
    return "This field cannot be longer than $max characters";
  }
  if (val.length < min) {
    return "This field must be at least $min characters long";
  }

  if (type == 'email') {
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
      return "Please enter a valid email address";
    }
  }

  if (type == 'password') {
    if (!RegExp(r'[A-Z]').hasMatch(val)) {
      return "Password must contain at least one uppercase letter";
    }
    if (!RegExp(r'[a-z]').hasMatch(val)) {
      return "Password must contain at least one lowercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(val)) {
      return "Password must contain at least one number";
    }
  }

  return null;
}
