enum InputError {
  tooLong,
  tooShort,
  badCharacters,
  empty,
}

abstract class InputField {
  InputField(this.minLength, this.maxLength, this.regExp);

  String regExp;
  int minLength;
  int maxLength;
}

class InputValidator {
  static InputError? getInputError({
    required String? input,
    required String regExp,
    required int minLength,
    required int maxLength,
  }) {
    if (input == null || input.isEmpty) {
      return InputError.empty;
    }

    if (!RegExp(regExp).hasMatch(input)) {
      return InputError.badCharacters;
    }

    if (input.length > maxLength) {
      return InputError.tooLong;
    }

    if (input.length < minLength) {
      return InputError.tooShort;
    }

    return null;
  }
}
