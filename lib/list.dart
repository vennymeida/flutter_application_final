import 'package:flutter/material.dart';
import 'package:flutter_application_final/edit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_final/service/loginservice.dart';
import 'package:flutter_application_final/login.dart';
import 'dart:convert';

class List extends StatefulWidget {
  const List({super.key});

  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  @override
  logoutPressed() async {
    http.Response response = await AuthServices.logout();

    if (response.statusCode == 204) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const Login(),
        ),
        (route) => false,
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const List(),
          ));
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ListView',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text('ListView'),
          ),
          body: Container(
            child: Column(children: [
              Text('List Kategori'),
              Row(
                children: [
                  Expanded(
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
                      child: const Text('Add'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: logoutPressed,
                  child: const Text('Logout'),
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.favorite, color: Colors.white),
                            Text('Edit', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const <Widget>[
                            Icon(Icons.delete, color: Colors.white),
                            Text('Hapus',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    onDismissed: (DismissDirection direction) {
                      if (direction == DismissDirection.startToEnd) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditPage()),
                        );
                      } else {}
                    },
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('data'),
                        )
                      ],
                    ),
                  )
                ],
              ))
            ]),
          ),
        ));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class MyListView extends StatelessWidget {
  const MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(20.0),
      child: new Center(
        child: new Column(
          children: <Widget>[
            new Image(
                image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM8iiF75ThILLJrv00dUwloLDx34isk8A1Ww&usqp=CAU"),
                width: 200),
            new Text(
              "Flutter",
              style: new TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
