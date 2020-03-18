import 'package:beslenme/model/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class BlogReadingPage extends StatefulWidget {
  BlogReadingPage({Key key}) : super(key: key);

  @override
  _BlogReadingPageState createState() => _BlogReadingPageState();
}

class _BlogReadingPageState extends State<BlogReadingPage> {
  double _fontBoyutu = 15;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // REDUX IMPLEMENTATİON
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          state.fontSizeOfReadings = _fontBoyutu.toInt();
          final _dataBlogReading = state.dataOfBlogReading;

          return Material(
            child: Container(
              //  color:Colors.green.shade300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.10), BlendMode.dstATop),
                // Arka Plan Resmi
                image: new AssetImage("assets/images/pineapple.jpeg"),
              )),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),

                  // AppBar
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

                  // Tüm içerik
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Column(
                        children: <Widget>[
                          //Üst Yazı
                          ListTile(
                            subtitle: Text(
                              " ${DateFormat("dd MM yyyy").format(_dataBlogReading["EklenmeTarihi"].toDate())}",
                              textAlign: TextAlign.right,
                            ),

                            // Başlık
                            title: Text(
                              "${_dataBlogReading["Başlık"]}",
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          // Başlık

                          SizedBox(
                            height: 20,
                          ),
                          Text("\t\t${_dataBlogReading["AnaDüşünce"]}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                  fontSize: state.fontSizeOfReadings.toDouble(),
                                  height: 1.5,),
                              textScaleFactor: 1.20,),
                             SizedBox(
                            height: 20,
                          ),
                          // İçerik Yazısı ve Kaynaklar son satırda ayrıca
                          Text("\t\t${_dataBlogReading["BlogYazısı"]}",
                              style: TextStyle(
                                  fontSize: state.fontSizeOfReadings.toDouble(),
                                  height: 1.5),
                              textScaleFactor: 1.25),

                          // Yazar
                          Text(
                            "${_dataBlogReading["Yazar"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                height: 1.5),
                            textScaleFactor: 1.25,
                          ),
                        SizedBox(
                          height: 10,
                        ),
                          Text(
                            "${_dataBlogReading["Kaynaklar"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                height: 1.5),
                            textScaleFactor: 1,
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
        });
  }
}
