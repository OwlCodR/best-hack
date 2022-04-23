import 'dart:ui';

class AppConstants {
  static _AppColors colors = _AppColors();
  static _AppRoutes routes = _AppRoutes();
  static _AppKeys keys = _AppKeys();
  static _AppPaths paths = _AppPaths();
}

class _AppColors {
  Color veryLightPurple = const Color(0xff918FF8);
  Color lightPurple = const Color(0xff364484);
  Color purple = const Color(0xff2F3F83);
  Color darkPurple = const Color(0xff28367B);
  Color veryDarkPurple = const Color(0xff142475);
  Color white = const Color(0xFFFFFFFF);
  Color green = const Color(0xff6FE6A9);
  Color red = const Color(0xffF76A9B);
  Color gray = const Color(0xFFC8CACF);

  Color lightBlue = const Color(0xFFF3F6FF);
  Color blue = const Color(0xFF5E7CEC);
  Color black = const Color(0xFF323030);
}

class _AppRoutes {
  String mainScreen = '/main';
  String loginScreen = '/login';
  String registerScreen = '/register';
}

class _AppPaths {
  String logoPng = 'assets/images/logo.png';
  String arrowUp = 'assets/images/arrow_up.png';
  String arrowDown = 'assets/images/arrow_down.png';
  String login = 'assets/images/login.png';
  String bookmark = 'assets/images/bookmark.png';
  String buy = 'assets/images/buy.png';
  String sell = 'assets/images/sell.png';
}

class _AppKeys {
  String token = 'TOKEN';
  String specification = 'SPECIFICATION';
  String inviteCode = 'INVITE_CODE';
  String lastUpdated = 'last_updated';
}
