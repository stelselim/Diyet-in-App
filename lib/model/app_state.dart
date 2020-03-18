import 'package:flutter/foundation.dart';


class AppState{
  Map dataOfRecipeReading;
  Map  dataOfBlogReading;
  int fontSizeOfReadings;
  double resultsOfBMI;
  int resultsOfProtein;
  int resultOfWalkCalorie;
  int resultOfCalorie;


  int valueOfCalculatorProtein;

  AppState({ 
    @required this.fontSizeOfReadings,
    @required this.dataOfBlogReading,
    @required this.dataOfRecipeReading,
    this.resultOfCalorie,
    this.resultOfWalkCalorie,
    this.resultsOfBMI,
    this.valueOfCalculatorProtein,
    this.resultsOfProtein,

    });

  AppState.fromAppState(AppState another){
    resultOfCalorie = another.resultOfCalorie;
    resultOfWalkCalorie=another.resultOfWalkCalorie;
    fontSizeOfReadings = another.fontSizeOfReadings;
    dataOfRecipeReading = another.dataOfRecipeReading;
    dataOfBlogReading = another.dataOfBlogReading;
    resultsOfBMI = another.resultsOfBMI;
    valueOfCalculatorProtein = another.valueOfCalculatorProtein;
    resultsOfProtein =another.resultsOfProtein;

  }

}