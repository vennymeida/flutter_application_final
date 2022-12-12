import 'package:flutter/material.dart';
import 'package:flutter_application_final/registrasi.dart';
import 'package:flutter_application_final/service/loginservice.dart';
import 'package:flutter_application_final/service/global.dart';
import 'package:flutter_application_final/list.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  @override
  String _email = '';
  String _password = '';

  loginPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_email, _password);
      Map responseMap = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const List(),
          ),
          (route) => false,
        );
      } else {
        errorSnackBar(context, 'wrong email or password');
      }
    } else {
      errorSnackBar(context, 'enter all required fields');
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Login Page'),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Expanded(
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 70.0,
                    backgroundImage: NetworkImage(
                        'https://bantennet.com/wp-content/uploads/2022/05/flowers-gd7a30a6b3_1280.jpg')),
              ),
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter Email',
                        prefixIcon: new Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      // onChanged: (String value) {},
                      onChanged: ((value) {
                        _email = value;
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                      // onChanged: (String value) {},
                      onChanged: ((value) {
                        _password = value;
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: loginPressed,
                        child: const Text('Login'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Register();
                            }),
                          );
                        },
                        child: const Text('Register'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
