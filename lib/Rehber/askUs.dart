import 'package:beslenme/Operations/viewNumber.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AskToUs extends StatelessWidget {
  const AskToUs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String question;
    String header;

    final _formKey = GlobalKey<FormState>();

    var questionForm = Form(
      key: _formKey,
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Bizlere Diyet-in hakkında sorular sorabilirsiniz, uygulamayla ilgili fikirlerinizi belirtip gelecekte görmek istediğiniz konseptleri yazabilirsiniz. Sizden bolca geri dönüş bekliyoruz!",
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
              textScaleFactor: 1.3,
              textAlign: TextAlign.center,
            ),
          ),
          // Soru
          Container(
            margin: EdgeInsets.all(15),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  maxLines: 3,
                  toolbarOptions: ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  autocorrect: true,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Konu"),
                  keyboardType: TextInputType.text,
                  validator: (store) {
                    if (store.length == 0) {
                      return "Gerekli Alan";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    header = value;
                  },
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(15),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  toolbarOptions: ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Soru",
                  ),
                  keyboardType: TextInputType.text,
                  validator: (store) {
                    if (store.length == 0) {
                      return "Gerekli Alan";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    question = value;
                  },
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.3,
                vertical: 25),
            child: RaisedButton(
              child: Text("Sorumu Gönder"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  Firestore.instance.collection("/FromUsers").add({
                    "EklenmeTarihi": DateTime.now(),
                    "Konu": header,
                    "Soru": question,
                  });

                  Fluttertoast.showToast(msg: "Sorun Başarıyla Yollandı");
                }
              },
            ),
          ),
        ],
      ),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black87,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text("Soru Cevap",
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w500),
                textScaleFactor: 1.5),
            bottom: TabBar(
              labelColor: Colors.blue,
              indicatorColor: Colors.green,
              tabs: [
                Tab(
                  iconMargin: EdgeInsets.all(3),
                  child: Text(
                    "Cevaplar",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  icon: Icon(
                    Icons.question_answer,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  iconMargin: EdgeInsets.all(3),
                  child: Text(
                    "Soru Sor",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.questionCircle,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AnswerBody(),
              questionForm,
            ],
          )),
    );
  }
}

class AnswerBody extends StatelessWidget {
  const AnswerBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade100,
      child: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("/FromUsers/Answered/AnsweredQuestions")
                .orderBy("EklenmeTarihi")
                .getDocuments()
                .asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                  child: Text("Bir Hata Oluştu"),
                );
              if (snapshot.data == null)
                return Center(
                  child: CircularProgressIndicator(),
                );
              try {
                addNumberQandA();
              } catch (e) {
                print(e);
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return AnsweredQuestionCards(
                      data: snapshot.data.documents.elementAt(index));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class AnsweredQuestionCards extends StatelessWidget {
  final DocumentSnapshot data;
  const AnsweredQuestionCards({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: data.data["Cevap"].length > 220
          ? MediaQuery.of(context).size.height * 0.46
          : MediaQuery.of(context).size.height * 0.37,
      //  margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ListTile(
              title: Text(
                "${data.data["Konu"]}",
                textScaleFactor: 1.2,
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                "${data.data["Soru"]}",
                textAlign: TextAlign.center,
                textScaleFactor: 1,
              ),
              trailing: Icon(FontAwesomeIcons.questionCircle),
            ),
            ListTile(
              title: Text(
                "${data.data["Cevap"]}",
                textAlign: TextAlign.center,
                textScaleFactor: 1,
              ),
              trailing: Icon(Icons.question_answer),
            ),
          ],
        ),
      ),
    );
  }
}
