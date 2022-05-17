import 'package:flutter/material.dart';

import 'decoration_functions.dart';
import 'sign_in_up_bar.dart';
import 'title.dart';

class Register extends StatelessWidget {
  const Register({Key key, this.onSignInPressed}) : super(key: key);

  final VoidCallback onSignInPressed;

  @override
  Widget build(BuildContext context) {
    //final isSubmitting = context.isSubmitting();
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: LoginTitle(
                  title: 'Create\nAccount',
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        decoration: registerInputDecoration(hintText: 'Email')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      decoration: registerInputDecoration(hintText: 'Password'),
                    ),
                  ),
                  SignUpBar(
                    label: 'Sign up',
                    isLoading: false,
                    onPressed: () {
                      //context.registerWithEmailAndPassword();
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        onSignInPressed?.call();
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
