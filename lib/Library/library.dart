import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  LibraryPage({Key key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {

  

  @override
  void initState() { 
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green.shade100,
      child: ListView(
        children: <Widget>[
          AppBar(
            iconTheme: IconThemeData(color: Colors.black87),
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Kitaplık",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
              textScaleFactor: 1.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 4),
            child: Text(
              "Kaydedilenler",
              textScaleFactor: 1.5,
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
            ),
          ),
          FutureBuilder(builder: (context,count) {

            return ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(7),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Kaydedilmiş Yazı"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
