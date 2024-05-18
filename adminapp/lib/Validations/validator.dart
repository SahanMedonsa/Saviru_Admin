class Validator {
  //Empty text validation
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  //email validation
  static String? validatorEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    //regular expression for email validotor
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalied email address';
    }
    return null;
  }

  //passsword
  static String? validationPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Passsword is required';
    }

    //check for minimum password lenghth
    else if (value.length < 6) {
      return 'Password must be at least 6 charactors long';
    }
    return null;
  }

  //confirm password
  // static String? validationconfirmPassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Confirm Passsword is required';
  //   } else if (SignupController.instantce.password ==
  //       SignupController.instantce.confirmPassword) {
  //     return 'Check password again';
  //   }
  //   return null;
  // }
}
