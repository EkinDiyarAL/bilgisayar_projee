import 'package:bilgisayar_proje/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'listeleme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController markaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CollectionReference urunlerRef = _firestore.collection('urunler');
    var islemciRef = _firestore.collection('urunler').doc('islemci');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Ana Sayfa')),
      body: Center(
        child: Container(
          child: Column(
            children: [
              /* ElevatedButton(
                child: Text('get QUERYSNAPSHOT'),
                onPressed: () async {
                  var response = await urunlerRef.get();
                  var list = response.docs;
                  print(list[1].data());
                },
              ),*/
              /*  StreamBuilder<QuerySnapshot>(
                stream: urunlerRef.snapshots(),
                builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    return Center(
                        child: Text('Bir hata oluştu tekrar deneyiniz'));
                  } else {
                    if (asyncSnapshot.hasData) {
                      List<DocumentSnapshot> listofDocumentSnap =
                          asyncSnapshot.data.docs;
                      return Flexible(
                        child: ListView.builder(
                          itemCount: listofDocumentSnap.length,
                          itemBuilder: (context, index) {
                            var veri = listofDocumentSnap.data() as Map<String, dynamic>;
                                
                            return Card(
                              child: ListTile(
                                title: Text(
                                    '${listofDocumentSnap.![index].veri()["name"]}',
                                    style: TextStyle(fontSize: 20)),
                                subtitle: Text(
                                    '${listofDocumentSnap[index].data()!['marka']}',
                                    style: TextStyle(fontSize: 16)),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                },
              ),*/
              Form(
                child: Column(children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: 'Bilgisayar Parça Adını Girin'),
                  ),
                  TextFormField(
                    controller: markaController,
                    decoration: InputDecoration(hintText: 'Marka Adını Girin'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        elevation: 5.0,
                        height: 40,
                        onPressed: () {
                          CircularProgressIndicator();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StreamBuilderExample(),
                            ),
                          );
                        },
                        child: Text(
                          "Ürünler",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        elevation: 5.0,
                        height: 40,
                        onPressed: () {
                          CircularProgressIndicator();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Çıkış",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Ekle'),
        onPressed: () async {
          print(nameController.text);
          print(markaController.text);

          Map<String, dynamic> bilgisayarData = {
            'name': nameController.text,
            'marka': markaController.text
          };

          await urunlerRef.doc(nameController.text).set(bilgisayarData);
        },
      ),
    );
  }
}
