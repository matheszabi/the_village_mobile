import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key, this.email}) : super(key: key);

  final String? email;

  @override
  State<ForgotPasswordScreen> createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final keyEmailForgotPassword = GlobalKey<FormFieldState>();
  final keyFormForgotPassword = GlobalKey<FormState>();

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
          title: const Text('The Village - Forgot Password'),
          elevation: 100,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction, //check for validation while typing
              key: keyFormForgotPassword,
              child: Column(children: [
                //welcome
                Text('Forgot the key to The Village :)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: (scaleText * 20.0),
                    )),
                SizedBox(
                  height: 10 * verticalFactor,
                ),
                //email:
                TextFormField(
                    key: keyEmailForgotPassword,
                    initialValue: widget.email,
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

                SizedBox(
                  height: 60,
                  width: 250,
                  child: ElevatedButton.icon(
                    key: const Key('KeyResetPasswordButton'),
                    icon: const Icon(
                      Icons.login_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    label: Text('Login', style: TextStyle(fontSize: 20 * scaleText)),
                    style: ElevatedButton.styleFrom(elevation: 20, shape: const StadiumBorder()),
                    onPressed: () {
                      if (keyEmailForgotPassword.currentState!.validate()) {
                        if (kDebugMode) {
                          print("Debug: Validated -> Navigator.pop()");
                        }
                        // back to prev screen:
                        Navigator.pop(context);
                      } else {
                        if (kDebugMode) {
                          print("Debug: Not Validated: stay");
                        }
                      }
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
