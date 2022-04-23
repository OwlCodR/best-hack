import 'package:best_hack/config/constants/constants.dart';
import 'package:best_hack/feature_auth/feature_register_screen/feature_custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
            children: [
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                child: Image.asset(AppConstants.paths.logoPng),
              ),
              const SizedBox(height: 20),
              DefaultTabController(
                length: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      TabBar(
                        unselectedLabelColor: AppConstants.colors.black,
                        unselectedLabelStyle: const TextStyle(
                          fontFamily: 'Poppins',
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
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                        tabs: [
                          Tab(text: 'Войти'),
                          Tab(text: 'Зарегистрироваться'),
                        ],
                      ),
                      SizedBox(
                        height: 420,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: TabBarView(
                            children: [
                              _loginTab(),
                              _registerTab(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerTab() {
    return Column(
      children: [
        const SizedBox(height: 10),
        CustomInputFieldWidget(
          onChanged: (name) {},
          regExp: '',
          maxLength: 32,
          onErrorMessage: (error) {},
          labelText: 'Имя',
          minLength: 2,
        ),
        const SizedBox(height: 10),
        CustomInputFieldWidget(
          onChanged: (surname) {},
          regExp: '',
          maxLength: 32,
          onErrorMessage: (error) {},
          labelText: 'Фамилия',
          minLength: 2,
        ),
        const SizedBox(height: 10),
        CustomInputFieldWidget(
          onChanged: (email) {},
          regExp: '',
          maxLength: 32,
          onErrorMessage: (error) {},
          labelText: 'Электронная почта',
          minLength: 2,
        ),
        const SizedBox(height: 10),
        CustomInputFieldWidget(
          onChanged: (password) {},
          regExp: '',
          maxLength: 128,
          onErrorMessage: (error) {},
          labelText: 'Пароль',
          minLength: 8,
        ),
        const SizedBox(height: 10),
        CustomInputFieldWidget(
          onChanged: (repeatedPassword) {},
          regExp: '',
          maxLength: 128,
          onErrorMessage: (error) {},
          labelText: 'Повторите пароль',
          minLength: 8,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text(
              'Зарегистрироваться',
              style: TextStyle(
                fontSize: 21,
                fontFamily: 'Poppins',
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
    );
  }

  Widget _loginTab() {
    return const Icon(Icons.directions_transit);
  }

  _validateTag(String? tag) {}

  void _onChanged() {}
}
