import 'package:beslenme/AboutUs/aboutUs.dart';
import 'package:beslenme/Calculators/CalculatorMain.dart';
import 'package:beslenme/Dengeli/dengeliTabak.dart';
import 'package:beslenme/Library/library.dart';
import 'package:beslenme/Pages/BlogPage/blogReadingPage.dart';
import 'package:beslenme/Pages/HomePage/homepage.dart';
import 'package:beslenme/Pages/RecipesPage/RecipeCategories/FastAndDaily.dart';
import 'package:beslenme/Pages/RecipesPage/RecipeCategories/FitDeserts.dart';
import 'package:beslenme/Pages/RecipesPage/RecipeCategories/HighCalorie.dart';
import 'package:beslenme/Pages/RecipesPage/RecipeCategories/LookingNew.dart';
import 'package:beslenme/Pages/RecipesPage/RecipeCategories/LowCalorie.dart';
import 'package:beslenme/Pages/RecipesPage/RecipeCategories/Student.dart';
import 'package:beslenme/Pages/RecipesPage/recipeReadingPage.dart';
import 'package:beslenme/Rehber/GuideReading.dart';
import 'package:beslenme/Rehber/askUs.dart';
import 'package:beslenme/Rehber/rehber.dart';

import 'package:flutter/material.dart';
import 'package:beslenme/model/app_state.dart';
import 'package:beslenme/redux/reducers.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  final _initialState = AppState(
      dataOfBlogReading: {
        "Başlık": "",
        "İçerik Yazısı": """  """,
        "Yazar": " "
      },
      dataOfRecipeReading: {},
      fontSizeOfReadings: 15,
      resultsOfBMI: 0,
      resultOfCalorie: 0,
      resultOfWalkCalorie: 0);
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);

  runApp(MyApp(store: _store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green),
        home: HomePage(),
        routes: {
          // New Pages are gonna add below
          // Recipe Pages Routes are located below
          "lowCalorieRecipe": (context) => LowCalorie(),
          "FitDeserts": (context) => FitDesert(),
          "HighCalorie": (context) => HighCalorie(),
          "LookingNew": (context) => LookingNew(),
          "Student": (context) => Student(),
          "FastAndDaily": (context) => FastAndDaily(),

          // Recipe Reading page, this is a just single page, but it takes a parameter which indicates the page where you selected.
          "recipeReadingPage": (context) => RecipeReadingPage(),

          // Blog Reading page,
          "blogReadingPage": (context) => BlogReadingPage(),

          // Calculator Main
          "CalculatorMain": (context) => CalculatorMain(),

          //Dengeli ve Rehber
          "Rehber": (context) => RehberPage(),
          "GuideReadingPage":(context)=>GuideReadingPage(data: null),
          "Dengeli": (context) => DengeliPage(),

          //About Us
          "AboutUs": (context) => AboutUsPage(),

          //Bize Sorun
          "BizeSorun": (context) => AskToUs(),

          //Library Page
          "LibraryPage": (context) => LibraryPage()
        },
      ),
    );
  }
}

// Animation for Recipe Reading Page
Route recipeReadingRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        RecipeReadingPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var curve = Curves.ease;

      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
