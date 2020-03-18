import 'package:beslenme/Calculators/calculateProteinNeed.dart';
import 'package:beslenme/model/app_state.dart';
import 'package:beslenme/redux/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CalculateWalkCalorie {
  Widget formOfWalkCalorie(BuildContext mainContext) {
    final _formKey = GlobalKey<FormState>();
    int kg=0;
    int dk=0;
    int calorie;

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Ağırlığınıza bağlı olarak tempolu bir yürüşte kaç dakikada kaç kalori yaktığınız hesaplayın."),
              // Dakika
           TextFormField(
             decoration: InputDecoration(hintText: "Yürüyüş Süresi (dk)",helperText: "0 - 60 dk Arası"),
             keyboardType: TextInputType.numberWithOptions(signed: true,decimal: false),
             inputFormatters:<TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
            validator:  (store){
              if(int.parse(store)<=60){
                return null;
              }
              return "Maksimum 60 Dakika";
            },
             onSaved: (value){
              
               dk = int.parse(value);
             },
                    
           ),
            
              // Kilo
              TextFormField(
                decoration: InputDecoration(hintText: "Kilonuz (kg)",helperText: "50 - 100 kg Arası"),
                keyboardType: TextInputType.numberWithOptions(signed: true,decimal: false),
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                 validator:  (store)=>validateWeight(store),
                onSaved: (value) {
                  kg = int.parse(value);
                },
              ),

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

                if(kg<=62){
                  calorie = (((dk).toDouble())*8.5).round();
                }else if(kg>62 && kg<=65){
                  calorie = (((dk).toDouble())*8.9).round();
                }else if(kg>65 && kg<=68){
                  calorie = (((dk).toDouble())*9.3).round();
                }else if(kg>68 && kg<=71){
                  calorie = (((dk).toDouble())*9.8).round();
                }else if(kg>71 && kg<=74){
                  calorie = (((dk).toDouble())*10.1).round();
                }else if(kg>74 && kg<=77){
                  calorie = (((dk).toDouble())*10.6).round();
                }else if(kg>77 && kg<=80){
                  calorie = (((dk).toDouble())*10.9).round();
                }else if(kg>80 && kg<=83){
                  calorie = (((dk).toDouble())*11.4).round();
                }else if(kg>83 && kg<=86){
                  calorie = (((dk).toDouble())*11.8).round();
                }else if(kg>86 && kg<=89){
                  calorie = (((dk).toDouble())*12.2).round();
                }else if(kg>89 && kg<=92){
                  calorie = (((dk).toDouble())*12.6).round();
                }else if(kg>92){
                  calorie = (((dk).toDouble())*12.6).round();
                }

                state.resultOfWalkCalorie = calorie;
                 StoreProvider.of<AppState>(context).dispatch(WalkCalorie);
              },
            ),

              Card(
                elevation: 0,
                child: Text(
                  "${state.resultOfWalkCalorie}",
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  textScaleFactor: 3,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
