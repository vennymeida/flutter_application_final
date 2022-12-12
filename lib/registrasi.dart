import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_final/login.dart';
import 'package:flutter_application_final/service/global.dart';
import 'package:flutter_application_final/service/loginservice.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  String _name = '';
  String _email = '';
  String _password = '';

  registerPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.Response response =
          await AuthServices.register(_name, _email, _password);
      Map responseMap = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const Login(),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Register Page"),
          backgroundColor: const Color(0xFF0000ff),
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
                flex: 2,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        hintText: 'Enter Nama',
                        prefixIcon: new Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: ((value) {
                        _name = value;
                      }),
                      // validator: ((value) {
                      //   return value!.isEmpty ? 'Please Enter Nama' : null;
                      // }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter Email',
                        prefixIcon: new Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: ((value) {
                        _email = value;
                      }),
                      // validator: ((value) {

                      // }),
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
                      onChanged: ((value) {
                        _password = value;
                      }),
                      // validator: ((value) {
                      //   return value!.isEmpty ? 'Please Enter Password' : null;
                      // }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          registerPressed();
                        },
                        child: const Text('Register'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Login();
                            }),
                          );
                        },
                        child: const Text('Login'),
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
