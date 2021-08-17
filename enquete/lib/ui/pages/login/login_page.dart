import 'package:flutter/material.dart';

import '../login/components/components_login.dart';
import '../../components/components.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            HeadLine1(
              title: 'Login',
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email,
                            color: Theme.of(context).primaryColor)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 32),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Senha',
                          icon: Icon(Icons.lock,
                              color: Theme.of(context).primaryColor)),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: null, child: Text('Entrar'.toUpperCase())),
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.person),
                      label: Text('Criar Conta'))
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
