import 'package:cloud_firestore/cloud_firestore.dart';

Future addOneToReviewNumberBlog(DocumentSnapshot data) async {
  String title = data.data["Başlık"];
  DocumentSnapshot reviewData =
      await Firestore.instance.collection("Statistics").document("Blog").get();
  bool reviewNumber = reviewData.data.containsKey(title);

  if (reviewNumber) {
    int review = reviewData.data[title] + 1;
    reviewData.reference.updateData({title: review});
  }
  if (!reviewNumber) {
    reviewData.reference.setData({title: 1}, merge: true);
  }
}

Future addOneToReviewNumberRecipe(DocumentSnapshot doc) async {
  String title = doc.data["Tarifinİsmi"];
  DocumentSnapshot reviewData =
      await Firestore.instance.collection("Statistics").document("Tarif").get();
  bool reviewNumber = reviewData.data.containsKey(title);

  if (reviewNumber) {
    int review = reviewData.data[title] + 1;
    reviewData.reference.updateData({title: review});
  }
  if (!reviewNumber) {
    reviewData.reference.setData({title: 1}, merge: true);
  }
}

Future<void> addSSSGainWeight() async {
  DocumentSnapshot reviewData = await Firestore.instance
      .collection("Statistics")
      .document("KiloAlma")
      .get();
  bool reviewNumber = reviewData.data.containsKey("reviewNumber");

  if (reviewNumber) {
    int review = reviewData.data["reviewNumber"] + 1;
    reviewData.reference.updateData({"reviewNumber": review});
  }
  if (!reviewNumber) {
    reviewData.reference.setData({"reviewNumber": 1}, merge: true);
  }
}

Future addSSSLooseWeight() async {
  DocumentSnapshot reviewData = await Firestore.instance
      .collection("Statistics")
      .document("KiloVerme")
      .get();
  bool reviewNumber = reviewData.data.containsKey("reviewNumber");

  if (reviewNumber) {
    int review = reviewData.data["reviewNumber"] + 1;
    reviewData.reference.updateData({"reviewNumber": review});
  }
  if (!reviewNumber) {
    reviewData.reference.setData({"reviewNumber": 1}, merge: true);
  }
}

Future addSSSHealthyLife() async {
  DocumentSnapshot reviewData = await Firestore.instance
      .collection("Statistics")
      .document("SağlıklıYaşam")
      .get();
  bool reviewNumber = reviewData.data.containsKey("reviewNumber");

  if (reviewNumber) {
    int review = reviewData.data["reviewNumber"] + 1;
    reviewData.reference.updateData({"reviewNumber": review});
  }
  if (!reviewNumber) {
    reviewData.reference.setData({"reviewNumber": 1}, merge: true);
  }
}

Future addSSSInterestingInfos() async {
  DocumentSnapshot reviewData = await Firestore.instance
      .collection("Statistics")
      .document("ŞaşırtanBilgiler")
      .get();
  bool reviewNumber = reviewData.data.containsKey("reviewNumber");

  if (reviewNumber) {
    int review = reviewData.data["reviewNumber"] + 1;
    reviewData.reference.updateData({"reviewNumber": review});
  }
  if (!reviewNumber) {
    reviewData.reference.setData({"reviewNumber": 1}, merge: true);
  }
}

Future addSSSFalseKnewTrue() async {
  DocumentSnapshot reviewData = await Firestore.instance
      .collection("Statistics")
      .document("DoğruBilinenYanlışlar")
      .get();
  bool reviewNumber = reviewData.data.containsKey("reviewNumber");

  if (reviewNumber) {
    int review = reviewData.data["reviewNumber"] + 1;
    reviewData.reference.updateData({"reviewNumber": review});
  }
  if (!reviewNumber) {
    reviewData.reference.setData({"reviewNumber": 1}, merge: true);
  }
}

Future addNumberGuideOfNutrition() async {
  DocumentSnapshot reviewData = await Firestore.instance
      .collection("Statistics")
      .document("BeslenmeRehberi")
      .get();
  bool reviewNumber = reviewData.data.containsKey("reviewNumber");

  if (reviewNumber) {
    int review = reviewData.data["reviewNumber"] + 1;
    reviewData.reference.updateData({"reviewNumber": review});
  }
  if (!reviewNumber) {
    reviewData.reference.setData({"reviewNumber": 1}, merge: true);
  }
}

Future addNumberFitPlates() async {
  DocumentSnapshot reviewData = await Firestore.instance
      .collection("Statistics")
      .document("DengeliTabaklar")
      .get();
  bool reviewNumber = reviewData.data.containsKey("reviewNumber");

  if (reviewNumber) {
    int review = reviewData.data["reviewNumber"] + 1;
    reviewData.reference.updateData({"reviewNumber": review});
  }
  if (!reviewNumber) {
    reviewData.reference.setData({"reviewNumber": 1}, merge: true);
  }
}

Future addNumberAboutUs() async {
  DocumentSnapshot reviewData = await Firestore.instance
      .collection("Statistics")
      .document("Hakkımızda")
      .get();
  bool reviewNumber = reviewData.data.containsKey("reviewNumber");

  if (reviewNumber) {
    int review = reviewData.data["reviewNumber"] + 1;
    reviewData.reference.updateData({"reviewNumber": review});
  }
  if (!reviewNumber) {
    reviewData.reference.setData({"reviewNumber": 1}, merge: true);
  }
}



Future addNumberQandA() async {
  DocumentSnapshot reviewData = await Firestore.instance
      .collection("Statistics")
      .document("SoruCevap")
      .get();
  bool reviewNumber = reviewData.data.containsKey("reviewNumber");

  if (reviewNumber) {
    int review = reviewData.data["reviewNumber"] + 1;
    reviewData.reference.updateData({"reviewNumber": review});
  }
  if (!reviewNumber) {
    reviewData.reference.setData({"reviewNumber": 1}, merge: true);
  }
}
