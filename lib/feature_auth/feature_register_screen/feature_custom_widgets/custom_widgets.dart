import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_auth/feature_input_validator/input_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputFieldWidget extends StatefulWidget {
  const CustomInputFieldWidget({
    Key? key,
    required this.onChanged,
    required this.onErrorMessage,
    required this.labelText,
    required this.regExp,
    required this.minLength,
    required this.maxLength,
  }) : super(key: key);

  final Function(String?) onChanged;
  final Function(InputError?) onErrorMessage;

  final String labelText;
  final String regExp;
  final int minLength;
  final int maxLength;

  @override
  State<CustomInputFieldWidget> createState() => _CustomInputFieldWidgetState();
}

class _CustomInputFieldWidgetState extends State<CustomInputFieldWidget> {
  late FocusNode _fieldFocus;

  void _onFocusChanged() {
    // Just a trigger to change color of the label
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _fieldFocus = FocusNode();
    _fieldFocus.addListener(_onFocusChanged);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 16, color: AppConstants.colors.black),
      focusNode: _fieldFocus,
      enableSuggestions: false,
      autocorrect: false,
      cursorColor: AppConstants.colors.blue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: styledInputDecoration(
        context: context,
        hasFocus: _fieldFocus.hasFocus,
        labelText: widget.labelText,
      ),
      onChanged: (String? changedTag) {
        widget.onChanged(changedTag);
      },
      validator: (input) {
        InputError? error = InputValidator.getInputError(
          input: input,
          regExp: widget.regExp,
          minLength: widget.minLength,
          maxLength: widget.maxLength,
        );

        return widget.onErrorMessage(error);
      },
    );
  }
}

// switch (error) {
// case null:
// return null;
// case InputError.badCharacters:
// return 'Tag contains prohibited characters';
// case InputError.empty:
// return 'Tag required';
// case InputError.tooShort:
// return 'Tag is too short';
// case InputError.tooLong:
// return 'Tag is too long';
// }

InputDecoration styledInputDecoration({
  required BuildContext context,
  Widget? prefixIcon,
  Widget? suffixIcon,
  required String labelText,
  String? hintText,
  required bool hasFocus,
}) {
  return InputDecoration(
    counterStyle: TextStyle(
      color: Theme.of(context).dividerColor,
    ),
    hintText: hintText,
    hintStyle: TextStyle(
      color: Theme.of(context).dividerColor,
    ),
    floatingLabelStyle: TextStyle(
      color: hasFocus
          ? Theme.of(context).primaryColor
          : Theme.of(context).dividerColor,
    ),
    labelStyle: TextStyle(
      fontFamily: 'Poppins',
      color: Theme.of(context).dividerColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    errorStyle: TextStyle(
      fontFamily: 'Poppins',
      color: Theme.of(context).errorColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    labelText: labelText,
    disabledBorder: styledOutlineInputBorder(
      color: Theme.of(context).dividerColor,
      width: 1.2,
    ),
    enabledBorder: styledOutlineInputBorder(
      color: Theme.of(context).dividerColor,
      width: 1.2,
    ),
    focusedBorder: styledOutlineInputBorder(
      color: Theme.of(context).primaryColor,
      width: 2.0,
    ),
    errorBorder: styledOutlineInputBorder(
      color: Theme.of(context).errorColor,
      width: 2.0,
    ),
    focusedErrorBorder: styledOutlineInputBorder(
      color: Theme.of(context).errorColor,
      width: 2.2,
    ),
  );
}

OutlineInputBorder styledOutlineInputBorder({
  required Color color,
  double width = 1.0,
}) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: width,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(8),
    ),
  );
}
