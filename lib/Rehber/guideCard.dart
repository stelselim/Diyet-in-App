import 'package:beslenme/Rehber/GuideReading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GuideCard extends StatelessWidget {
  final DocumentSnapshot data;
  const GuideCard({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String text = data.data["Yazı"];
    text = text.substring(0,70);

    //print(data.data);
    return Container(
      height: MediaQuery.of(context).size.height * 0.27,
      color: Colors.green.shade100,
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GuideReadingPage(
                  data:data
                ),
              )
              );
          
        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "${data.data["Başlık"]}",
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.1,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    "$text...",
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
