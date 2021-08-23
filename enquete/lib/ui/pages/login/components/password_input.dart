import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_presenter.dart';

class PassordInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<String>(
        stream: presenter.passwordErrorStream,
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
            onChanged: presenter.validatePassword,
          );
        });
  }
}