import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';
import '/http/httpuser.dart';
import '/model/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _regform = GlobalKey<FormState>();
  String fname = '';
  String lname = '';
  String username = '';
  String password = '';
 
  Future<bool> registerUser(User u) {
    var res = HttpConnectUser().registerPost(u);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: Form(
          key: _regform,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView( 
              children: [
                const SizedBox(
                  height: 120,
                ),
                TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'First name is required'),
                    MinLengthValidator(3, errorText: 'First name must be at least 3 characters'),
                  ]),
                  onSaved: (value) {
                    fname = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Firstname',
                    hintText: 'Enter your first name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                    validator: MultiValidator([
                    RequiredValidator(errorText: 'Last name is required'),
                    MinLengthValidator(3, errorText: 'Last name must be at least 3 characters'),
                  ]),
                  onSaved: (value) {
                    lname = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Lastname',
                    hintText: 'Enter your last name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Username is required'),
                    MinLengthValidator(5, errorText: 'Username must be at least 5 characters'),
                  ]),
                  onSaved: (value) {
                    username = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                 validator: MultiValidator([
                    RequiredValidator(errorText: 'Password is required'),
                    MinLengthValidator(6, errorText: 'Password must be at least 5 characters'),
                  ]),
                  onSaved: (value) {
                    password = value!;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    if (_regform.currentState!.validate()) {
                      _regform.currentState!.save();
                      User u = User(
                          firstname: fname,
                          lastname: lname,
                          username: username,
                          password: password); 
                       
                      bool isCreated = await registerUser(u);

                      if (isCreated) {
                        _regform.currentState!.reset();
                        Navigator.pushNamed(context, '/');
                        MotionToast.success(
                                description:const Text('New user created'))
                            .show(context);
                      } else {
                        MotionToast.error(
                                description: const Text('Failed to create user'))
                            .show(context);
                      }
                    }
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
