import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/meal.dart';
import '../main.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFavorites;
  final Function isFavorite;
  static const routeName = '/meal-detail';

  MealDetailScreen(this.toggleFavorites, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Text(
          text,
          style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }

  Widget buildContainer(Widget child, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: Colors.tealAccent,
            boxShadow: [
              BoxShadow(
                  color: Colors.pink[200],
                  blurRadius: 2.6,
                  offset: Offset.fromDirection(10),
                  spreadRadius: 3.5),
            ],
            border: Border.all(color: Colors.pinkAccent),
            borderRadius: BorderRadius.circular(10)),
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.8,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    final AppBar appbar = AppBar(
      title: Text('${selectedMeal.title}'),
    );

    //final mediaquery = MediaQuery.of(context);

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: (MediaQuery.of(context).size.height -
                    appbar.preferredSize.height) *
                0.4,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: buildSectionTitle(context, 'Ingredients')),
          buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Container(
                    // padding: EdgeInsets.all(3),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.limeAccent,
                        child: Text('# ${index + 1}'),
                      ),
                      title: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(color: Colors.white60),
                        child: Text(
                          '${selectedMeal.ingredients[index]}',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ),
                    //margin: EdgeInsets.symmetric(vertical: 5.0)),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              ),
              context),
          Divider(
            thickness: 3,
            color: Colors.black38,
            indent: 15,
            endIndent: 15,
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: buildSectionTitle(context, 'Steps to follow')),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: buildContainer(
                Container(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return Container(
                        margin: EdgeInsets.all(1),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              '# ${index + 1} ',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            backgroundColor: Colors.limeAccent,
                          ),
                          title: Container(
                            decoration: BoxDecoration(color: Colors.white60),
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              '${selectedMeal.steps[index]}',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: selectedMeal.steps.length,
                  ),
                ),
                context),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border),
          onPressed: () => toggleFavorites(mealId)),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.delete),
      //   onPressed: () {},
      // ),
    );
  }
}
