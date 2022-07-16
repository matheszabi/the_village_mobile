// This is a basic Flutter widget test.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_village_mobile/main.dart';
import 'package:the_village_mobile/screens/forgot_password_screen.dart';
import 'package:the_village_mobile/screens/login_screen.dart';
import 'package:the_village_mobile/screens/sign_up_screen.dart';

void main() {
  testWidgets('Testing LoginScreen widget login validation', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    final loginScreenFinder = find.byType(LoginScreen);
    expect(loginScreenFinder, findsOneWidget);

    final Finder emailFinder = find.widgetWithText(TextFormField, 'Email');
    final Finder passwordFinder = find.widgetWithText(TextFormField, 'Password');
    final Finder loginFinder = find.byKey(const Key('KeyLoginButton'));
    final Finder forgotFinder = find.byKey(const Key('KeyForgotButton'));
    final Finder signUpFinder = find.byKey(const Key('KeySignUpButton'));

    expect(emailFinder, findsOneWidget);
    expect(passwordFinder, findsOneWidget);
    expect(loginFinder, findsOneWidget);
    expect(forgotFinder, findsOneWidget);
    expect(signUpFinder, findsOneWidget);

    expect(find.text('* Required'), findsNothing);

    // enter a not valid email format:
    await tester.enterText(emailFinder, 'not_valid_email_format');
    await tester.tap(loginFinder);
    await tester.pump();
    expect(find.text('Enter valid email id'), findsOneWidget);
    expect(find.text('* Required'), findsOneWidget); //password

    // enter a  valid email format:
    await tester.enterText(emailFinder, 'valid@email.com');
    await tester.tap(loginFinder);
    await tester.pump();
    expect(find.text('Enter valid email id'), findsNothing);
    expect(find.text('* Required'), findsOneWidget); //password

    // add a to short password:
    await tester.enterText(passwordFinder, '12');
    await tester.tap(loginFinder);
    await tester.pump();
    expect(find.text('Enter valid email id'), findsNothing);
    expect(find.text('* Required'), findsNothing);
    expect(find.text('Password should be at least 6 characters'), findsOneWidget);

    // add a to long password:
    await tester.enterText(passwordFinder, '1234567890123456');
    await tester.tap(loginFinder);
    await tester.pump();
    expect(find.text('Enter valid email id'), findsNothing);
    expect(find.text('* Required'), findsNothing);
    expect(find.text('Password should not be greater than 15 characters'), findsOneWidget);

    // password: ok, email wrong
    await tester.enterText(passwordFinder, '1234567');
    await tester.enterText(emailFinder, 'not_valid_email_');
    await tester.tap(loginFinder);
    await tester.pump();
    expect(find.text('Enter valid email id'), findsOneWidget);
    expect(find.text('* Required'), findsNothing);
    expect(find.text('Password should not be greater than 15 characters'), findsNothing);

    //password ok AND email ok
    await tester.enterText(passwordFinder, '1234567890');
    await tester.enterText(emailFinder, 'valid@email.com');
    await tester.tap(loginFinder);
    await tester.pumpAndSettle(); // it will go to next screen

    expect(loginScreenFinder, findsNothing);
  });

  testWidgets('Testing LoginScreen widget forgot', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    final loginScreenFinder = find.byType(LoginScreen);
    expect(loginScreenFinder, findsOneWidget);

    final Finder emailFinder = find.widgetWithText(TextFormField, 'Email');
    expect(emailFinder, findsOneWidget);
    String emailParamToPass = 'param_passed@email.com';
    await tester.enterText(emailFinder, emailParamToPass);

    final Finder forgotFinder = find.byKey(const Key('KeyForgotButton'));
    await tester.tap(forgotFinder);
    await tester.pumpAndSettle(); // it will go to next screen

    expect(loginScreenFinder, findsNothing);

    final forgotPasswordScreenFinder = find.byType(ForgotPasswordScreen);
    expect(forgotPasswordScreenFinder, findsOneWidget);

    final Finder emailFinder2 = find.widgetWithText(TextFormField, 'Email');
    expect(forgotPasswordScreenFinder, findsOneWidget);

    FormFieldState<dynamic> emailState = tester.state(emailFinder2);
    // check if is the same:
    expect(emailState.value, emailParamToPass);
  });

  testWidgets('Testing ForgotPassword widget ', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    final loginScreenFinder = find.byType(LoginScreen);
    expect(loginScreenFinder, findsOneWidget);

    final Finder emailFinder = find.widgetWithText(TextFormField, 'Email');
    expect(emailFinder, findsOneWidget);
    String emailParamToPass = 'param_passed@email.com';
    await tester.enterText(emailFinder, emailParamToPass);

    final Finder forgotFinder = find.byKey(const Key('KeyForgotButton'));
    await tester.tap(forgotFinder);
    await tester.pumpAndSettle(); // it will go to next screen

    expect(loginScreenFinder, findsNothing);

    final forgotPasswordScreenFinder = find.byType(ForgotPasswordScreen);
    expect(forgotPasswordScreenFinder, findsOneWidget);

    final Finder emailFinder2 = find.widgetWithText(TextFormField, 'Email');
    expect(forgotPasswordScreenFinder, findsOneWidget);

    FormFieldState<dynamic> emailState = tester.state(emailFinder2);
    // check if is the same:
    expect(emailState.value, emailParamToPass);

    final Finder resetPassword = find.byKey(const Key('KeyResetPasswordButton'));
    expect(resetPassword, findsOneWidget);

    //change to invalid:
    await tester.enterText(emailFinder, "-");
    await tester.tap(resetPassword);
    await tester.pump();
    // it is invalid, so shouldn't go away:
    expect(forgotPasswordScreenFinder, findsOneWidget);

    //change to something accepted
    await tester.enterText(emailFinder, "test@hosting.com");
    await tester.tap(resetPassword);

    await tester.pumpAndSettle(); // it will go to back screen
    expect(forgotPasswordScreenFinder, findsNothing);
    expect(loginScreenFinder, findsOneWidget);
  });

  testWidgets('Testing LoginScreen signup button ', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    final loginScreenFinder = find.byType(LoginScreen);
    expect(loginScreenFinder, findsOneWidget);

    final Finder signUpFinder = find.byKey(const Key('KeySignUpButton'));
    expect(signUpFinder, findsOneWidget);
    //press the button
    await tester.tap(signUpFinder);
    await tester.pumpAndSettle();

    expect(loginScreenFinder, findsNothing);

    final signUpScreenFinder = find.byType(SignUpScreen);
    expect(signUpScreenFinder, findsOneWidget);
  });
}
