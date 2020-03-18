import 'package:beslenme/Operations/viewNumber.dart';
import 'package:beslenme/model/app_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:beslenme/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_redux/flutter_redux.dart';

class FastAndDaily extends StatefulWidget {
  FastAndDaily({Key key}) : super(key: key);

  @override
  _FastAndDailyState createState() => _FastAndDailyState();
}

class _FastAndDailyState extends State<FastAndDaily> {
  Firestore firestoreFastAndDaily = Firestore.instance;

  dynamic _fastAndDailyRecipes;

  @override
  Widget build(BuildContext context) {
    var colorCard = Colors.blueGrey.shade50;

    final textStyleOfAppBar = TextStyle(
        fontSize: MediaQuery.of(context).textScaleFactor * 18,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.7);

    return Container(
      color: Colors.green.shade400,
      child: SafeArea(
        child: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                AppBar(
                  elevation: 0.7,
                  backgroundColor: Colors.green.shade400,
                  leading: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black87,
                      )),
                  title: Text(
                    "Hızlı ve Günü Kurtaran Tarifler",
                    style: textStyleOfAppBar,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection(
                              "/BeslenmeApp/AllDatas/Tarifler/Kategoriler/HızlıTarifler")
                          .getDocuments()
                          .asStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) return Container();
                        if (snapshot.data == null)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        return ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            _fastAndDailyRecipes =
                                snapshot.data.documents.elementAt(index).data;
                            return cardFastAndDaily(
                                snapshot.data.documents.elementAt(index),
                                context,
                                _fastAndDailyRecipes,
                                index,
                                colorCard);
                          },
                        );
                      }),
                ),
              ],
            )),
      ),
    );
  }
}

Widget cardFastAndDaily(DocumentSnapshot doc, BuildContext context, var data,
    int index, Color color) {
  dynamic makros = data["Kalori"];

  String imagURL = data["Resim"];

  // Title of Meal
  final styleOfRecipeName = TextStyle(
      fontSize: MediaQuery.of(context).textScaleFactor * 16,
      fontWeight: FontWeight.bold);

// Macros Style of Meal
  final styleOfMacros = TextStyle(
      fontSize: MediaQuery.of(context).textScaleFactor * 12,
      fontWeight: FontWeight.w600);

  return StoreConnector<AppState, AppState>(
    converter: (store) => store.state,
    builder: (context, store) => GestureDetector(
      onTap: () async {
        store.dataOfRecipeReading = data;
        try {
           await addOneToReviewNumberRecipe(doc);
        } catch (e) {
          print(e);
        }
       
        Navigator.of(context).push(recipeReadingRoute());
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 11),
        height: MediaQuery.of(context).size.height * 0.28,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Card(
          color: color,
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: ()async{
                // O kısımdaki datayı vermek için gerekli kısımları vermek lazım.
                store.dataOfRecipeReading = data;
                try {
                  addOneToReviewNumberRecipe(doc);
                } catch (e) {
                  print(e);
                }
                //StoreProvider.of(context).dispatch(store.dataOfRecipeReading);
                Navigator.of(context).push(recipeReadingRoute());
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.13,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blue,
                                    width: 0,
                                    style: BorderStyle.solid),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(imagURL),
                                    fit: BoxFit.cover)),
                          ),
                        )),

                    // SPACE BETWEEN IMAGE AND TİTLE, NAME
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),

                    // TEXT AND TİTLE NAME
                    Expanded(
                      flex: 12,
                      child: Container(
                        // color: Colors.cyan,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),

                            // Title
                            Text(
                              "${data["Tarifinİsmi"]}",
                              style: styleOfRecipeName,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),

                            // Macros
                            Text(
                              "Kalori:${makros["Kalori"]} cal \nKarbonhidrat:${makros["Karbonhidrat"]} gr \nProtein:${makros["Protein"]} gr \nYağ:${makros["Yağ"]} gr",
                              style: styleOfMacros,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.010,
                            ),

                            /* // Button to continue
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Devam et",
                                  style: styleOfMacros,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(Icons.arrow_forward),
                              ],
                            ), */
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
