import 'dart:core';

import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_api_provider/api_provider.dart';
import 'package:best_hack/feature_auth/feature_input_validator/input_validator.dart';
import 'package:best_hack/feature_requests/request_login.dart';
import 'package:best_hack/feature_requests/request_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'feature_custom_widgets/custom_widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const double _paddingVertical = 20;

  static const String _passwordRegExp =
      r'''^[a-zA-Z0-9 !\"#$%&'()*+,-.\\/:;<=>?@[\\]+$''';
  static const int _passwordMaxLength = 128;
  static const int _passwordMinLength = 8;

  static const String _loginRegExp = r'^[a-zA-Z0-9]+$';
  static const int _loginMaxLength = 32;
  static const int _loginMinLength = 6;

  static const String _surnameRegExp = r'^[А-Яа-яA-Za-z]+$';
  static const int _surnameMaxLength = 128;
  static const int _surnameMinLength = 1;

  static const String _nameRegExp = _surnameRegExp;
  static const int _nameMaxLength = _surnameMaxLength;
  static const int _nameMinLength = _surnameMinLength;

  static const String _emailRegExp = '';
  static const int _emailMaxLength = 64;
  static const int _emailMinLength = 1;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late GlobalKey<FormState> _loginFormKey;
  late GlobalKey<FormState> _registerFormKey;

  String _surname = '';
  String _name = '';
  String _password = '';
  String _repeatedPassword = '';
  String _login = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loginFormKey = GlobalKey<FormState>();
    _registerFormKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        color: AppConstants.colors.white,
        child: SizedBox(
          width: 550,
          height: 610,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                child: Image.asset(AppConstants.paths.logoPng),
              ),
              const SizedBox(height: 20),
              DefaultTabController(
                length: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TabBar(
                      unselectedLabelColor: AppConstants.colors.black,
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 21,
                      ),
                      labelColor: AppConstants.colors.blue,
                      indicatorColor: AppConstants.colors.blue,
                      indicatorWeight: 5,
                      indicatorPadding: const EdgeInsets.symmetric(
                        horizontal: 32,
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                      tabs: [
                        Tab(text: 'Войти'),
                        Tab(text: 'Зарегистрироваться'),
                      ],
                    ),
                    SizedBox(
                      height: 450,
                      child: TabBarView(
                        children: [
                          Form(
                            key: _loginFormKey,
                            child: _loginTab(),
                          ),
                          Form(
                            key: _registerFormKey,
                            child: _registerTab(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerTab() {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(flex: 2, child: Container()),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: AuthScreen._paddingVertical),
                CustomInputFieldWidget(
                  onChanged: (surname) => _surname = surname,
                  regExp: AuthScreen._surnameRegExp,
                  maxLength: AuthScreen._surnameMaxLength,
                  minLength: AuthScreen._surnameMinLength,
                  onErrorMessage: (error) => checkSurname(error),
                  labelText: 'Фамилия',
                ),
                const SizedBox(height: 10),
                CustomInputFieldWidget(
                  onChanged: (name) => _name = name,
                  regExp: AuthScreen._nameRegExp,
                  maxLength: AuthScreen._nameMaxLength,
                  minLength: AuthScreen._nameMinLength,
                  onErrorMessage: (error) => checkName(error),
                  labelText: 'Имя',
                ),
                const SizedBox(height: 10),
                CustomInputFieldWidget(
                  onChanged: (login) => _login = login,
                  regExp: AuthScreen._loginRegExp,
                  maxLength: AuthScreen._loginMaxLength,
                  minLength: AuthScreen._loginMinLength,
                  onErrorMessage: (error) => checkLogin(error),
                  labelText: 'Логин',
                ),
                const SizedBox(height: 10),
                CustomInputFieldWidget(
                  onChanged: (email) => _email = email,
                  regExp: AuthScreen._emailRegExp,
                  maxLength: AuthScreen._emailMaxLength,
                  minLength: AuthScreen._emailMinLength,
                  onErrorMessage: (error) => checkEmail(error),
                  labelText: 'Электронная почта',
                ),
                const SizedBox(height: 10),
                CustomInputFieldWidget(
                  onChanged: (password) => _password = password,
                  regExp: AuthScreen._passwordRegExp,
                  maxLength: AuthScreen._passwordMaxLength,
                  minLength: AuthScreen._passwordMinLength,
                  onErrorMessage: (error) => checkPassword(error),
                  changeVisibility: true,
                  labelText: 'Пароль',
                ),
                const SizedBox(height: 10),
                CustomInputFieldWidget(
                  onChanged: (repeatedPassword) =>
                      _repeatedPassword = repeatedPassword,
                  regExp: AuthScreen._passwordRegExp,
                  maxLength: AuthScreen._passwordMaxLength,
                  minLength: AuthScreen._passwordMinLength,
                  changeVisibility: true,
                  onErrorMessage: (error) {
                    if (_password != _repeatedPassword) {
                      return 'Пароли не совпадают';
                    }

                    return checkPassword(error);
                  },
                  labelText: 'Повторите пароль',
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () => _signUp(),
                    child: const Text(
                      'Зарегистрироваться',
                      style: TextStyle(
                        fontSize: 21,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(flex: 2, child: Container()),
        ],
      ),
    );
  }

  Widget _loginTab() {
    return Row(
      children: [
        Expanded(flex: 2, child: Container()),
        Expanded(
          flex: 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: AuthScreen._paddingVertical),
              CustomInputFieldWidget(
                onChanged: (login) => _login = login,
                regExp: AuthScreen._loginRegExp,
                maxLength: AuthScreen._loginMaxLength,
                minLength: AuthScreen._loginMinLength,
                onErrorMessage: (error) => checkLogin(error),
                labelText: 'Логин',
              ),
              const SizedBox(height: 10),
              CustomInputFieldWidget(
                onChanged: (password) => _password = password,
                regExp: AuthScreen._passwordRegExp,
                maxLength: AuthScreen._passwordMaxLength,
                minLength: AuthScreen._passwordMinLength,
                onErrorMessage: (error) => checkPassword(error),
                changeVisibility: true,
                labelText: 'Пароль',
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () => _signIn(),
                  child: const Text(
                    'Войти',
                    style: TextStyle(
                      fontSize: 21,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AuthScreen._paddingVertical),
            ],
          ),
        ),
        Expanded(flex: 2, child: Container()),
      ],
    );
  }

  void _signIn() {
    if (!_loginFormKey.currentState!.validate()) {
      return;
    }

    ApiProvider.signIn(
      RequestLogin(
        login: _login,
        password: _password,
      ),
    ).then((responseLogin) {
      // @TODO responseLogin UUID
    });
  }

  void _signUp() {
    if (!_registerFormKey.currentState!.validate()) {
      return;
    }

    ApiProvider.signUp(RequestRegister(
      email: _email,
      login: _login,
      password: _password,
      name: _name,
      surname: _surname,
    ));
  }

  String? checkEmail(InputError? error) {
    switch (error) {
      case InputError.tooLong:
        return 'Почта слишком длинная';
      case InputError.tooShort:
        return 'Почта слишком короткая';
      case InputError.badCharacters:
        return 'Некорректная почта';
      case InputError.empty:
        return 'Заполните поле';
      case null:
        return null;
    }
  }

  String? checkName(InputError? error) {
    switch (error) {
      case InputError.tooLong:
        return 'Имя слишком длинное';
      case InputError.tooShort:
        return 'Имя слишком короткое';
      case InputError.badCharacters:
        return 'Использованы запрещенные символы';
      case InputError.empty:
        return 'Заполните поле';
      case null:
        return null;
    }
  }

  String? checkSurname(InputError? error) {
    switch (error) {
      case InputError.tooLong:
        return 'Фамилия слишком длинная';
      case InputError.tooShort:
        return 'Фамилия слишком короткая';
      case InputError.badCharacters:
        return 'Использованы запрещенные символы';
      case InputError.empty:
        return 'Заполните поле';
      case null:
        return null;
    }
  }

  String? checkLogin(InputError? error) {
    switch (error) {
      case InputError.tooLong:
        return 'Логин слишком длинный';
      case InputError.tooShort:
        return 'Логин слишком короткий';
      case InputError.badCharacters:
        return 'Некорректный логин';
      case InputError.empty:
        return 'Заполните поле';
      case null:
        return null;
    }
  }

  String? checkPassword(InputError? error) {
    switch (error) {
      case InputError.tooLong:
        return 'Пароль слишком длинный';
      case InputError.tooShort:
        return 'Пароль слишком короткий';
      case InputError.badCharacters:
        return 'Пароль содержит запрещенные символы';
      case InputError.empty:
        return 'Заполните поле';
      case null:
        return null;
    }
  }
}
