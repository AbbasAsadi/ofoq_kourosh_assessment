mixin AppValidator {
  static String? globalValidator(String? value) {
    if (value?.isEmpty ?? true) return 'این مقدار ضروری است.';
    if ((value?.length ?? 0) < 3) return 'ورودی مجاز حداقل 3 کاراکتر است';

    return null;
  }

  static String? usernameValidator(String? value) {
    if (value?.isEmpty ?? true) return 'این مقدار ضروری است.';
    if ((value?.length ?? 0) < 3) return 'ورودی مجاز حداقل 3 کاراکتر است';
    final regExp = RegExp(r'^[a-zA-Z0-9]*$');
    if (!regExp.hasMatch(value ?? '')) {
      return 'فقط حروف انگلیسی و اعداد مورد قبول است';
    }

    return null;
  }

  static String? loginPasswordValidator(String? value) {
    if (value?.isEmpty ?? true) return 'این مقدار ضروری است.';
    if ((value?.length ?? 0) < 3) return 'ورودی مجاز حداقل 3 کاراکتر است';
    final regExp = RegExp(r'^[a-zA-Z0-9\-_@]*$');
    if (!regExp.hasMatch(value ?? '')) {
      return 'فقط حروف انگلیسی و اعداد و کاراکترهای @, _, - مورد قبول است';
    }

    return null;
  }

  static String? registerPasswordValidator(
    String? value,
    String? otherPasswordValue,
  ) {
    if (value?.isEmpty ?? true) return 'این مقدار ضروری است.';
    if ((value?.length ?? 0) < 3) return 'ورودی مجاز حداقل 3 کاراکتر است';
    final regExp = RegExp(r'^[a-zA-Z0-9\-_@]*$');
    if (!regExp.hasMatch(value ?? '')) {
      return 'فقط حروف انگلیسی و اعداد و کاراکترهای @, _, - مورد قبول است';
    }

    if (value != otherPasswordValue) {
      return 'رمز عبورهای وارد شده باهم برابر نیستند';
    }
    return null;
  }
}
