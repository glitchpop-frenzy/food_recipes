import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  CategoryMealScreen(this.availableMeals);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  bool _loadedInitState = false;
  Color categoryColor;
  List<Meal> displayedMeals;
  String categoryTitle;

  @override
  void didChangeDependencies() {
    if (!_loadedInitState) {
      final finalArgs = ModalRoute.of(context).settings.arguments as List;
      final String categoryId = finalArgs[0];
      categoryTitle = finalArgs[1];
      categoryColor = finalArgs[2];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList(); // returns a list of those meals in DUMMY_MEALS class whose categoriesId includes categoryId.
      _loadedInitState = true;
    }

    super.didChangeDependencies();
  }

  void removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => mealId == meal.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: categoryColor,
          title: Text(
            categoryTitle,
          ),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
              duration: displayedMeals[index].duration,
              //removeItem: removeMeal,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
