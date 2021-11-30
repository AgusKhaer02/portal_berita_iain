import 'package:flutter/material.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:getflutter/components/appbar/gf_appbar.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/components/button/gf_button_bar.dart';
import 'package:getflutter/components/button/gf_icon_button.dart';
import 'package:getflutter/components/card/gf_card.dart';
import 'package:getflutter/components/list_tile/gf_list_tile.dart';
import 'package:getflutter/components/typography/gf_typography.dart';
import 'package:getflutter/position/gf_position.dart';
import 'package:getflutter/shape/gf_icon_button_shape.dart';
import 'package:portal_berita/api/api.dart';
import 'package:portal_berita/styles/style.dart';
import 'package:portal_berita/api/detail_berita_response/detail_berita_reponse.dart' as detailResponse;

class DetailBerita extends StatefulWidget {
  final String id;

  const DetailBerita({Key? key, required this.id}) : super(key: key);

  @override
  _DetailBeritaState createState() => _DetailBeritaState();
}

class _DetailBeritaState extends State<DetailBerita> {
  detailResponse.Result? detailNews;

  Future<detailResponse.Result> _getDetailNews(String id) async {
    // panggil method dari class Api
    return Api.getDetailBerita(id).then((value) {
      setState(() {
        // inisialisasi nilai pada variabel result dengan hasil response
        detailNews = value.result!;
      });
      return detailNews!;
    }).catchError((msgError) {
      print(msgError);
    });
  }

  @override
  void initState() {
    _getDetailNews(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Berita"),
      ),
      body: FutureBuilder(
        future: _getDetailNews(widget.id),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return showDetail(context);
          }else if(snapshot.hasError){
            return Center(
              child: Text("Get detail berita error"),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );

        },
      ),
    );
  }

  Widget showDetail(BuildContext context) {
    return ListView(
      children: <Widget>[
        GFCard(
          boxFit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.67),
            BlendMode.darken,
          ),
          image: Image.network(
            Api.IMAGE_URL + detailNews!.gambar!,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
            height: 185.0,
            // height: 400.0,
          ),
//              imageOverlay: AssetImage("lib/assets/food.jpeg"),
          titlePosition: GFPosition.end,
          title: GFListTile(
            // avatar: GFAvatar(
            //   backgroundImage: AssetImage('lib/assets/images/three4.png'),
            // ),
              title: Column(
                children: <Widget>[
                  Text(
                    detailNews!.judul!,
                    textAlign: TextAlign.center,
                    style: comments(),
                  ),
                  Text(
                    detailNews!.tanggal!,
                    style: descriptionSemibold(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  )
                ],
              )),
          content: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              detailNews!.isiBerita!,
              style: newsdetails(),
            ),
          ),
          buttonBar: GFButtonBar(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GFIconButton(
                    color: Colors.white,
                    shape: GFIconButtonShape.circle,
                    icon: Image.asset('lib/assets/icons/share.png'),
                    onPressed: () {}),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: GFIconButton(
                    color: const Color(0xFF3B5998),
                    shape: GFIconButtonShape.circle,
                    icon: const Icon(
                      IconData(
                        0xe904,
                        fontFamily: 'icomoon',
                      ),
                      color: GFColors.WHITE,
                    ),
                    onPressed: () {}),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: GFIconButton(
                    color: const Color(0xFF00ACEE),
                    shape: GFIconButtonShape.circle,
                    icon: const Icon(
                      IconData(
                        0xe90f,
                        fontFamily: 'icomoon',
                      ),
                      color: GFColors.WHITE,
                    ),
                    onPressed: () {}),
              ),
              GFIconButton(
                  color: const Color(0xFF25D366),
                  shape: GFIconButtonShape.circle,
                  icon: const Icon(
                    IconData(
                      0xe911,
                      fontFamily: 'icomoon',
                    ),
                    color: GFColors.WHITE,
                  ),
                  onPressed: () {}),
            ],
          ),
        ),
        // Row(
        //   children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 17.0, top: 10.0, bottom: 5.0),
          child: GFTypography(
            // color: Colors.blue,
            showDivider: false,
            child: Text('Comments', style: comments()),
          ),
        ),
        // GFCard(
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GFListTile(
            avatar: const GFAvatar(
              backgroundImage: AssetImage('lib/assets/images/news1.png'),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                'Fidel Castro',
                style: titleBold(),
              ),
            ),
            description: Container(),
            subTitle: Text(
              'Vamos!!!',
              style: descriptionSemibold(),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                '21/1/2020',
                style: descriptionSemibold(),
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
        Divider(
          color: Colors.grey,
        )
        // ),
        //   ],
        // )
      ],
    );
  }
}
