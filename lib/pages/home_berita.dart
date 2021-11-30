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
  List<listResponse.Result> listNews = [];

  Future<List<listResponse.Result>> _getListNews() async {
    // panggil method dari class Api
    return Api.getListBerita().then((value) {
      setState(() {
        // inisialisasi nilai pada variabel result dengan hasil response
        listNews = value.result!;
      });
      return listNews;
    }).catchError((msgError) {
      print(msgError);
    });
  }

  // function yang diekseskusi sebelum function build
  @override
  void initState() {
    _getListNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Berita"),
      ),
      body: FutureBuilder(
        future: _getListNews(),
        builder: (context, snapshot) {
          // jika snapshot mempunyai data
          if (snapshot.hasData) {
            return showList();
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

  Widget showList() {
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
            itemCount: listNews.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailBerita(
                          id: listNews[index].idBerita!,
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
                            Api.IMAGE_URL + listNews[index].gambar!),
                      ),
                      title: Text(
                        listNews[index].judul!,
                        style: titleBold(),
                      ),
                      description: Container(),
                      subTitle: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              listNews[index].tanggal!,
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
