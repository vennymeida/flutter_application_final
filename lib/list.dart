import 'package:flutter/material.dart';
import 'package:flutter_application_final/edit.dart';
import 'package:flutter_application_final/service/global.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_final/service/loginservice.dart';
import 'package:flutter_application_final/login.dart';
import 'dart:convert';
import 'model/category_model.dart';
import 'service/crud_helper.dart';

class ListKategori extends StatefulWidget {
  // const ListKategori({super.key});
  const ListKategori({
    super.key,
  });

  @override
  State<ListKategori> createState() => _ListKategoriState();
}

class _ListKategoriState extends State<ListKategori> {
  List listCategory = [];
  String name = '';

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
            builder: (BuildContext context) => const ListKategori(),
          ));
    }
  }

  doAddCategory() async {
    final name = txtAddCategory.text;
    final response = await CRUD().addCategory(name);
    print(response.body);
    // Navigator.pushNamed(context, "/main");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListKategori()),
    );
  }

  addMoreData() {
    CrudHelper.getCategories(currentPage.toString()).then((resultList) {
      setState(() {
        categories.addAll(resultList[0]);
        lastPage = resultList[1];
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // getKategori();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (currentPage < lastPage) {
          setState(() {
            isLoading = true;
            currentPage++;
            addMoreData();
          });
        }
      }
    });

    fetchData();
  }

  List<String> user = [];
  List<Category> categories = [];
  int selectedIndex = 0;
  int currentPage = 1;
  int lastPage = 0;
  bool isLoading = true;
  final ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  // getKategori() async {
  //   final response = await AuthServices().getKategori();
  //   var dataResponse = jsonDecode(response.body);
  //   setState(() {
  //     var listRespon = dataResponse['data'];
  //     for (var i = 0; i < listRespon.length; i++) {
  //       listCategory.add(Category.fromJson(listRespon[i]));
  //     }
  //   });
  // }
  fetchData() {
    CrudHelper.getCategories(currentPage.toString()).then((resultList) {
      setState(() {
        categories = resultList[0];
        lastPage = resultList[1];
        isLoading = false;
      });
    });
  }

  final TextEditingController txtAddCategory = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ListView',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightGreen,
              title: Text('ListView'),
            ),
            body: Container(
                margin: EdgeInsets.all(20),
                child: Column(children: [
                  Text(
                    'List Kategori',
                    style: TextStyle(fontSize: 30),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: txtAddCategory,
                          decoration: InputDecoration(
                            labelText: 'Masukkan Kategori',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            doAddCategory();
                          },
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
                    child: ListView.builder(
                        // itemCount: listCategory.length,
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          // var kategori = listCategory[index];
                          return Dismissible(
                              key: UniqueKey(),
                              background: Container(
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    children: const <Widget>[
                                      Icon(Icons.favorite, color: Colors.white),
                                      Text('Edit',
                                          style:
                                              TextStyle(color: Colors.white)),
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
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                              // onDismissed: (DismissDirection direction) {
                              onDismissed: (DismissDirection direction) async {
                                if (direction == DismissDirection.startToEnd) {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         // builder: (context) => const EditPage()),
                                  //         builder: (context) => EditPage(
                                  //               category: categories[index],
                                  //             )),
                                  //   );
                                  // } else {}
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return EditPage(
                                            category: categories[index]);
                                      });
                                } else {
                                  final response = await CrudHelper()
                                      .deleteCategori(categories[index]);
                                  print(response.body);
                                  // Navigator.pushNamed(context, "/main");
                                }
                              },
                              // child: ListTile(
                              //     title: Text(
                              //   kategori.name,
                              //   style: const TextStyle(
                              //       fontFamily: 'Nunito',
                              //       fontWeight: FontWeight.bold),
                              //   textAlign: TextAlign.center,
                              // )));
                              child: Container(
                                height: 100,
                                child: ListTile(
                                    title: Text(
                                  categories[index].name,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )),
                              ));
                        }),
                  ),
                ]))));
  }
}

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }

// class MyListView extends StatelessWidget {
//   const MyListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       padding: new EdgeInsets.all(20.0),
//       child: new Center(
//         child: new Column(
//           children: <Widget>[
//             new Image(
//                 image: NetworkImage(
//                     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM8iiF75ThILLJrv00dUwloLDx34isk8A1Ww&usqp=CAU"),
//                 width: 200),
//             new Text(
//               "Flutter",
//               style: new TextStyle(fontSize: 20.0),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
