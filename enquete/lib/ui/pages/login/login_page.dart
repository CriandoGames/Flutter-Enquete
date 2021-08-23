import 'package:flutter/material.dart';

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
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return SimpleDialog(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Aguarde...',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                );
              });
        } else {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        }
      });

      widget.presenter.mainErrorController?.listen((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            error,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red[900],
        ));
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
              child: Form(
                  child: Column(
                children: [
                  StreamBuilder<String>(
                      stream: widget.presenter.emailErrorStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          decoration: InputDecoration(
                              errorText: snapshot.data?.isEmpty == true
                                  ? null
                                  : snapshot.data,
                              labelText: 'Email',
                              icon: Icon(Icons.email,
                                  color: Theme.of(context).primaryColor)),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: widget.presenter.validateEmail,
                        );
                      }),
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
            )
          ],
        ),
      );
    }));
  }
}
