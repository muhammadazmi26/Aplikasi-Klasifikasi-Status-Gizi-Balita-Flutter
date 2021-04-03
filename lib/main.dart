import 'package:flutter/material.dart';
import 'package:halo_dunia/post_result_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
// ignore: avoid_init_to_null
  PostResult postResult = null;

  TextEditingController controllerNama = TextEditingController(); // nama
  TextEditingController controllerBB = TextEditingController(); // berat badan
  TextEditingController controllerTB = TextEditingController(); // tinggi badan

  String _valJK = "L"; // default
  List _listJK = ["L", "P"]; // pilihan jenis kelamin

  bool visibility_hasil = null;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Fllutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Klasifikasi Status Gizi Balita'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              // child:
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey, 
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 2,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[

                        // Texview "Data testing"
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 3, 8, 15),
                          child: Text(
                            'Data Testing',
                            style: TextStyle(
                                color: Color.fromARGB(255, 34, 150, 243),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "arial",
                                height: 1.5),
                          ),
                        ),


                        // Input Nama Balita
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Nama Balita"),
                            textAlign: TextAlign.center,
                            controller: controllerNama,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Nama balita tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                        ),
                        

                        // Pilih Jenis Kelamin
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Row(children: <Widget>[

                              Text("Jenis Kelamin :  "),

                              DropdownButton(
                                // hint: Text("Pilehh"),
                                value: _valJK,
                                items: _listJK.map((value) {
                                  return DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _valJK = value; //Untuk memberitahu _valJK bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                                  });
                                },
                              ),

                            ]),
                        ),

                                          
                         // Input Berat Badan
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Berat Badan (Kg)"),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: controllerBB,
                            validator: (value) {
                              var value_dobel = double.parse(value);
                              assert(value_dobel is double);
                              print(value_dobel); // 12345
                              if (value_dobel < 2.4 || value_dobel > 24) {
                                return 'input berat badan harus (2.5 - 24 kg)';
                              }
                              return null;
                            },
                          ),
                        ),


                        // Input Tinggi Badan
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            // TINGGI BADAN
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Tinggi Badan (cm)"),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: controllerTB,
                            validator: (value) {
                              var value_dobel = double.parse(value);
                              print(value_dobel); // 12345
                              if (value_dobel < 45 || value_dobel > 115) {
                                return 'input tinggi badan harus (45 - 115 cm)';
                              }
                              return null;
                            },
                          ),
                        ),

                        // Button Proses
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Color.fromARGB(255, 34, 150, 243), // background
                            textColor: Colors.white, // foreground
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                //event /Future/void
                                print("TRUE GAISSS");

                                PostResult.konekToAPI(
                                        controllerNama.text.toString(),
                                        // controllerJK.text.toString(),
                                        _valJK.toString(), // value jenis kelamin
                                        controllerBB.text.toString(),
                                        controllerTB.text.toString())
                                    .then((nilai) {
                                  postResult = nilai;
                                  visibility_hasil = true;
                                  FocusScope.of(context).unfocus();
                                  setState(() {});
                                });
                              }
                            },
                            child: Text("Proses"),
                          ), 
                        ),


                      ]),
                    ),
                  ),
                ),
              ),

              
              // Hasil Klasifikasi
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Container(
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        
                    if (visibility_hasil == true) // jika kondisi true maka card hasil akan muncul
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 3, 80, 0),
                        child: Text(
                          'Hasil Klasifikasi',
                          style: TextStyle(
                              color: Color.fromARGB(255, 34, 150, 243),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "arial",
                              height: 1.5),
                        ),
                      ),

                    if (visibility_hasil == true) // jika kondisi true maka card hasil akan muncul
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          (postResult != null) ? postResult.data : "-", // (kondisi) ? jika True : jika False
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                  ]),
                ),
              )


            ]),
          ),
        ),
      ),
    );
  }
}
