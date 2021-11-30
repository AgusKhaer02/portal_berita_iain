/// result : {"id_berita":"1","judul":"WORKSHOP Entrepreuner Bersama Bpk Suryadin Laoddang Dosen Jualan","gambar":"WORKSHOP_Entrepreuner_Bersama_Bpk_Suryadin_Laoddang_Dosen_Jualan-1637027204.png","isi_berita":"WORKSHOP Entrepreuner bersama Bpk. Suryadin Laoddang | Dosen Jualan Pembicara Internet Marketing Nasional dengan tema :  \"Peluang dan Tantangan Membangun Bisnis Dimasa Pandemi COVID19\". Adapun pembiacara lainnya  yaitu Bpk. Hardiansah, S.Kom., M.Kom. (Direktur PT. Lauwba Techno Indonesia & CEO LKP UNIKOM Yogyakarta ) dan Bpk. Ardilla Sahi P. (CEO Full Bright Institute) beliau salah seorang pengusaha muda sukses yang saat ini tetap eksis walau WABAH Covid19 masih terus melanda negeri kita. Workshop ini dilaksanakan secara GRATIS. Silahkan Langsung Klik DAFTAR sebelum kuota FULL.","tanggal":"2021-09-06 02:46:44"}
/// message : "Data ada"
/// status_code : 200

class DetailBeritaReponse {
  Result? _result;
  String? _message;
  int? _statusCode;

  Result? get result => _result;
  String? get message => _message;
  int? get statusCode => _statusCode;

  DetailBeritaReponse({
      Result? result, 
      String? message, 
      int? statusCode}){
    _result = result;
    _message = message;
    _statusCode = statusCode;
}

  DetailBeritaReponse.fromJson(dynamic json) {
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
    _message = json['message'];
    _statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    map['message'] = _message;
    map['status_code'] = _statusCode;
    return map;
  }

}

/// id_berita : "1"
/// judul : "WORKSHOP Entrepreuner Bersama Bpk Suryadin Laoddang Dosen Jualan"
/// gambar : "WORKSHOP_Entrepreuner_Bersama_Bpk_Suryadin_Laoddang_Dosen_Jualan-1637027204.png"
/// isi_berita : "WORKSHOP Entrepreuner bersama Bpk. Suryadin Laoddang | Dosen Jualan Pembicara Internet Marketing Nasional dengan tema :  \"Peluang dan Tantangan Membangun Bisnis Dimasa Pandemi COVID19\". Adapun pembiacara lainnya  yaitu Bpk. Hardiansah, S.Kom., M.Kom. (Direktur PT. Lauwba Techno Indonesia & CEO LKP UNIKOM Yogyakarta ) dan Bpk. Ardilla Sahi P. (CEO Full Bright Institute) beliau salah seorang pengusaha muda sukses yang saat ini tetap eksis walau WABAH Covid19 masih terus melanda negeri kita. Workshop ini dilaksanakan secara GRATIS. Silahkan Langsung Klik DAFTAR sebelum kuota FULL."
/// tanggal : "2021-09-06 02:46:44"

class Result {
  String? _idBerita;
  String? _judul;
  String? _gambar;
  String? _isiBerita;
  String? _tanggal;

  String? get idBerita => _idBerita;
  String? get judul => _judul;
  String? get gambar => _gambar;
  String? get isiBerita => _isiBerita;
  String? get tanggal => _tanggal;

  Result({
      String? idBerita, 
      String? judul, 
      String? gambar, 
      String? isiBerita, 
      String? tanggal}){
    _idBerita = idBerita;
    _judul = judul;
    _gambar = gambar;
    _isiBerita = isiBerita;
    _tanggal = tanggal;
}

  Result.fromJson(dynamic json) {
    _idBerita = json['id_berita'];
    _judul = json['judul'];
    _gambar = json['gambar'];
    _isiBerita = json['isi_berita'];
    _tanggal = json['tanggal'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id_berita'] = _idBerita;
    map['judul'] = _judul;
    map['gambar'] = _gambar;
    map['isi_berita'] = _isiBerita;
    map['tanggal'] = _tanggal;
    return map;
  }

}