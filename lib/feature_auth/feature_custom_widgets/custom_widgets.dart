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
    this.changeVisibility = false,
  }) : super(key: key);

  final Function(String) onChanged;
  final Function(InputError?) onErrorMessage;

  final String labelText;
  final String regExp;
  final int minLength;
  final int maxLength;
  final bool changeVisibility;

  @override
  State<CustomInputFieldWidget> createState() => _CustomInputFieldWidgetState();
}

class _CustomInputFieldWidgetState extends State<CustomInputFieldWidget> {
  late FocusNode _fieldFocus;
  bool _showPassword = false;

  void _onFocusChanged() {
    // Just a trigger to change color of the label
    setState(() {});
  }

  void _onVisibilityChanged() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void initState() {
    super.initState();

    _fieldFocus = FocusNode();
    _fieldFocus.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _fieldFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 16, color: AppConstants.colors.black),
      focusNode: _fieldFocus,
      enableSuggestions: false,
      autocorrect: false,
      obscureText: !_showPassword && widget.changeVisibility,
      cursorColor: AppConstants.colors.blue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: styledInputDecoration(
        context: context,
        hasFocus: _fieldFocus.hasFocus,
        labelText: widget.labelText,
        suffixIcon: widget.changeVisibility
            ? GestureDetector(
                onTap: () => _onVisibilityChanged(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              )
            : null,
      ),
      onChanged: (String? changedTag) {
        if (changedTag != null) {
          widget.onChanged(changedTag);
        }
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
      color: Theme.of(context).dividerColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    errorStyle: TextStyle(
      color: Theme.of(context).errorColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 0.5,
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
