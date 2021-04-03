import 'dart:convert';

import 'package:http/http.dart' as http;

class PostResult {
  int kode; // tipe data harus sesuai respon API, apabila isi json string maka tipeData String, apabila isi json integer maka tipeData int. Kalo nggak gitu gak bakal jalan hasil API di Apps.
  String data;

  PostResult({this.kode, this.data});

  factory PostResult.createPostResult(Map<String, dynamic> object) {
    return PostResult(kode: object['kode'], data: object['data']);
  }

  static Future<PostResult> konekToAPI(String nama, String jk, String berat, String tinggi) async {
    // String apiUrl = "http://192.168.42.33/balita/nb_android.php";
    String apiUrlOnline = "http://balita.mywebcommunity.org/nb_android.php";

    var apiResult = await http.post(apiUrlOnline,
        body: {"nama": nama, "jk": jk, "berat": berat, "tinggi": tinggi});

    var jsonObject = json.decode(apiResult.body);

    return PostResult.createPostResult(jsonObject);
  }
}
