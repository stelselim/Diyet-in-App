import 'dart:core';
import 'package:beslenme/model/app_state.dart';
import 'package:beslenme/redux/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';



class CalculateProteinNeed{


 Widget formOfProteinNeed(BuildContext mainContext){


  final _formKey = GlobalKey<FormState>();

  double proteinNeed = 0.0;
  int weight = 0;
  double coefficientProtein=0;
  double highLimitProtein =0;
  
  return StoreConnector<AppState,AppState>(
      converter: (store)=>store.state,
      builder: (context,store){

        store.resultsOfProtein = proteinNeed.toInt();


        return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
 
          // kilo
           TextFormField(
             decoration: InputDecoration(hintText: "Kilonuz (kg)"),
             keyboardType: TextInputType.numberWithOptions(signed: true,decimal: false),
             inputFormatters:<TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
            validator:  (store)=>validateWeight(store),
             onSaved: (value){
              
               weight = int.parse(value);
             },
                    
           ),
          
          DropdownButton(
            value: store.valueOfCalculatorProtein,
            isExpanded: true,
            

            hint: Text("Aktivite Düzeyi"),
            items: [
             
             DropdownMenuItem(
               value: 0,
               child: Text("Minimal Düzey Faaliyet"),
             ),
            
              DropdownMenuItem(
              value: 1,
               child: Text("Hafif Düzey Faaliyet"),
             ),

             DropdownMenuItem(
               value: 2,
               child: Text("Orta Düzey Faaliyet"),
             ),

               DropdownMenuItem(
               value: 3,
               child: Text("Güç ve Dayanıklılık Gerektiren"),
             ),

              DropdownMenuItem(
               value: 4,
               child: Text("Ağır Düzey ve Elit Atletler"),
             ),


            ],
          
            onChanged: (value){
              store.valueOfCalculatorProtein = value;
              StoreProvider.of<AppState>(context).dispatch(ValueOfCalculatorProtein);

              Fluttertoast.showToast(msg:"Hesapla Tuşuna Basın",backgroundColor: Colors.blue.shade300,fontSize: 22,gravity: ToastGravity.CENTER);
              
              switch(value){
                case 0:
                  coefficientProtein =0.8;
                break;

                case 1:
                 coefficientProtein = 1.0;
          
                break;

                case 2:
                 coefficientProtein =1.2;
                 highLimitProtein = 1.6;
                break;

                case 3:
                 coefficientProtein =1.2;
                 highLimitProtein = 1.7;
                break;

                case 4:
                 coefficientProtein =2.0;
                break;
               
              }
            },
          ),

           // Calculate Button
           
            RaisedButton(
              child: Text("Hesapla"),
              onPressed: () async{
               try{
                 if(_formKey.currentState.validate()){
                  _formKey.currentState.save();

                }
                else Fluttertoast.showToast(msg:"işlem gerçekleştirilemedi");

               } catch(e){
                 print(e);
               }

                proteinNeed = weight.toDouble()*coefficientProtein;
                store.resultsOfProtein = proteinNeed.toInt();
                StoreProvider.of<AppState>(context).dispatch(ProteinCalculation);
              },
            ),

          // Results
            Card(
                  elevation: 0,
                  child: ListTile(
                    title: 
                    (store.valueOfCalculatorProtein!=2 &&store.valueOfCalculatorProtein !=3 )?
                    Text(
                      "${store.resultsOfProtein} gram Protein",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      textScaleFactor: 1.4,
                    ):
                    Text(
                      "${store.resultsOfProtein}-${(weight*(highLimitProtein-coefficientProtein)).toInt()+store.resultsOfProtein} gram Protein",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      textScaleFactor: 1.4,
                    )
                    ,
                  ),
                ),
          
 
          ],
        ),
      );}
  ); 
}

}


  String validateWeight(value) {
    int _weight = int.tryParse(value);
    if (_weight < 160 && _weight > 25) {
      return null;
    }
    return "Geçersiz Değer";
  }

