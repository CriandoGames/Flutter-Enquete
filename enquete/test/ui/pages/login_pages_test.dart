import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:enquete/ui/pages/pages.dart';

class LoginPresentSpy extends Mock implements LoginPresenter {}

late LoginPresenter presenter;
late StreamController<String> emailErrorController;
late StreamController<String> passwordErrorController;
void main() {
  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresentSpy();
    emailErrorController = StreamController<String>();
    passwordErrorController = StreamController<String>();
    final loginPage = MaterialApp(home: LoginPage(presenter));

    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);

         when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);

    await tester.pumpWidget(loginPage);
  }

  testWidgets('should load with correct initial state',
      (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Email'), matching: find.byType(Text));

    expect(emailTextChildren, findsOneWidget,
        reason: 'when a TextFildForm has only one text child, means it ' +
            'has no erros since one og the childs is always the label text');

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));

    expect(
      passwordTextChildren,
      findsOneWidget,
    );

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('should call validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(presenter.validatePassword(password));
  });

  testWidgets('should call validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('any error');
    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('should present no erro if email is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('');

    await tester.pump();

    expect(find.descendant(
        of: find.bySemanticsLabel('Email'), matching: find.byType(Text)), findsOneWidget);
  });

    testWidgets('should present erro if password is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add('any erro');

    await tester.pump();

    expect(find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)), findsOneWidget);
  });

      testWidgets('should present no erro if password is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add('');

    await tester.pump();

    expect(find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)), findsOneWidget);
  });
}
