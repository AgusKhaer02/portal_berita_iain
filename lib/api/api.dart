import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:portal_berita/api/detail_berita_response/detail_berita_reponse.dart';
import 'package:portal_berita/api/list_berita_response/list_berita_response.dart';

const BASE_URL = "http://192.168.18.157/web_portal_berita/index.php/Api/";
class Api{
  static const IMAGE_URL = "http://192.168.18.157/web_portal_berita/image/";
  // menggunakan future
  static Future<ListBeritaResponse> getListBerita()async{
    // asynchronous / synchronous
    // gabung string dengan baseurl, setelahnya baseurl adalah endpoint
    var url = BASE_URL + "getListBerita";
    // hasil response nanti akan di masukan dalam variabel response
    // request ke webservice dengan menggunakan method get
    final response = await http.get(Uri.parse(url));

    // cek apakah status code pada webservice adalah 200
    // 200 = ok
    if(response.statusCode == 200){
      // return hasil unpackaging pada response jsonnya
      // response json di convert dalam bentuk array dart
      return ListBeritaResponse.fromJson(jsonDecode(response.body));
    }else{
      // lempar exception
      throw "Failed to get list news";
    }
  }

  static Future<DetailBeritaReponse> getDetailBerita(String id)async{
    var url = BASE_URL + "getDetailBerita/$id";
    // hasil response nanti akan di masukan dalam variabel response
    // request ke webservice dengan menggunakan method get
    final response = await http.get(Uri.parse(url));

    // cek apakah status code pada webservice adalah 200
    // 200 = ok
    if(response.statusCode == 200){
      // return hasil unpackaging pada response jsonnya
      // response json di convert dalam bentuk array dart
      return DetailBeritaReponse.fromJson(jsonDecode(response.body));
    }else{
      // lempar exception
      throw "Failed to get detail news";
    }
  }


}