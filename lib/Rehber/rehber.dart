import 'package:beslenme/Operations/viewNumber.dart';
import 'package:beslenme/Rehber/guideCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RehberPage extends StatefulWidget {
  RehberPage({Key key}) : super(key: key);

  @override
  _RehberState createState() => _RehberState();
}

class _RehberState extends State<RehberPage> {
  final firestoreInstance = Firestore.instance;

  @override
  void initState() {
    try {
      addNumberGuideOfNutrition();
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("Beslenme Rehberi",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
              textScaleFactor: 1.5),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Bölüm 1",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Bölüm 2",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Bölüm 3",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Bölüm 4",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GuideBody(level: "Seviye1"),
            GuideBody(level: "Seviye2"),
            GuideBody(level: "Seviye3"),
            GuideBody(level: "Seviye4"),
          ],
        ),
      ),
    );
  }
}

class GuideBody extends StatelessWidget {
  final String level;
  const GuideBody({Key key, @required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: <Widget>[
        SizedBox(
          height: 3,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("/BeslenmeApp/Rehber/$level")
              .orderBy("Order")
              .getDocuments()
              .asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text("Bir Sorun Oluştu");
            if (snapshot.data == null)
              return Center(
                child: CircularProgressIndicator(),
              );

            return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return GuideCard(
                    data: snapshot.data.documents.elementAt(index));
              },
            );
          },
        ),
      ],
    );
  }
}
