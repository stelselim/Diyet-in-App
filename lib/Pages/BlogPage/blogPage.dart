import 'package:beslenme/Operations/viewNumber.dart';
import 'package:beslenme/model/app_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BlogPage extends StatefulWidget {
  BlogPage({Key key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage>
    with SingleTickerProviderStateMixin {
  Firestore firestoreBlog = Firestore.instance;

  AnimationController _controller;
  Animation<double> _animation;
  int _indexOfQuote;
  int today = DateTime.now().day;

  @override
  void initState() {
    _indexOfQuote = 0;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween(
      begin: 0.5,
      end: 0.8,
    ).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Bunun firestore bağlantısı yapılacakç

  @override
  Widget build(BuildContext context) {
    /// Animasyon başladı.
    _controller.repeat(
      reverse: true,
    );

    // _controller.reverse();
    /// Günün Sözleri için söz sayısı burada verilecek.

    final titleTextStyle = TextStyle(
        fontSize: MediaQuery.of(context).textScaleFactor * 20,
        fontWeight: FontWeight.w700,
        height: 1,
        color: Colors.black);

    final explanationTextStyle = TextStyle(
        fontSize: MediaQuery.of(context).textScaleFactor * 18,
        height: 1.5,
        fontWeight: FontWeight.w700,
        color: Colors.black87);

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, store) => Container(
        color: Colors.white10,
        child: ListView(
          //   physics: ScrollPhysics(),
          //  shrinkWrap: true,
          children: <Widget>[
            // AppBar
            AppBar(
              title: Text(
                "Blog",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).textScaleFactor * 25,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0.8,
              actions: <Widget>[
                // SEARCH SONRA EKLENCEK
                /*  IconButton(
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
              height: MediaQuery.of(context).size.height * 0.03,
            ),

            // Anlamlı Sözler
            SizedBox(
              child: FutureBuilder<DocumentSnapshot>(
                  future: Firestore.instance
                      .collection("/BeslenmeApp/AllDatas/GününSözü")
                      .document("doc")
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Text("Error");
                    if (snapshot.data == null) return Container();

                    print(DateTime.now().day %
                        snapshot.data.data["sözler"].length);
                    //  _indexOfQuote = snapshot.data.data["sözler"].length;
                    //int d = snapshot.data.data["sözler"]%today;
                    return FadeTransition(
                      opacity: _animation,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              // offset: Offset(1, 5),
                            )
                          ],
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue.shade400,
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: MediaQuery.of(context).size.height * 0.17,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Günün Sözü",
                                style: titleTextStyle,
                                textScaleFactor: 0.8,
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                snapshot.data.data["sözler"][
                                    DateTime.now().day %
                                        snapshot.data.data["sözler"].length],
                                textScaleFactor: 0.8,
                                style: explanationTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
              child: Divider(
                color: Colors.black26,
                thickness: 0.7,
              ),
            ),

            // Blog Yazıları
            SizedBox(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection("/BeslenmeApp/AllDatas/Blog")
                        .orderBy("EklenmeTarihi", descending: true)
                        .getDocuments()
                        .asStream(),
                    builder: (context, snapshot) {
                      // Buradaki gibi
                      if (snapshot.hasError) return Text("Error");
                      if (snapshot.data == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 20,
                            childAspectRatio: 0.65),
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: cardBlogPage(
                                context,
                                snapshot.data.documents.elementAt(index).data,
                                index),
                            onTap: () {
                              store.dataOfBlogReading =
                                  snapshot.data.documents.elementAt(index).data;

                              //snapshot.data.documents.elementAt(index).reference.setData({});
                              try {
                              addOneToReviewNumberBlog(snapshot.data.documents.elementAt(index));
                              } catch (e) {
                                print(e);
                              }
                              Navigator.pushNamed(context, "blogReadingPage");
                            },
                          );
                        },
                      );
                    }),
              ),
            ),

            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

Widget cardBlogPage(BuildContext context, var data, int index) {
  return Container(
    child: Wrap(
      // mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: CachedNetworkImageProvider(data["Resim"])),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Container(
            //    color: Colors.red,
            child: Text(
              "${data["Başlık"]}",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600),
              textScaleFactor: 1.1,
            ),
          ),
        ),
      ],
    ),
  );
}
