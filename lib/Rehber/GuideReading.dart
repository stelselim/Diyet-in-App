import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GuideReadingPage extends StatefulWidget {
  final DocumentSnapshot data;
  GuideReadingPage({Key key, @required this.data}) : super(key: key);

  @override
  _GuideReadingPageState createState() => _GuideReadingPageState();
}

class _GuideReadingPageState extends State<GuideReadingPage> {
  double _fontBoyutu = 15;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        //  color:Colors.green.shade300,
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.25), BlendMode.dstATop),
                // Arka Plan Resmi
                image: new AssetImage(
                  "assets/images/apples.jpg",
                ),
                fit: BoxFit.cover)),
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            AppBar(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black87),
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.text_fields),
                  iconSize: 40,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Font Boyutu"),
                            actions: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Row(
                                  children: <Widget>[
                                    Text("Küçült"),
                                    IconButton(
                                      icon: Icon(FontAwesomeIcons.minus),
                                      onPressed: () {
                                        if (_fontBoyutu > 14) {
                                          setState(() {
                                            _fontBoyutu = _fontBoyutu - 1;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Row(
                                  children: <Widget>[
                                    Text("Büyüt"),
                                    IconButton(
                                      icon: Icon(FontAwesomeIcons.plus),
                                      onPressed: () {
                                        if (_fontBoyutu < 25) {
                                          setState(() {
                                            _fontBoyutu = _fontBoyutu + 1;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: Column(
                  children: <Widget>[
                    //Üst Yazı
                    ListTile(
                      // Başlık
                      title: Text(
                        "${widget.data.data["Başlık"]}",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
                    ),
                    // Başlık

                    SizedBox(
                      height: 20,
                    ),
                    
                    // İçerik Yazısı ve Kaynaklar son satırda ayrıca
                    Text("\t${widget.data.data["Yazı"]}",
                        style: TextStyle(
                            fontSize: _fontBoyutu,
                            height: 1.5),
                        textScaleFactor: 1.25),
                        SizedBox(
                          height: 20,
                        ),

                    Text(
                      "${widget.data.data["Kaynak"]}",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          height: 1.5),
                      textScaleFactor: 1.25,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }
}
