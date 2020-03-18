import 'dart:core';
import 'package:beslenme/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CalculateBMI {

static const textStyleOfTable = TextStyle(fontSize:15,letterSpacing: 1.5,fontWeight: FontWeight.w600);




  static int weight;
  static int height;
  static double resultOfBMI;

  Widget formOfBMI(BuildContext mainContext) {
    final _formKey = GlobalKey<FormState>();

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //Boy
              TextFormField(
                decoration: InputDecoration(hintText: "Boyunuz (cm)",helperText: "180 cm"),
                keyboardType: TextInputType.numberWithOptions(signed: true,decimal: false),
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                validator: (store) => validateHeight(store),
                onSaved: (value) {
                  height = int.tryParse(value);
                },
              ),

              // kilo
              TextFormField(
                decoration: InputDecoration(hintText: "Kilonuz (kg)",helperText: "78 kg"),
                keyboardType:TextInputType.numberWithOptions(signed: true,decimal: false),
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                validator: (store) => validateWeight(store),
                onSaved: (value) {
                  weight = int.tryParse(value);
                },
              ),

              RaisedButton(
                child: Text("Hesapla"),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    resultOfBMI =
                        calculateBMI(weight.toDouble(), height.toDouble());
                    resultOfBMI *= 100;
                    resultOfBMI = resultOfBMI.floorToDouble();
                    resultOfBMI /= 100;
                    state.resultsOfBMI = resultOfBMI;
                    StoreProvider.of<AppState>(context).dispatch(resultOfBMI);
                    print("Başarılı");
                  } else
                    Fluttertoast.showToast(msg: "işlem gerçekleştirilemedi");
                },
              ),

              Card(
                elevation: 0,
                child: ListTile(
                  subtitle: Text("Kategori için sağa tıklayın."),
                  trailing: IconButton(
                    icon: Icon(Icons.info_outline,),iconSize: MediaQuery.of(context).size.width*0.08,color: Colors.red.shade600,
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: Dialog(
                          
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              border: TableBorder.all(width: 0.9,color: Colors.black54),
                              children: [

                              
                                // BMI < 18.5
                                TableRow(

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                         alignment: Alignment.center,
                                         child: Text("<18.5",style: textStyleOfTable,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align( alignment: Alignment.center
                                      ,child: Text("Zayıf",style: textStyleOfTable,)),
                                    )
                                  ]
                                ),
                                TableRow(
                                  
                                  children: [
                                    
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("18.5-24.99",style: textStyleOfTable,),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                         alignment: Alignment.center,
                                         child: Text("Sağlıklı",style: textStyleOfTable,)),
                                    )
                                  ]
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align( alignment: Alignment.center
                                      ,child: Text("25-29.99",style: textStyleOfTable,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align( alignment: Alignment.center,child: Text("Hafif Şişman",style: textStyleOfTable,)),
                                    )
                                  ]
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align( alignment: Alignment.center,child: Text("30-34.99",style: textStyleOfTable,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align( alignment: Alignment.center,child: Text("1.Derece Obez",style: textStyleOfTable,)),
                                    )
                                  ]
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align( alignment: Alignment.center,child: Text("35-39.99",style: textStyleOfTable,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align( alignment: Alignment.center,child: Text("2.Derece Obez",style: textStyleOfTable,)),
                                    )
                                  ]
                                ),
                                TableRow(
                                  
                                  children: [
                                    Align( alignment: Alignment.center,child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(">40",style: textStyleOfTable,),
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align( alignment: Alignment.center,child: Text("Morbid Obez",style: textStyleOfTable,)),
                                    )
                                  ]
                                ),
                                
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  title: Text(
                    "${state.resultsOfBMI}",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                    textScaleFactor: 3,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  

  String validateWeight(value) {
    int _weight = int.tryParse(value);
    if (_weight < 160 && _weight > 25) {
      return null;
    }
    return "Geçersiz Değer";
  }

  String validateHeight(value) {
    int _height = int.tryParse(value);
    if (_height < 220 && _height > 120) {
      return null;
    }
    return "Geçersiz Değer";
  }

  double calculateBMI(double localWeight, double localHeight) {
    return localWeight / ((localHeight / 100) * localHeight / 100);
  }
}
