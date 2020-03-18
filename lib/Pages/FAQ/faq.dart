import 'package:beslenme/Operations/viewNumber.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_color/random_color.dart';
import './../HomePage/homepage.dart';
import 'dart:core';

class FAQPage extends StatefulWidget {
  FAQPage({Key key}) : super(key: key);

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  ///
  ///Local Variables
  ///
  ///
  var firestoreCont = Firestore.instance;
  var firestoreGet;
  var _category = "Seçilmedi";
  var y = <String, dynamic>{
    "Soru": [{}]
  };

  @override
  void initState() {

    /// initial veri
    setState(() {
      y["Soru"][0] = {
        "Başlık": "Yukarıdan Kategori Seçiniz.",
        "Cevap": "Merak ettiğiniz kategoriyi yukarıdaki menüden seçin!",
        "Kaynak": "Kaynak"
      };
    });
    super.initState();
  }

  

  // Question Card Widgets
  Widget cardFAQ(BuildContext context, int index, String category) {
    RandomColor _color = RandomColor();
    var _randomcolor =
        _color.randomColor(colorBrightness: ColorBrightness.primary);

    Future.delayed(Duration(seconds: 1));
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.22,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                        color: _randomcolor, shape: BoxShape.circle),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 22,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Backend FAQ questions
                  GestureDetector(
                    child: Container(
                        alignment: Alignment.center,
                        // color: Colors.grey,
                        height: MediaQuery.of(context).size.height * 0.075,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "${y["Soru"][index]["Başlık"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 15,
                            ),
                          ),
                        )),
                    onTap: () async {
                      if (y["Soru"][index]["Başlık"] !=
                          "Yukarıdan Kategori Seçiniz.") {
                        scaffoldBottomSheetFAQ(y["Soru"][index]);
                      }
                    },
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 8.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: y["Soru"][index]["Başlık"] ==
                                  "Yukarıdan Kategori Seçiniz."
                              ? Container()
                              : GestureDetector(
                                  onTap: () {
                                    if (y["Soru"][index]["Başlık"] !=
                                        "Yukarıdan Kategori Seçiniz.") {
                                      scaffoldBottomSheetFAQ(y["Soru"][index]);
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0,0,3,15),
                                    padding: EdgeInsets.all(2),
                                    child: Text(
                                      "Devamı için tıklayın",
                                      style: TextStyle(
                                        
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14,
                                          color: Colors.green.shade500),
                                    ),
                                  ),
                                )),
                    ),
                    onTap: () async {
                      if (y["Soru"][index]["Başlık"] !=
                          "Yukarıdan Kategori Seçiniz.") {
                        scaffoldBottomSheetFAQ(y["Soru"][index]);
                      }
                    },
                  ), // Kategori
                  //Kategori
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Text("Kategori: $category"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var categoryTextStyle = TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87);

    var appBarTextStyle = TextStyle(
        fontSize: MediaQuery.of(context).textScaleFactor * 25,
        color: Colors.black87,
        fontWeight: FontWeight.w500);

    return Container(
      color: Colors.white10,
      child: ListView(
        children: <Widget>[
          AppBar(
            title: Text("Sıkça Sorulan Sorular", style: appBarTextStyle),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0.8,
            actions: <Widget>[
              // Search Sonra eklenecek.
              // Button Size is going to be fixed
              // Search mechanicsm should be added
              /* IconButton(
                icon: Icon(
                  FontAwesomeIcons.search,
                  color: Colors.black54,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                onPressed: () {},
              ), */
            ],
          ),

          SizedBox(
            height: 15,
          ),

          // Pop Up menu needed
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 12, 5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                PopupMenuButton(
                  child: Container(
                    
                    decoration: BoxDecoration(
                    
                      color:Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      border: Border(),
                    ),
                    child: Padding(
                      
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Kategori Seçiniz",
                        textScaleFactor: 1.2,
                        style: categoryTextStyle,
                      ),
                    ),
                  ),
                  itemBuilder: (context) {
                    return [
                      /// Kilo Alma
                      PopupMenuItem(
                        child: ListTile(
                          trailing: Icon(FontAwesomeIcons.rocket),
                          title: Text("Kilo Alma"),
                          onTap: () async {
                            _category = "Kilo Alma";
                            firestoreGet = firestoreCont
                                .collection(
                                    "/BeslenmeApp/AllDatas/SSS")
                                .document("KiloAlma");
                            firestoreGet.get().then((ds) {
                              
                                setState(() {
                                y = ds.data;
                              });
                              
                            });
                            try {
                            await addSSSGainWeight();
                            } catch (e) {
                              print(e);
                            }

                            Navigator.pop(context);
                          },
                        ),
                      ),
                      /// Kilo Verme
                      PopupMenuItem(
                        child: ListTile(
                          trailing: Icon(FontAwesomeIcons.weight),
                          title: Text("Kilo Verme"),
                          onTap: () async{
                            _category = "Kilo Verme";
                            firestoreGet = firestoreCont
                                .collection(
                                    "/BeslenmeApp/AllDatas/SSS")
                                .document("KiloVerme");
                            firestoreGet.get().then((ds) {
                              setState(() {
                                y = ds.data;
                              });
                            });
                            try{
                               await addSSSLooseWeight();
                            }catch(e){
                              print(e);
                            }
                           
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      
                      // SağlıklıYaşam
                      PopupMenuItem(
                        child: ListTile(
                          trailing: Icon(Icons.accessibility_new),
                          title: Text("Sağlıklı Yaşam"),
                          onTap: () async{
                            _category = "Sağlıklı Yaşam";
                            firestoreGet = firestoreCont
                                .collection(
                                    "/BeslenmeApp/AllDatas/SSS")
                                .document("SağlıklıYaşam");
                            firestoreGet.get().then((ds) {
                              setState(() {
                                y = ds.data;
                              });
                            });
                            try{
                              await addSSSHealthyLife(); 
                            }catch(e){
                              print(e);
                            }
                           
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      // Doğru Bilinen Yanlışlar
                      PopupMenuItem(
                        child: ListTile(
                          trailing: Icon(Icons.warning),
                          title: Text("Doğru Bilinen Yanlışlar"),
                          onTap: () async{
                            _category = "Doğru Bilinen Yanlışlar";
                            firestoreGet = firestoreCont
                                .collection(
                                    "/BeslenmeApp/AllDatas/SSS")
                                .document("DoğruBilinenYanlışlar");
                            firestoreGet.get().then((ds) {
                              setState(() {
                                y = ds.data;
                              });
                            });
                            try{
                            await addSSSFalseKnewTrue();
                            }catch(e){
                              print(e);
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      
                      // ŞaşırtanBilgiler
                      PopupMenuItem(
                        child: ListTile(
                          trailing: Icon(FontAwesomeIcons.surprise),
                          title: Text("Şaşırtan Bilgiler"),
                          onTap: () async{
                            _category = "Şaşırtan Bilgiler";
                            firestoreGet = firestoreCont
                                .collection(
                                    "/BeslenmeApp/AllDatas/SSS")
                                .document("ŞaşırtanBilgiler");
                            firestoreGet.get().then((ds) {
                              setState(() {
                                y = ds.data;
                              });
                              
                            });
                            try {
                            await addSSSInterestingInfos();
                            } catch (e) {
                              print(e);
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),

          /// Card Satısı kadar FAQ
          SizedBox(
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return cardFAQ(context, index, _category);
              },
              itemCount: y["Soru"].length,
            ),
          )
        ],
      ),
    );
  }
}
