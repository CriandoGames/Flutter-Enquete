import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '/ui/pages/login_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
