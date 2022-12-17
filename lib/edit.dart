import 'package:flutter/material.dart';
import 'package:flutter_application_final/registrasi.dart';
import 'package:flutter_application_final/service/loginservice.dart';
import 'package:flutter_application_final/service/global.dart';
import 'package:flutter_application_final/list.dart';
import 'package:flutter_application_final/service/crud_helper.dart';
import 'dart:convert';
import '../../model/category_model.dart';

import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  // const EditPage({super.key});
  Category category;
  EditPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPage();
}

class _EditPage extends State<EditPage> {
  // TextEditingController? controller;
  final TextEditingController txtEditCategory = TextEditingController();

  @override
  void initState() {
    super.initState();
    txtEditCategory.text = widget.category.name;
  }

  doEditCategory() async {
    final name = txtEditCategory.text;
    final response = await CrudHelper().editCategori(widget.category, name);
    print(response.body);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListKategori()),
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
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
                        controller: txtEditCategory,
                        decoration: InputDecoration(
                          labelText: 'Masukkan Kategori',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          doEditCategory();
                        },
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
                          return ListKategori();
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
