import 'package:beslenme/Pages/BlogPage/blogPage.dart';
import 'package:beslenme/Pages/FAQ/faq.dart';
import 'package:beslenme/Pages/HomePage/homePageBody.dart';
import 'package:beslenme/Pages/RecipesPage/recipePage.dart';
import 'package:beslenme/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

//Global
final scaffoldKey = GlobalKey<ScaffoldState>();

class _HomePageState extends State<HomePage> {
  //Refresh controller
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  static int _index = 0;

  // Firestore instange

  @override

// Firestore should be initiliazed here.
  void initState() {
    super.initState();
  }

  //Refresh controller
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  //Loading
  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    setState(() {});
    _refreshController.loadComplete();
  }

  //dispose
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext scaffoldContext) {
    final heightOfContext = MediaQuery.of(context).size.height;
    final widthOfContext = MediaQuery.of(context).size.width;
    final textScalarFactor = MediaQuery.of(scaffoldContext).textScaleFactor;

    final drawerHeaderText = TextStyle(
        fontSize: MediaQuery.of(scaffoldContext).textScaleFactor * 22,
        fontWeight: FontWeight.w700);

    final drawerSloganText = TextStyle(
        fontSize: MediaQuery.of(scaffoldContext).textScaleFactor * 15);

    return Scaffold(
      key: scaffoldKey,

      // Drawer
      drawer: Drawer(
        semanticLabel: "YanMenü",
        child: Container(
          color: Colors.green.shade100,
          child: ListView(
            children: <Widget>[
              Container(
                color: Colors.green.shade200,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      title: Text(
                        "Diyet-in",
                        style: drawerHeaderText,
                      ),
                      trailing: CircleAvatar(
                      
                        backgroundImage:
                            AssetImage("assets/images/nutrition.png"),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Beslenme bir lüks değil bir ihtiyaçtır.",
                        style: drawerSloganText,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3,
              ),

              // Space
              SizedBox(
                height: heightOfContext * 0.1,
              ),

              // Profil
              /* Container(
                color: Colors.green.shade300,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "LibraryPage");
                      scaffoldKey.currentState.openEndDrawer();
                    },
                    title: Text(
                      "Kitaplık",
                      style: TextStyle(
                          fontSize:
                             textScalarFactor*20,
                             ),
                    ),
                    trailing: Icon(FontAwesomeIcons.listAlt),
                  ),
                ),
              ), */
              SizedBox(
                height: 5,
              ),

              // HomePage
              Container(
                color: Colors.green.shade200,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 9, 0),
                  child: ListTile(
                    onTap: () => Navigator.pop(context),
                    title: Text(
                      "Anasayfa",
                      style: TextStyle(fontSize: textScalarFactor * 20),
                    ),
                    trailing: Icon(FontAwesomeIcons.home),
                  ),
                ),
              ),

              SizedBox(
                height: 5,
              ),

              // Rehber
              Container(
                color: Colors.green.shade200,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "Rehber");
                      scaffoldKey.currentState.openEndDrawer();
                    },
                    title: Text(
                      "Beslenme Rehberi",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(scaffoldContext).textScaleFactor *
                                  20),
                    ),
                    trailing: Icon(Icons.library_books),
                  ),
                ),
              ),

              SizedBox(height: 5),
              // Calculators
              Container(
                color: Colors.green.shade200,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 7, 0),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "CalculatorMain");
                      scaffoldKey.currentState.openEndDrawer();
                    },
                    title: Text(
                      "Hesaplayıcılar",
                      style: TextStyle(
                        fontSize: textScalarFactor * 20,
                      ),
                    ),
                    trailing: Icon(FontAwesomeIcons.calculator),
                  ),
                ),
              ),

              SizedBox(height: 5),

              // Bize Sorun
              Container(
                color: Colors.green.shade200,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "BizeSorun");
                      scaffoldKey.currentState.openEndDrawer();
                    },
                    title: Text(
                      "Soru Cevap",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(scaffoldContext).textScaleFactor *
                                  20),
                    ),
                    trailing: Icon(FontAwesomeIcons.question),
                  ),
                ),
              ),

              SizedBox(height: 5),
              // About
              Container(
                color: Colors.green.shade200,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 7, 0),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "AboutUs");
                      scaffoldKey.currentState.openEndDrawer();
                    },
                    title: Text(
                      "Hakkımızda",
                      style: TextStyle(
                        fontSize: textScalarFactor * 20,
                      ),
                    ),
                    trailing: Icon(FontAwesomeIcons.infoCircle),
                  ),
                ),
              ),
              SizedBox(height: 5),

              ///
              /// Settings
              /// BU kısım daha sonrasında dahil edilecektir.
              ///
              ///
            ],
          ),
        ),
      ),

      //Body Part of HomePage
      body: StoreConnector<AppState, AppState>(
          // Redux Implementation
          converter: (store) => store.state,
          builder: (context, state) {
            //Scroll to refresh controller
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropHeader(
                waterDropColor: Colors.green,
              ),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CircularProgressIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    color: Colors.amber,
                    height: 11.0,
                    child: Center(child: body),
                  );
                },
              ),

              // Main Homepage Body Function For Navigation
              child: homePageBodyFunction(scaffoldContext, _index),
              onLoading: _onLoading,
              onRefresh: _onRefresh,
            );
          }),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedFontSize: 16,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: [
          // Iconlar ve Yazılar
          BottomNavigationBarItem(
            backgroundColor: Colors.green.shade600,
            title: Text(
              "Ana Sayfa",
            ),
            icon: Icon(FontAwesomeIcons.home,size: 27,),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green.shade600,
            title: Text("Blog"),
            icon: Icon(Icons.library_books,size: 27,),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green.shade600,
            title: Text("Tarifler"),
            icon: Icon(Icons.restaurant,size: 27,),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green.shade600,
            title: Text("SSS"),
            icon: Icon(FontAwesomeIcons.question,size: 27,),
          ),
        ],
      ),
    );
  }
}

// FAQ data should come from Firebase
// This Function should take parameters. Title, Text, Source
Widget homePageBodyFunction(BuildContext context, int indexOfBody) {
  switch (indexOfBody) {
    case 0:
      return homePageBody(context);
      break;
    case 1:
      return BlogPage();
      break;
    case 2:
      return RecipePage();
      break;
    case 3:
      return FAQPage();

      break;
  }
  return homePageBody(context);
}

// Sıkça sorulanlar için yapılmış kısım.
void scaffoldBottomSheetFAQ(data) async {
  scaffoldKey.currentState.showBottomSheet((context) {
    var contentFAQ = TextStyle(
        height: 1.5, fontSize: MediaQuery.of(context).textScaleFactor * 17.4);

    var sourceFAQ = TextStyle(fontWeight: FontWeight.w700);

    var headerFAQ = TextStyle(
        height: 1.5,
        fontWeight: FontWeight.w700,
        fontSize: MediaQuery.of(context).textScaleFactor * 17);

    return Opacity(
      opacity: 0.9,
      child: Container(
        decoration: BoxDecoration(color: Colors.green.shade100),
        height: data["Cevap"].length > 150
            ? MediaQuery.of(context).size.height * 0.55
            : MediaQuery.of(context).size.height * 0.35,
        child: Column(children: [
          SizedBox(
            height: 5,
          ),

          ///
          ///  Sıkça sorulanlar Başlık
          ListTile(
            title: Text("${data["Başlık"]}", style: headerFAQ),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SizedBox(
            height: 5,
          ),

          // SSS Soruların Cevapları
          // içerik Yazısı
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Text(
                  "${data["Cevap"]}",
                  style: contentFAQ,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),

          // Kaynak Kısmı
          ListTile(
            leading: Icon(FontAwesomeIcons.sourcetree),
            title: Text(
              "Kaynak: ${data["Kaynak"]}",
              style: sourceFAQ,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ]),
      ),
    );
  });
}
