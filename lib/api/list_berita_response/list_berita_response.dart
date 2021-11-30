/// result : [{"id_berita":"3","judul":"Heboh Billboard Raditya Dika Minta Maaf, Ada Apa?","gambar":"HebohBillboardRadityaDikaMintaMaafAdaApa-1637119210.png","tanggal":"2021-11-17"},{"id_berita":"2","judul":"Adu Desain All New Avanza dan Xpander Facelift, Pilih Mana?","gambar":"Adu_Desain_All_New_Avanza_dan_Xpander_Facelift,_Pilih_Mana?-1637044731.png","tanggal":"2021-11-16"},{"id_berita":"1","judul":"WORKSHOP Entrepreuner Bersama Bpk Suryadin Laoddang Dosen Jualan","gambar":"WORKSHOP_Entrepreuner_Bersama_Bpk_Suryadin_Laoddang_Dosen_Jualan-1637027204.png","tanggal":"2021-09-06"}]
/// message : "Data ada"
/// status_code : 200

class ListBeritaResponse {
  List<Result>? _result;
  String? _message;
  int? _statusCode;

  List<Result>? get result => _result;
  String? get message => _message;
  int? get statusCode => _statusCode;

  ListBeritaResponse({
      List<Result>? result, 
      String? message, 
      int? statusCode}){
    _result = result;
    _message = message;
    _statusCode = statusCode;
}

  ListBeritaResponse.fromJson(dynamic json) {
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
    _message = json['message'];
    _statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    map['status_code'] = _statusCode;
    return map;
  }

}

/// id_berita : "3"
/// judul : "Heboh Billboard Raditya Dika Minta Maaf, Ada Apa?"
/// gambar : "HebohBillboardRadityaDikaMintaMaafAdaApa-1637119210.png"
/// tanggal : "2021-11-17"

class Result {
  String? _idBerita;
  String? _judul;
  String? _gambar;
  String? _tanggal;

  String? get idBerita => _idBerita;
  String? get judul => _judul;
  String? get gambar => _gambar;
  String? get tanggal => _tanggal;

  Result({
      String? idBerita, 
      String? judul, 
      String? gambar, 
      String? tanggal}){
    _idBerita = idBerita;
    _judul = judul;
    _gambar = gambar;
    _tanggal = tanggal;
}

  Result.fromJson(dynamic json) {
    _idBerita = json['id_berita'];
    _judul = json['judul'];
    _gambar = json['gambar'];
    _tanggal = json['tanggal'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id_berita'] = _idBerita;
    map['judul'] = _judul;
    map['gambar'] = _gambar;
    map['tanggal'] = _tanggal;
    return map;
  }

}