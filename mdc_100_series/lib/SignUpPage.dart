import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shrine/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String password = '';
  String confirmPassword = '';

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
        body: SafeArea(
            child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            const SizedBox(height: 30.0),
            TextFormField(
              key: const ValueKey(1),
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 4) {
                  return 'Username is invalid';
                }
                return null;
              },
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              key: const ValueKey(2),
              onSaved: (value) {
                password = value!;
              },
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              key: const ValueKey(3),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    password != confirmPassword) {
                  return 'Confirm Password doesn\'t match Password';
                }
                return null;
              },
              onSaved: (value) {
                confirmPassword = value!;
              },
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Confirm Password',
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              key: const ValueKey(4),
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Please enter Email Address';
                }
                return null;
              },
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Email Address',
              ),
              obscureText: true,
            ),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 199, 198, 198)),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child:
                        Text('SIGN UP', style: TextStyle(color: Colors.black)),
                  ),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    }
                  },
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
