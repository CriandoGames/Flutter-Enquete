import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './login_presenter.dart';
import '../login/components/components_login.dart';
import '../../components/components.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (context) {
      widget.presenter.isLoadingController!.listen((isLoadin) {
        if (isLoadin) {
          showLoading(context);
        } else {
          hideLoading(context);
        }
      });

      widget.presenter.mainErrorController?.listen((error) {
        showErrorMessage(context, error);
      });

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            HeadLine1(
              title: 'Login',
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: Provider(
                create: (context) => widget.presenter,
                child: Form(
                    child: Column(
                  children: [
                    EmailInput(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 32),
                      child: StreamBuilder<String>(
                          stream: widget.presenter.passwordErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  errorText: snapshot.data?.isEmpty == true
                                      ? null
                                      : snapshot.data,
                                  labelText: 'Senha',
                                  icon: Icon(Icons.lock,
                                      color: Theme.of(context).primaryColor)),
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: widget.presenter.validatePassword,
                            );
                          }),
                    ),
                    StreamBuilder<bool>(
                        stream: widget.presenter.isFormValidStream,
                        builder: (context, snapshot) {
                          return ElevatedButton(
                              onPressed: snapshot.data == true
                                  ? widget.presenter.auth
                                  : null,
                              child: Text(
                                'Entrar'.toUpperCase(),
                              ));
                        }),
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                        label: Text('Criar Conta'))
                  ],
                )),
              ),
            )
          ],
        ),
      );
    }));
  }
}
