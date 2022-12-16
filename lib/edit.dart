import 'package:flutter/material.dart';
import 'package:flutter_application_final/registrasi.dart';
import 'package:flutter_application_final/service/loginservice.dart';
import 'package:flutter_application_final/service/global.dart';
import 'package:flutter_application_final/list.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  const EditPage({super.key});
  @override
  State<EditPage> createState() => _EditPage();
}

class _EditPage extends State<EditPage> {
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
            title: const Text('Edit Page'),
          ),
          body: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Masukkan Kategori',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Edit'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return List();
                        }),
                      );
                    },
                    child: const Text('Kembali'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
