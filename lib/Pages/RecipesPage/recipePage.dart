import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecipePage extends StatefulWidget {
  RecipePage({Key key}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    final _screenWidth = MediaQuery.of(context).size.width;
    final _textScaleFactor = MediaQuery.of(context).textScaleFactor;

    final appBarTextStyle = TextStyle(
        color: Colors.black87,
        fontSize: _textScaleFactor * 25,
        fontWeight: FontWeight.w500);

    final recipeCategoryTextStyle = TextStyle(
        color: Colors.black87,
        fontSize: _textScaleFactor * 17,
        fontWeight: FontWeight.w700);

    return Container(
      color: Colors.white10,
      child: ListView(
        children: <Widget>[
          // AppBar
          AppBar(
            title: Text("Tarifler", style: appBarTextStyle),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0.8,
            actions: <Widget>[
              // Search Button
              /* IconButton(
                icon: Icon(
                  FontAwesomeIcons.search,
                  color: Colors.black54,
                  size: _screenWidth * 0.07,
                ),
                onPressed: () {},
              ), */
            ],
          ),

          // Categories
          GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 5,
                childAspectRatio: 0.95),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              ///
              ///Her Bir Kartın Düzenlenmesi gerekmekte ve her kart için yeni bir sayfa oluşturulması gerekiyor. Bunları sağlayıp düzenleyip, Tarif kısmının büyük bir kısmı bitmiş olacak.
              ///

              // Low Kalorili Tarifler
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "lowCalorieRecipe");
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: _screenHeight * 0.01),
                        Text(
                          "Düşük Kalorili",
                          style: recipeCategoryTextStyle,
                        ),
                        SizedBox(height: _screenHeight * 0.01),
                        Card(
                          child: Container(
                            //width: MediaQuery.of(context).size.width*0.2,
                            height: _screenHeight * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/Recipe/CategoryPics/LowCalorie.jpeg"),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // High Calorie
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "HighCalorie");
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: _screenHeight * 0.01),
                        Text(" Yüksek Kalorili",
                            style: recipeCategoryTextStyle),
                        SizedBox(height: _screenHeight * 0.01),
                        Card(
                          child: Container(
                            //width: MediaQuery.of(context).size.width*0.2,
                            height: _screenHeight * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/Recipe/CategoryPics/HighCalorie.jpeg"),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Student
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "Student");
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: _screenHeight * 0.01),
                        Text("Öğrencilere Özel",
                            style: recipeCategoryTextStyle),
                        SizedBox(height: _screenHeight * 0.01),
                        Card(
                          child: Container(
                            //width: MediaQuery.of(context).size.width*0.2,
                            height: _screenHeight * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/Recipe/CategoryPics/student.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //Fast And Daily
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "FastAndDaily");
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: _screenHeight * 0.01),
                        Text("Hızlı Tarifler", style: recipeCategoryTextStyle),
                        SizedBox(height: _screenHeight * 0.01),
                        Card(
                          child: Container(
                            //width: MediaQuery.of(context).size.width*0.2,
                            height: _screenHeight * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/Recipe/CategoryPics/Fast.jpeg"),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Looking New
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "LookingNew");
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: _screenHeight * 0.01),
                        Text("Değişiklik Arayanlar",
                            style: recipeCategoryTextStyle),
                        SizedBox(height: _screenHeight * 0.01),
                        Card(
                          child: Container(
                            //width: MediaQuery.of(context).size.width*0.2,
                            height: _screenHeight * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/Recipe/CategoryPics/LookingNew.jpeg"),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Fit Tatlılar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "FitDeserts");
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: _screenHeight * 0.01),
                        Text(" Fit Tatlılar", style: recipeCategoryTextStyle),
                        SizedBox(height: _screenHeight * 0.01),
                        Card(
                          child: Container(
                            //width: MediaQuery.of(context).size.width*0.2,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/Recipe/CategoryPics/Recipe.jpeg"),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
