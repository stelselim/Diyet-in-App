import 'package:beslenme/Operations/viewNumber.dart';
import 'package:beslenme/model/app_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './homepage.dart';

Widget homePageBody(BuildContext scaffoldContext) {

  var _stream = Firestore.instance
      .collection("/BeslenmeApp/AllDatas/Blog")
      .orderBy("EklenmeTarihi",descending: true)
      .limit(7)
      .getDocuments();
  var x;

  return Container(
    color: Colors.white10,
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              textTheme: TextTheme(
                title: TextStyle(
                    color: Colors.black54,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              title: Text("Diyet-in"),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(3.0),
                child: GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState.openDrawer();
                    },
                    child: Icon(
                      Icons.apps,
                      color: Colors.black,
                    )),
              ),
              backgroundColor: Colors.white,
              elevation: 0.5,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: "Diyet-ine Hoş Geldin!",
                          gravity: ToastGravity.CENTER);
                    },
                    child: new CircleAvatar(
                      radius: 30,
                      backgroundImage: new AssetImage(
                        "assets/images/nutrition.png",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                /* Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.search),
                    color: Colors.black54,
                    iconSize: MediaQuery.of(scaffoldContext).size.width * 0.07,
                  ),
                ) */
              ],
            ),

            // Avatar and Search Bar
            //    homeSearchAndAvatar(scaffoldContext),

            // Space between topBar and Horizontal List
            SizedBox(
              width: MediaQuery.of(scaffoldContext).size.width,
              height: MediaQuery.of(scaffoldContext).size.height * 0.00,
            ),

            /// Başlıca yazılar texti
            SizedBox(
              height: MediaQuery.of(scaffoldContext).size.height * 0.07,
              child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                    child: Text(
                      "Öne Çıkan Yazılar",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize:
                              MediaQuery.of(scaffoldContext).textScaleFactor *
                                  17),
                    ),
                  )),
            ),
            // Horizontal List

            SizedBox(
              height: MediaQuery.of(scaffoldContext).size.height * 0.33,
              child: StreamBuilder<QuerySnapshot>(
                  stream: _stream.asStream().handleError((onError) {
                    return CircularProgressIndicator();
                  }),
                  builder: (context, sn) {
                    if (sn.hasError) {
                      return new Text("Error!");
                    } else if (sn.data == null) {
                      return Center(child: new CircularProgressIndicator());
                    } else {
                      x = sn.data.documents.take(10);

                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: x.length,
                        itemBuilder: (context, index) {
                          return cardHorizontalScroll(
                            x.elementAt(index),
                              context, index, x.elementAt(index).data);
                        },
                      );
                    }
                  }),
            ),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(scaffoldContext, "BizeSorun");
                },
                child: Container(
                  alignment: Alignment.center,
                   // color: Colors.blue.shade200,
                    height: 40,
                    child: Text("Soru Cevap Bölümü İçin Tıklayın",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w400),textScaleFactor: 1.2,),
                  ),
              ),
            ),

            // Çok Özel Konseptler
            SizedBox(
              height: MediaQuery.of(scaffoldContext).size.height * 0.07,
              child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      "Çok Özel Konseptler",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize:
                              MediaQuery.of(scaffoldContext).textScaleFactor *
                                  17),
                    ),
                  )),
            ),

            /// Daha sonra eklenecekler.
            GridView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1.3),
              children: <Widget>[
                cardDengeli(scaffoldContext),
                cardRehber(scaffoldContext),
              ],
            ),
            // Space between Horizontal List and Vertical List
            SizedBox(
              height: MediaQuery.of(scaffoldContext).size.height * 0.08,
              child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: Text(
                      "Nefis Tarifler",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize:
                              MediaQuery.of(scaffoldContext).textScaleFactor *
                                  23),
                    ),
                  )),
            ),

            // Tarifler
            SizedBox(
              height: MediaQuery.of(scaffoldContext).size.height * 0.25,
              child: StreamBuilder<Object>(
                  stream: Firestore.instance
                      .collection(
                          "/BeslenmeApp/AllDatas/Tarifler/Kategoriler/KiloAlma")
                      .getDocuments()
                      .asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Text("error".toString());
                    if (snapshot.data == null)
                      return Center(child: CircularProgressIndicator());
                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        var data = [
                          {"Kategori": "Öğrencilere Özel Tarifler"},
                          {"Kategori": "Düşük Kalorili Tarifler"},
                          {"Kategori": "Yüksek Kalorili Tarifler"},
                          {"Kategori": "Fit Tatlılar"},
                          {"Kategori": "Pratik Çözümler"},
                          {"Kategori": "Yenilikçi Tarifler"}
                        ];
                        return cardHorizontalSquare(
                            context, data[index], index);
                      },
                    );
                  }),
            ),

            // Space
            SizedBox(
              width: MediaQuery.of(scaffoldContext).size.width,
              height: MediaQuery.of(scaffoldContext).size.height * 0.02,
            ),

            SizedBox(
              height: MediaQuery.of(scaffoldContext).size.height * 0.07,
              child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      "Sizin için Seçtiklerimiz",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize:
                              MediaQuery.of(scaffoldContext).textScaleFactor *
                                  20),
                    ),
                  )),
            ),

            // Vertical List

            ///
            SizedBox(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection(
                          "/BeslenmeApp/AllDatas/Tarifler/Kategoriler/DeğişiklikArayanlar")
                      .limit(3)
                      .orderBy("Kalori",descending: false)
                      .getDocuments()
                      .asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Text("There is an errror");
                    if (snapshot.data == null)
                      return Container(
                        child: CircularProgressIndicator(),
                      );
                    return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data =
                              snapshot.data.documents.elementAt(index).data;
                          return cardVerticalScroll(snapshot.data.documents.elementAt(index),context, data);
                        });
                  }),
            ),

            SizedBox(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection(
                          "/BeslenmeApp/AllDatas/Tarifler/Kategoriler/FitTatlılar")
                      .orderBy("Kalori",descending: true)
                      .limit(3)
                      .getDocuments()
                      .asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Text("There is an errror");
                    if (snapshot.data == null)
                      return Container(
                        child: CircularProgressIndicator(),
                      );
                    return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data =
                              snapshot.data.documents.elementAt(index).data;
                          return cardVerticalScroll(snapshot.data.documents.elementAt(index),context, data);
                        });
                  }),
            ),

            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget cardHorizontalScroll(DocumentSnapshot doc ,BuildContext scaffoldContext, int index, Map blog) {
  String imageURL = blog["Resim"];

  if (blog == null) return CircularProgressIndicator();

  return StoreConnector<AppState, AppState>(
    converter: (store) => store.state,
    builder: (context, state) => GestureDetector(
      onTap: () async{
        state.dataOfBlogReading = blog;
        try{
          await addOneToReviewNumberBlog(doc);
        }catch(e){
          print(e);
        }
        Navigator.pushNamed(scaffoldContext, "blogReadingPage");

        //Fluttertoast.showToast(msg:"Geliştirilme Aşamasında");
      },
      child: Container(
        //  color: Colors.blueGrey.shade200,
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: MediaQuery.of(scaffoldContext).size.width * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    color: Colors.teal.shade100,
                    image: new DecorationImage(
                        image: CachedNetworkImageProvider(imageURL),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.9), BlendMode.dstATop))),
//            width: MediaQuery.of(scaffoldContext).size.width * 0.8,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 2, 10, 0),
                //    color: Colors.grey.shade300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${blog["Başlık"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(scaffoldContext).textScaleFactor *
                                  16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Tariflere Giden Kartlar
Widget cardHorizontalSquare(BuildContext scaffoldContext, Map data, int index) {
  return GestureDetector(
    onTap: () {
      if (data["Kategori"] == "Öğrencilere Özel Tarifler") {
        Navigator.pushNamed(scaffoldContext, "Student");
      } else if (data["Kategori"] == "Düşük Kalorili Tarifler") {
        Navigator.pushNamed(scaffoldContext, "lowCalorieRecipe");
      } else if (data["Kategori"] == "Yüksek Kalorili Tarifler") {
        Navigator.pushNamed(scaffoldContext, "HighCalorie");
      } else if (data["Kategori"] == "Fit Tatlılar") {
        Navigator.pushNamed(scaffoldContext, "FitDeserts");
      } else if (data["Kategori"] == "Pratik Çözümler") {
        Navigator.pushNamed(scaffoldContext, "FastAndDaily");
      } else if (data["Kategori"] == "Yenilikçi Tarifler") {
        Navigator.pushNamed(scaffoldContext, "LookingNew");
      }
    },
    child: Container(
      //  color: Colors.blueGrey.shade200,
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: MediaQuery.of(scaffoldContext).size.width * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.teal.shade100,
                image: new DecorationImage(
                  image: new AssetImage(
                      "assets/images/anasayfaTarifler/${(index + 1)}.jpeg"),
                  fit: BoxFit.cover,
                  /* colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.7), BlendMode.dstATop,), */
                ),
              ),
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 2, 10, 0),
              //    color: Colors.grey.shade300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${data["Kategori"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize:
                            MediaQuery.of(scaffoldContext).textScaleFactor * 12,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget cardVerticalScroll(DocumentSnapshot doc, BuildContext scaffoldContext, Map data) {
  String imageURL = data["Resim"];

  ///String imageURL = "https://firebasestorage.googleapis.com/v0/b/beslenmeblog-c313a.appspot.com/o/all%2FBlog%2Fplaystore.png?alt=media&token=d7f5b8ca-d33c-4f33-a20a-8eb801ce5b49";

  return StoreConnector<AppState, AppState>(
    converter: (store) => store.state,
    builder: (context, state) => Container(
      // color: Colors.grey,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 5),
      height: MediaQuery.of(scaffoldContext).size.height * 0.17,
      child: GestureDetector(
        onTap: () async{
          state.dataOfRecipeReading = data;
          try{
          await addOneToReviewNumberRecipe(doc);
          }catch(e){
            print(e);
          }
          Navigator.pushNamed(scaffoldContext, "recipeReadingPage");
          //Fluttertoast.showToast(msg:"Geliştirilme Aşamasında");
        },
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: MediaQuery.of(scaffoldContext).size.height * 0.14,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: new DecorationImage(
                      image: new CachedNetworkImageProvider(imageURL),
                      fit: BoxFit.cover,
                    )),
                alignment: Alignment.center,
              ),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
            Expanded(
              flex: 8,
              child: Container(
                  // color: Colors.blue,
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          /* SizedBox(
                            height: MediaQuery.of(scaffoldContext).size.height *
                                0.035,
                          ), */
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            // 55 Karakter Maksimum
                            child: Text(
                              data["Tarifinİsmi"],
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: MediaQuery.of(scaffoldContext)
                                        .textScaleFactor *
                                    16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(scaffoldContext).size.height *
                                0.0085,
                          ),
                          // 20 karakter Maksimum
                          Text(
                            data["YapanKişi"],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(scaffoldContext)
                                      .textScaleFactor *
                                  13,
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
          ],
        ),
      ),
    ),
  );
}

//// Bunlar henüz kuallnılmadı
Widget cardDengeli(BuildContext scaffoldContext) {
  return SizedBox(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(scaffoldContext, "Dengeli");
        },
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.blue.shade50.withOpacity(0.87),
            child: Container(
              child: Center(
                child: Text(
                  "Dengeli Tabaklar Henüz Geliştirme Aşamasında",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue.shade700, fontWeight: FontWeight.w500),
                  textScaleFactor: 1,
                ),
              ),
              height: MediaQuery.of(scaffoldContext).size.height * 0.15,
              margin: EdgeInsets.symmetric(
                vertical: 11,
                horizontal: 22,
              ),
            )),
      ),
    ),
  );
}

Widget cardRehber(BuildContext scaffoldContext) {
  return SizedBox(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(scaffoldContext, "Rehber");
        },
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.green.shade50.withOpacity(0.87),
            child: Container(
              child: Center(
                child: Text(
                  "Beslenme Rehberi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w500),
                  textScaleFactor: 1.35,
                ),
              ),
              decoration: BoxDecoration(
                  //image: DecorationImage(image: new AssetImage("assets/recipes/resim.jpg"),),
                  ),
              height: MediaQuery.of(scaffoldContext).size.height * 0.15,
              margin: EdgeInsets.symmetric(
                vertical: 11,
                horizontal: 22,
              ),
            )),
      ),
    ),
  );
}

Future getImageURLFromStorage() async {
  final FirebaseStorage _firestorage = FirebaseStorage.instance;

  String x = await _firestorage
      .ref()
      .child("/all/Blog/playstore.png")
      .getDownloadURL();
  return x;
}
