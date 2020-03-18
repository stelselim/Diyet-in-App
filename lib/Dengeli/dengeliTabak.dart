import 'package:beslenme/Operations/viewNumber.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DengeliPage extends StatefulWidget {
  DengeliPage({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<DengeliPage> {

   @override
  void initState() {
    try{
      addNumberFitPlates();
    }catch(e){
      print(e);
    }
     
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
     // color: Colors.green.shade100,
      child: ListView(
        children: <Widget>[
          AppBar(
            iconTheme: IconThemeData(
              color: Colors.black87
            ),
            elevation: 0,
           backgroundColor:Colors.transparent,
            title: Text("Dengeli Tabaklar",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500),textScaleFactor: 1.5),
          ),
          Divider(),
          SizedBox(height: 250,),
          Align(
            alignment: Alignment.center,
            child: Text("Yakında Sizlerle",textScaleFactor: 2.5,),)
          
        ],
      ),
    );
  }
}