import 'package:beslenme/model/app_state.dart';
import './actions.dart';

AppState reducer(AppState prevState, dynamic action){
  AppState newState = AppState.fromAppState(prevState);

 
if(action is DataBlogReading){
    newState.dataOfBlogReading = action.payload;
  }else if (action is WalkCalorie){
    newState.resultOfWalkCalorie = action.payload;
  }
  else if (action is CaloriNeed){
    newState.resultOfWalkCalorie = action.payload;
  }
  else if (action is DataRecipeReading){
    newState.dataOfRecipeReading = action.payload;
  }
  else if (action is FontSizeOfReading){
    newState.fontSizeOfReadings = action.payload;
  }else if (action is BMICalculation){
    newState.resultsOfBMI = action.payload;
  }
  else if (action is ValueOfCalculatorProtein){
    newState.valueOfCalculatorProtein = action.payload;
  }
  else if (action is ProteinCalculation){
    newState.resultsOfProtein = action.payload;
  }



  return newState;
}

