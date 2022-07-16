import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'forgot_password_screen.dart';
import 'home_page_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
//
  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final keyLoginForm = GlobalKey<FormState>();
  final keyEmailLoginForm = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Size screenSize = mediaQueryData.size;
    // C6HC, SM-G935F, iphone 7, iphone 12
    double width = screenSize.width; //360, 360, 375, 390
    double textScaleFactor = mediaQueryData.textScaleFactor; //1.3, 1.0, 1.0, 1.0
    double dpi = mediaQueryData.devicePixelRatio; // 2.0 , 3.0, 2.0, 3.0
    final double scaleText = width * textScaleFactor * dpi / 1000; //1.17
    final double verticalFactor = screenSize.height * dpi / 1000; //2.532

    return MaterialApp(
      home: Scaffold(
        //backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('The Village - Login'),
          elevation: 100,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction, //check for validation while typing
              key: keyLoginForm,
              child: Column(children: [
                //welcome
                Text('Welcome to The Village :)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: (scaleText * 20.0),
                    )),
                SizedBox(
                  height: 10 * verticalFactor,
                ),

                //email:
                TextFormField(
                    key: keyEmailLoginForm,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: //
                        InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter email',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: scaleText,
                        child: const Icon(
                          Icons.alternate_email,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      filled: false,
                      contentPadding: const EdgeInsets.all(16),
                      fillColor: Colors.blue,
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      EmailValidator(errorText: "Enter valid email id"),
                    ])),

                SizedBox(
                  height: 10 * verticalFactor,
                ),

                //password:
                TextFormField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: //
                        InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter Password',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: scaleText,
                        child: const Icon(
                          Icons.password,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      filled: false,
                      contentPadding: const EdgeInsets.all(16),
                      fillColor: Colors.blue,
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(6, errorText: "Password should be at least 6 characters"),
                      MaxLengthValidator(15, errorText: "Password should not be greater than 15 characters")
                    ])),

                // something else: facebook
                // something else: google
                // something else: apple

                SizedBox(
                  height: 10 * verticalFactor,
                ),

                SizedBox(
                  height: 60,
                  width: 250,
                  child: ElevatedButton.icon(
                    key: const Key('KeyLoginButton'),
                    icon: const Icon(
                      Icons.login_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    label: Text('Login', style: TextStyle(fontSize: 20 * scaleText)),
                    style: ElevatedButton.styleFrom(elevation: 20, shape: const StadiumBorder()),
                    onPressed: () {
                      if (keyLoginForm.currentState!.validate()) {
                        if (kDebugMode) {
                          print("Debug: Validated -> Navigator.push()");
                        }
                        // next screen:
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
                      } else {
                        if (kDebugMode) {
                          print("Debug: Not Validated: stay");
                        }
                      }
                    },
                  ),
                ),

                //
                const SizedBox(
                  height: 15,
                ),

                SizedBox(
                  height: 50,
                  width: 230,
                  child: OutlinedButton.icon(
                      key: const Key('KeyForgotButton'),
                      icon: const Icon(
                        Icons.question_mark_rounded,
                        color: Colors.blue,
                        size: 15,
                      ),
                      label: const Text('Forgot password'),
                      style: ElevatedButton.styleFrom(elevation: 20, shape: const StadiumBorder()),
                      onPressed: () {
                        if (keyEmailLoginForm.currentState!.validate()) {
                          var emailValue = keyEmailLoginForm.currentState!.value as String;
                          if (kDebugMode) {
                            print("Debug: Forgot password -> Navigator.push() email: $emailValue");
                          }
                          // next screen: pass this email value
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPasswordScreen(email: emailValue)));
                        }
                      }),
                ),

                const SizedBox(
                  height: 15,
                ),

                SizedBox(
                  height: 60,
                  width: 250,
                  child: ElevatedButton.icon(
                    key: const Key('KeySignUpButton'),
                    icon: const Icon(
                      Icons.person_add_alt_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    label: Text('Sign up', style: TextStyle(fontSize: 20 * scaleText)),
                    style: ElevatedButton.styleFrom(elevation: 20, shape: const StadiumBorder()),
                    onPressed: () {
                      if (kDebugMode) {
                        print("Debug:  Navigator.push()");
                      }
                      // next screen:
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
                    },
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
