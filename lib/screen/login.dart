import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/http/httpuser.dart';
import 'package:motion_toast/motion_toast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  String username = "";
  String password = "";
 
  Future<bool> loginPost(String username, String password) {
    var res = HttpConnectUser().loginPosts(username, password);
    return res;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form( 
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.PYipJ_hSncugM2SwnZitvgHaEK%26pid%3DApi&f=1"),
                radius: 80,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                onSaved: (value) => username = value!,
                validator:
                    MultiValidator([RequiredValidator(errorText: "*Required")]),
                style: const TextStyle(
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Username",
                    hintText: 'Enter your username',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                onSaved: (value) => password = value!,
                validator: MultiValidator([
                  MaxLengthValidator(15,
                      errorText: "should be less than 15 characters "),
                  MinLengthValidator(6,
                      errorText: "should be lat least 6 characters "),
                  RequiredValidator(errorText: "*Required")
                ]),
                style: const TextStyle(
                  fontSize: 20,
                ),
                obscureText: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Password",
                    hintText: 'Enter your password',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50)),
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();

                    var res = await loginPost(username, password);
                    if (res) {
                      _formkey.currentState!.reset();
                      Navigator.pushNamed(context, '/addstudent');
                      MotionToast.success(
                              description: const Text('Login Successfull'))
                          .show(context);
                    } else {
                      MotionToast.error(
                              description: const Text('Login UnSuccessfull'))
                          .show(context);
                    }
                  }
                },
                child: const Text("Login"),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text("Register"),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
