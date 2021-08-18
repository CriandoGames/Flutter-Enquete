import 'package:flutter/material.dart';

import './login_presenter.dart';
import '../login/components/components_login.dart';
import '../../components/components.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);
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
                  StreamBuilder<String>(
                      stream: presenter.emailErrorStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          decoration: InputDecoration(
                            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                              labelText: 'Email',
                              icon: Icon(Icons.email,
                                  color: Theme.of(context).primaryColor)),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: presenter.validateEmail,
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 32),
                    child: StreamBuilder<String>(
                      stream: presenter.passwordErrorStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                              labelText: 'Senha',
                              icon: Icon(Icons.lock,
                                  color: Theme.of(context).primaryColor)),
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: presenter.validatePassword,
                        );
                      }
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
