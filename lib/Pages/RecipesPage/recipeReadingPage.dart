import 'package:beslenme/model/app_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecipeReadingPage extends StatefulWidget {
  RecipeReadingPage({Key key}) : super(key: key);

  @override
  _RecipeReadingPageState createState() => _RecipeReadingPageState();
}

class _RecipeReadingPageState extends State<RecipeReadingPage> {
  int _fontBoyutu = 15;

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = TextStyle(
        fontSize: MediaQuery.of(context).textScaleFactor * 25,
        fontWeight: FontWeight.w600,
        height: 1,
        color: Colors.black87);

    final explanationTextStyle = TextStyle(
        fontSize: MediaQuery.of(context).textScaleFactor * _fontBoyutu,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: Colors.black87);

    final headingTitle = TextStyle(
        fontSize: MediaQuery.of(context).textScaleFactor * _fontBoyutu,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: Colors.black87);

    final sourceTextStyle = TextStyle(
        fontSize: MediaQuery.of(context).textScaleFactor * 22,
        height: 1.5,
        fontWeight: FontWeight.w700,
        color: Colors.black87);

    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, store) {
          dynamic makros = store.dataOfRecipeReading["Kalori"];

          var dataOfRecipeReading = store.dataOfRecipeReading;
          String imageURL = dataOfRecipeReading["Resim"];

          return Material(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.rectangle,
              ),
              child: ListView(
                children: <Widget>[
                  // Top Buttons
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Back Icon
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.arrow_back,
                                  size: MediaQuery.of(context).textScaleFactor *
                                      30)),

                          Row(
                            children: <Widget>[
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
                                                    icon: Icon(
                                                        FontAwesomeIcons.minus),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (_fontBoyutu > 15) {
                                                          _fontBoyutu -= 1;
                                                        }
                                                      });
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
                                                    icon: Icon(
                                                        FontAwesomeIcons.plus),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (_fontBoyutu < 25) {
                                                          _fontBoyutu += 1;
                                                        }
                                                      });
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

                              // Add Icon
                              /* GestureDetector(
                            onTap: () {
                              Fluttertoast.showToast(
                                  msg: "Kaydedildi",
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black87);
                            },
                            child: Icon(
                              Icons.add,
                              size: MediaQuery.of(context).textScaleFactor * 30,
                            ),
                          ), */
                            ],
                          ),
                        ],
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),

                  // Image
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        image: DecorationImage(
                          fit: BoxFit.cover,

                          // Tarif Reading Page
                          image: CachedNetworkImageProvider(imageURL),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

                  // Text and Contents
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "${dataOfRecipeReading["Tarifinİsmi"]}",
                          style: titleTextStyle,
                          textScaleFactor: 1.5,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            """Kalori:${makros["Kalori"]} cal
Karbonhidrat:${makros["Karbonhidrat"]} gr 
Protein:${makros["Protein"]} gr 
Yağ:${makros["Yağ"]} gr""",
                            style: explanationTextStyle,
                            textScaleFactor: 1.5,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${dataOfRecipeReading["İçindekiler"]}",
                            style: explanationTextStyle,
                            textScaleFactor: 1.2,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "\t\t${dataOfRecipeReading["Yapılışı"]}",
                          style: headingTitle,
                          textScaleFactor: 1.1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        Text(
                          "${dataOfRecipeReading["YapanKişi"]}",
                          style: sourceTextStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
