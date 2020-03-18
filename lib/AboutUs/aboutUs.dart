import 'package:beslenme/Operations/viewNumber.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AboutUsPage extends StatefulWidget {
  AboutUsPage({Key key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  ///
  /// Local Değişkenlerimiz.
  ///
  final fireStoreGet = Firestore.instance;
  Map _aboutUsData = {"Biz Kimiz": " ", "Sorumluluk Reddi": " "};

  @override
  void initState() {
    _aboutUsData = {"Biz Kimiz": " ", "Sorumluluk Reddi": " "};

    ///
    /// Firebase Bağlantısı burada sağlanmakta.
    /// About Us kısmından gerekli datayı alıyoruz.
    /// Sonra local değişkene bağlanıyor.
    ///
    fireStoreGet
        .collection("/BeslenmeApp/AllDatas/Hakkımızda")
        .document("HakkımızdaDocument")
        .get()
        .then((ds) {
      setState(() {
        _aboutUsData = ds.data;
      });
    });
    try {
      addNumberAboutUs();
    } catch (e) {
      print(e);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green.shade100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            ///
            /// Üst Bar ve Geri Tuşu
            ///
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Text(
                    "Biz Kimiz?",
                    textScaleFactor: 1.25,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            ///
            /// Takım Resmi burada koyulacak...
            ///
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    child: Image.asset(
                  "assets/AboutUs/team.jpeg",
                )),
              ),
            ),

            ///
            /// Biz Kimiz Yazısı
            ///
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  child: Text(
                "Herkese merhaba, Teknolojinin bu derece ilerlediği bir dönemde her konuda olduğu gibi beslenme hakkında da birçok bilgi hemen elimizin altında oluyor. Peki bunca bilgi arasında hangisi doğru ya da sağlımız için tercih edilebilir? Bunu ayırt etmek zor değil mi?  Biz de 3 mühendis ve 5 diyetisyen olarak bunca bilgi kirliliği arasında sağlıklı beslenmeyi doğru bir şekilde sizlere aktarmak için yola çıktık. Bu uzun yolculukta önceliğimiz her zaman doğru bilgileri ve sağlıklı lezzetleri sizlere ulaştırmak olacak. Beslenme ile ilgili merak ettikleriniz, gündemde olanlar, uzun zamandır tartışılanlar, hızla hazırlamak zorunda kaldığınız öğünler için alternatifler, hem sağlıklı hem düşük kalorili fit tatlar, sağlıklı kilo almak için yüksek kalorili tarifler, dengeli tabak örnekleri ve daha fazlası için bizi takipte kalın.",
                style: TextStyle(fontSize: 14),
                textScaleFactor: 1.5,
              )),
            ),

            ///
            /// Sayfa Boşluğu
            ///
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),

            ///
            /// Sorumluluk Reddi
            ///
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: (MediaQuery.of(context).size.width * 0.23)),
              child: RaisedButton(
                child: Text(
                  "SorumlulukReddi",
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              child: ListView(
                                children: <Widget>[
                                  Text(
                                    "Diyetin uygulaması, tıbbi beslenme tavsiyeleri vermek niyetinde olmayıp, amacı sizlere sadece sağlıklı beslenme ile ilgili aradıklarınızı alakalı içeriklerimiz ile ilgili konuyu daha kolay anlamanızı sağlayacak şekilde bilgi vermektir. Vermiş olduğumuz tüm bilgiler kaynakları ile beraber yer almakta olup bu bilgilerde belirtilmiş veya ima edilmiş her türlü hata, eksiklik ya da uyuşmazlık konusunda herhangi bir sorumluluğu ve bunlardan kaynaklanabilecek doğrudan ya da dolaylı zarar veya kayıpların sorumluluğunu reddetmekteyiz.  Özel tıbbi beslenme tavsiyeleri sitemiz ve uygulamamız üzerinden verilmemekte olup, kişisel beslenme ve sağlık sorunlarınız için ilgili doktor ve diyetisyene başvurmanız önerilmektedir.",
                                    textScaleFactor: 1.5,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: RaisedButton(
                                      child: Text("Kapat"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
