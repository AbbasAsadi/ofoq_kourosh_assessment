mixin AppValidator {
  static String? globalValidator(String? value) {
    if (value?.isEmpty ?? true) return 'این مقدار ضروری است.';
    if ((value?.length ?? 0) < 3) return 'ورودی مجاز حداقل 3 کاراکتر است';
    return null;
  }
}
