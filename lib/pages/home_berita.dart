import 'package:flutter/material.dart';
import 'package:getflutter/components/image/gf_image_overlay.dart';
import 'package:getflutter/components/list_tile/gf_list_tile.dart';
import 'package:portal_berita/api/api.dart';
import 'package:portal_berita/api/list_berita_response/list_berita_response.dart'
    as listResponse;
import 'package:portal_berita/pages/detail_berita.dart';
import 'package:portal_berita/pages/location_page.dart';
import 'package:portal_berita/pages/pick_image_page.dart';
import 'package:portal_berita/styles/style.dart';

class HomeBerita extends StatefulWidget {
  const HomeBerita({Key? key}) : super(key: key);

  @override
  _HomeBeritaState createState() => _HomeBeritaState();
}

class _HomeBeritaState extends State<HomeBerita> {
  // yang dipanggil pada future builder harus berupa variable
  // inti dari permasalahan kenapa api dipanggil terus karena function getListnews memiliki function future yang bercabang

  // #1 didalam variabel ini berisi method yang langsung dari class Api, ketika function getListBerita sudah tereksekusi maka akan return class response
  // jadi jangan dibuat function future baru lagi di dalam class ini yang mana akan berakibat calling api secara terus menerus
  Future<listResponse.ListBeritaResponse> listNews = Api.getListBerita();

  // tidak menggunakan method ini karna ini akan menjadi API yang di call berkali kali
  // ini yang akan menyebabkan trafic padat pada server, maka solusinya gunakan variabel listNews diatas
  // Future<List<listResponse.Result>> _getListNews() async {
  //   // panggil method dari class Api
  //   return Api.getListBerita().then((value) {
  //     setState(() {
  //       // inisialisasi nilai pada variabel result dengan hasil response
  //       listNews = value.result!;
  //     });
  //     return listNews;
  //   }).catchError((msgError) {
  //     print(msgError);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Berita"),
      ),
      body: FutureBuilder(
        future: listNews,
        builder:
            (context, AsyncSnapshot<listResponse.ListBeritaResponse> snapshot) {
          print("network keeps calling");
          // jika snapshot mempunyai data
          if (snapshot.hasData) {
            // #2
            // untuk datanya jangan langsung dari variabel future tetapi langsung ambil dari snapshot
            // karena datanya sudah jelas ada selama perintah ini didalam kondisi snapshot.hasData yaitu ketika snapshot memiliki data
            // gunakan tanda !, bahwa ketika sudah masuk ke hasData, sudah pasti data sudah ada
            return showList(snapshot.data!.result!);
            //  jika snapshot mengalami error
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Get list news error"),
            );
          }

          // jika tidak keduanya/ sedang proses fetch data
          return Center(
            // loading
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  // #3
  // semua nilai yang dikirim oleh result pada FutureBuilder, itu sudah pasti memiliki nilai kecuali nilai yang ada pada class result
  // entah akan berpotensi null atau tidak.
  Widget showList(List<listResponse.Result> result) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationPage(),
                  ),
                );
              },
              child: Text("get Location"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PIckImagePage(),
                  ),
                );
              },
              child: Text("image handling"),
            ),

          ],
        ),
        Expanded(
          child: ListView.builder(
            // #4 data list yang dipanggil itu bukan lagi berasal dari variable listNews melainkan dari data snapshot yang sudah
            // dikirimkan dari FutureBuilder
            itemCount: result.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailBerita(
                          id: result[index].idBerita!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    // height: 85,
                    // width: 343,
                    // margin: EdgeInsets.all(16.0),
                    // padding: EdgeInsets.only(
                    //   top: 16.0,
                    //   left: 24.0,
                    //   right: 18.0,
                    //   bottom: 12.0,
                    // ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0xFF518CDB).withOpacity(0.13),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: GFListTile(
                      avatar: GFImageOverlay(
                        height: 79,
                        width: 85,
                        image: NetworkImage(
                            // #5
                            Api.IMAGE_URL + result[index].gambar!),
                      ),
                      title: Text(
                        result[index].judul!,
                        style: titleBold(),
                      ),
                      description: Container(),
                      subTitle: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              // #6
                              result[index].tanggal!,
                              style: descriptionSemibold(),
                            ),
                          ),
                        ],
                      ),
                      icon: Container(),

                      // showDivider: false,
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
