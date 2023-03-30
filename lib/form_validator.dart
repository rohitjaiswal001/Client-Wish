class FormValidator {
  String? validateText(String? value) {
    //debugPrint('First name cant be empty');
    if (value == null) {
      return "First name can't be empty";
    }
    return value.isEmpty ? "First name can't be empty" : null;
  }

  // ignore: unused_element
  String? _validateEmail(String email) {
    // 1
    RegExp regex = RegExp(r'\w+@\w+\.\w+');
    // Add the following line to set focus to the email field
    //if (email.isEmpty || !regex.hasMatch(email)) _emailFocusNode.requestFocus();
    //
    if (email.isEmpty) {
      return 'We need an email address';
    } else if (!regex.hasMatch(email)) {
      return "That doesn't look like an email address";
    } else {
      return null;
    }
  }

  // ignore: unused_element
  String? _validatePassword(String pass1) {
    RegExp hasUpper = RegExp(r'[A-Z]');
    RegExp hasLower = RegExp(r'[a-z]');
    RegExp hasDigit = RegExp(r'\d');
    RegExp hasPunct = RegExp(r'[_!@#\$&*~-]');
    if (!RegExp(r'.{8,}').hasMatch(pass1)) {
      return 'Passwords must have at least 8 characters';
    }
    if (!hasUpper.hasMatch(pass1)) {
      return 'Passwords must have at least one uppercase character';
    }
    if (!hasLower.hasMatch(pass1)) {
      return 'Passwords must have at least one lowercase character';
    }
    if (!hasDigit.hasMatch(pass1)) {
      return 'Passwords must have at least one number';
    }
    if (!hasPunct.hasMatch(pass1)) {
      return 'Passwords need at least one special character like !@#\$&*~-';
    }
    return null;
  }

  // ignore: unused_element
  String? _validatePasswordConfirmation(String pass1, String pass2) {
    return (pass2 == pass1) ? null : "The two passwords must match";
    // Note that _pass1 is populated when a password is entered
  }

  // ignore: unused_element
  String? _validateTerms(bool agree) {
    return agree ? null : "You must agree before proceeding";
    // It's invalid if the user hasn't opted in by checking the box
  }
}
