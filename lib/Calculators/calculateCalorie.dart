import 'dart:core';
import 'package:beslenme/model/app_state.dart';
import 'package:beslenme/redux/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';



class CalculateCalorieNeed{


 Widget calorieNeed(BuildContext mainContext){


  final _formKey = GlobalKey<FormState>();
  int age=0;
  int weight = 0;
  int calori=0;
  double bmh=0;
  double coefficientCalorie;
  
  
  return StoreConnector<AppState,AppState>(
      converter: (store)=>store.state,
      builder: (context,store){



        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              // Yaş
             TextFormField(
               decoration: InputDecoration(hintText: "Yaş",helperText: "15 ve üstü"),
               keyboardType: TextInputType.numberWithOptions(signed: true,decimal: false),
               inputFormatters:<TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
              validator:  (store){
                if(int.parse(store)>15){
                  return null;
                }
                return "Hatalı Yaş";
              },
               onSaved: (value){
                
                 age = int.parse(value);
               },
                      
             ),
 
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
                 child: Text("Sedanter (Çok Az Aktivite)"),
               ),
              
                DropdownMenuItem(
                value: 1,
                 child: Text("Hafif (Haftada 1-3 Gün Egzersiz)"),
               ),

               DropdownMenuItem(
                 value: 2,
                 child: Text("Orta (Haftada 3-5 Gün Egzersiz)"),
               ),

                 DropdownMenuItem(
                 value: 3,
                 child: Text("Yoğun (Haftada 6-7 Gün Egzersiz)"),
               ),

                DropdownMenuItem(
                 value: 4,
                 child: Text("Çok Yüksek Düzey"),
               ),


              ],
            
              onChanged: (value){
                store.valueOfCalculatorProtein = value;
                StoreProvider.of<AppState>(context).dispatch(ValueOfCalculatorProtein);
                
                Fluttertoast.showToast(msg:"Hesapla Tuşuna Basın",backgroundColor: Colors.blue.shade300,fontSize: 22,gravity: ToastGravity.CENTER);
                
                switch(value){
                  case 0:
                    coefficientCalorie =1.2;
                  break;

                  case 1:
                   coefficientCalorie = 1.3;
            
                  break;

                  case 2:
                   coefficientCalorie =1.4;
                
                  break;

                  case 3:
                   coefficientCalorie =1.7;
                 
                  break;

                  case 4:
                   coefficientCalorie =1.85;
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

                 /// Erkek İçin
                  if(age>=15 && age<18){
                    if(store.valueOfCalculatorProtein==0){
                      bmh=((17.6)*(weight.toDouble()))+656.0;
                      calori = (bmh*1.2).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==1){
                      bmh=((17.6)*(weight.toDouble()))+656.0;
                      calori = (bmh*1.3).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==2){
                      bmh=((17.6)*(weight.toDouble()))+656.0;
                      calori = (bmh*1.2).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==3){
                      bmh=((17.6)*(weight.toDouble()))+656.0;
                      calori = (bmh*1.7).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==4){
                      bmh=((17.6)*(weight.toDouble()))+656.0;
                      calori = (bmh*1.85).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }


                  }
                  else if(age>=18 && age<30){

                    if(store.valueOfCalculatorProtein==0){
                      bmh=((15.0)*(weight.toDouble()))+690.0;
                      calori = (bmh*1.2).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==1){
                      bmh=((15.0)*(weight.toDouble()))+690.0;
                      calori = (bmh*1.3).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==2){
                      bmh=((15.0)*(weight.toDouble()))+690.0;
                      calori = (bmh*1.2).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==3){
                      bmh=((15.0)*(weight.toDouble()))+690.0;
                      calori = (bmh*1.7).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==4){
                      bmh=((15.0)*(weight.toDouble()))+690.0;
                      calori = (bmh*1.85).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }

                  }else if(age>=30 && age<60){

                       if(store.valueOfCalculatorProtein==0){
                      bmh=((11.4)*(weight.toDouble()))+870.0;
                      calori = (bmh*1.2).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==1){
                      bmh=((11.4)*(weight.toDouble()))+870.0;
                      calori = (bmh*1.3).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==2){
                      bmh=((11.4)*(weight.toDouble()))+870.0;
                      calori = (bmh*1.2).round();
                       store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==3){
                      bmh=((11.4)*(weight.toDouble()))+870.0;
                      calori = (bmh*1.7).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==4){
                      bmh=((11.4)*(weight.toDouble()))+870.0;
                      calori = (bmh*1.85).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }





                  }else if(age>=60){
                    
                       if(store.valueOfCalculatorProtein==0){
                      bmh=((11.7)*(weight.toDouble()))+535.0;
                      calori = (bmh*1.2).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==1){
                       bmh=((11.7)*(weight.toDouble()))+535.0;
                      calori = (bmh*1.3).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==2){
                      bmh=((11.7)*(weight.toDouble()))+535.0;
                      calori = (bmh*1.2).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==3){
                       bmh=((11.7)*(weight.toDouble()))+535.0;
                      calori = (bmh*1.7).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==4){
                       bmh=((11.7)*(weight.toDouble()))+535.0;
                      calori = (bmh*1.85).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }

                  }
                
                },
              ),

            // Results
              Card(
                    elevation: 0,
                    child: ListTile(
                      title: Text(store.resultOfCalorie.toString(),textScaleFactor: 2.2,),
                    )
                  ),
            
 
            ],
          ),
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



class CalorieNeedWomen{


 Widget calorieNeed(BuildContext mainContext){


  final _formKey = GlobalKey<FormState>();
  int age=0;
  int weight = 0;
  int calori=0;
  double bmh=0;
  double coefficientCalorie;
  
  
  return StoreConnector<AppState,AppState>(
      converter: (store)=>store.state,
      builder: (context,store){



        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              // Yaş
             TextFormField(
               decoration: InputDecoration(hintText: "Yaş",helperText: "15 ve üstü"),
               keyboardType: TextInputType.numberWithOptions(signed: true,decimal: false),
               inputFormatters:<TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
              validator:  (store){
                if(int.parse(store)>15){
                  return null;
                }
                return "Hatalı Yaş";
              },
               onSaved: (value){
                
                 age = int.parse(value);
               },
                      
             ),
 
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
                 child: Text("Sedanter (Çok Az Aktivite)"),
               ),
              
                DropdownMenuItem(
                value: 1,
                 child: Text("Hafif (Haftada 1-3 Gün Egzersiz)"),
               ),

               DropdownMenuItem(
                 value: 2,
                 child: Text("Orta (Haftada 3-5 Gün Egzersiz)"),
               ),

                 DropdownMenuItem(
                 value: 3,
                 child: Text("Yoğun (Haftada 6-7 Gün Egzersiz)"),
               ),

                DropdownMenuItem(
                 value: 4,
                 child: Text("Çok Yüksek Düzey"),
               ),


              ],
            
              onChanged: (value){
                store.valueOfCalculatorProtein = value;
                StoreProvider.of<AppState>(context).dispatch(ValueOfCalculatorProtein);
                
                Fluttertoast.showToast(msg:"Hesapla Tuşuna Basın",backgroundColor: Colors.blue.shade300,fontSize: 22,gravity: ToastGravity.CENTER);
                
                switch(value){
                  case 0:
                    coefficientCalorie =1.2;
                  break;

                  case 1:
                   coefficientCalorie = 1.3;
            
                  break;

                  case 2:
                   coefficientCalorie =1.4;
                
                  break;

                  case 3:
                   coefficientCalorie =1.7;
                 
                  break;

                  case 4:
                   coefficientCalorie =1.85;
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

                 /// Kadın İçin
                  if(age>=15 && age<18){
                    if(store.valueOfCalculatorProtein==0){
                      bmh=((13.3)*(weight.toDouble()))+690.0;
                      calori = (bmh*1.2).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==1){
                       bmh=((13.3)*(weight.toDouble()))+690.0;
                      calori = (bmh*1.3).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==2){
                      bmh=((13.3)*(weight.toDouble()))+690.0;
                      calori = (bmh*1.2).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==3){
                      bmh=((13.3)*(weight.toDouble()))+690.0;
                      calori = (bmh*1.6).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==4){
                       bmh=((13.3)*(weight.toDouble()))+690.0;
                      calori = (bmh*1.85).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }


                  }
                  else if(age>=18 && age<30){

                    if(store.valueOfCalculatorProtein==0){
                      bmh=((14.8)*(weight.toDouble()))+485.0;
                      calori = (bmh*1.2).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==1){
                      bmh=((14.8)*(weight.toDouble()))+485.0;
                      calori = (bmh*1.3).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==2){
                      bmh=((14.8)*(weight.toDouble()))+485.0;
                      calori = (bmh*1.2).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==3){
                      bmh=((14.8)*(weight.toDouble()))+485.0;
                      calori = (bmh*1.6).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==4){
                      bmh=((14.8)*(weight.toDouble()))+485.0;
                      calori = (bmh*1.85).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }

                  }else if(age>=30 && age<60){

                       if(store.valueOfCalculatorProtein==0){
                      bmh=((8.1)*(weight.toDouble()))+842.0;
                      calori = (bmh*1.2).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==1){
                      bmh=((8.1)*(weight.toDouble()))+842.0;
                      calori = (bmh*1.3).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==2){
                      bmh=((8.1)*(weight.toDouble()))+842.0;
                      calori = (bmh*1.2).round();
                       store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==3){
                      bmh=((8.1)*(weight.toDouble()))+842.0;
                      calori = (bmh*1.6).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==4){
                       bmh=((8.1)*(weight.toDouble()))+842.0;
                      calori = (bmh*1.85).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }





                  }else if(age>=60){
                    
                       if(store.valueOfCalculatorProtein==0){
                      bmh=((9.0)*(weight.toDouble()))+656.0;
                      calori = (bmh*1.2).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==1){
                      bmh=((9.0)*(weight.toDouble()))+656.0;
                      calori = (bmh*1.3).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==2){
                     bmh=((9.0)*(weight.toDouble()))+656.0;
                      calori = (bmh*1.2).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==3){
                       bmh=((9.0)*(weight.toDouble()))+656.0;
                      calori = (bmh*1.6).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }
                    if(store.valueOfCalculatorProtein==4){
                      bmh=((9.0)*(weight.toDouble()))+656.0;
                      calori = (bmh*1.85).round();
                      store.resultOfCalorie = calori;
                       StoreProvider.of<AppState>(context).dispatch(CaloriNeed);
                    }

                  }
                
                },
              ),

            // Results
              Card(
                    elevation: 0,
                    child: ListTile(
                      title: Text(store.resultOfCalorie.toString(),textScaleFactor: 2.2,),
                    )
                  ),
            
 
            ],
          ),
      ),
        );}
  ); 
}

}