import 'package:beslenme/Calculators/calculateBMI.dart';
import 'package:beslenme/Calculators/calculateCalorie.dart';
import 'package:beslenme/Calculators/calculateProteinNeed.dart';
import 'package:beslenme/Calculators/calculateWalkCalorie.dart';
import 'package:beslenme/Calculators/style.dart';
import 'package:beslenme/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CalculatorMain extends StatefulWidget {
  CalculatorMain({Key key}) : super(key: key);

  @override
  _CalculatorMainState createState() => _CalculatorMainState();
  
}

class _CalculatorMainState extends State<CalculatorMain> {


  int _index = 0;
  String weight,height;
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

        return  Material(
            color: Colors.green.shade100,
            child: ListView(
              children: <Widget>[
            
            // AppBar 
            AppBar(
                  iconTheme: IconThemeData(color: Colors.black87),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    "Hesaplayıcılar",
                    style: appBarTextStyle,
                textScaleFactor: 1.5,
              ),
            ),
            
            // Calorie Need Calculator
            ListTile(
              title: Text("Kalori İhtiyacı Erkek"),
              trailing: Icon(FontAwesomeIcons.weight,color: Colors.blue,),
              onTap: () {
                setState(() {
                  _index = 1;
                });
                
              },
            ),
            // Calorie Need Calculator
            ListTile(
              title: Text("Kalori İhtiyacı Kadın"),
              trailing: Icon(FontAwesomeIcons.weight,color: Colors.pink,),
              onTap: () {
                setState(() {
                  _index = 4;
                });
                
              },
            ),
            
            // Protein Need Calculator
            ListTile(
              title: Text("Sporcu Protein İhtiyacı"),
              trailing: Icon(FontAwesomeIcons.solidStar,color: Colors.yellow,),
              onTap: () {
                setState(() {
                  _index = 2;
                 
                });
              },
            ),
            
            
            //BMI Calculator
            ListTile(
              title: Text("BMI Endeksi"),
              trailing: Icon(Icons.poll,color: Colors.green,),
              onTap: () {
                setState(() {
                  _index = 0;
                });
              },
            ),
            /// Yürüme Kalorisi
            ListTile(
              title: Text("Yürüyüş Kalori Hesabı"),
              trailing: Icon(FontAwesomeIcons.walking,color: Colors.black,),
              onTap: () {
                setState(() {
                  _index = 3;
                 
                });
              },
            ),

            ///
            /// Switch Function Used here.
            /// because we need to change which calculator we use
            /// 
            calculatorsFunction(_index, context)
          
          
          ]
      )
        );
    
      
  }
}

// For Changing Calculator
Widget calculatorsFunction(int index, BuildContext context) {

  switch (index) {


    // Case 0 => BMI Calculator
    case 0:
      return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 400,
            width: 100,
            color: Colors.amber,
            child: Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: CalculateBMI().formOfBMI(context),
                ),
              ),
            ),
          ),
          );
    
    // Case 1 => Calori Need
    case 1:
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 400,
          width: 100,
          color: Colors.purple,
          child: Card(
            child: CalculateCalorieNeed().calorieNeed(context),
          )   
        ),
      );
      case 4:
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 400,
          width: 100,
          color: Colors.yellow,
          child: Card(
            child: CalorieNeedWomen().calorieNeed(context),
          )   
        ),
      );

    // Case 2 => Protein Need
    case 2:
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 400,
          width: 100,
          color: Colors.blue,
          child: Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: CalculateProteinNeed().formOfProteinNeed(context),
                ),
              ),
            ),
          )
      );
      /// 60 Dakikada Harcanan Kalori
      case 3:
      return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 400,
            width: 100,
            color: Colors.red,
            child: Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: CalculateWalkCalorie().formOfWalkCalorie(context),
                ),
              ),
            ),
          ),
          );
    
  }
  return Card();
}

