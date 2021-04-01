import 'package:flutter/material.dart';
import 'package:food_recipes/screens/meal_detail.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  //final Function removeItem;

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;

      case Complexity.Challenging:
        return 'Moderate';
        break;

      case Complexity.Hard:
        return 'Difficult';
        break;

      default:
        return 'unknown';
        break;
    }
  }

  int get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 1;
        break;
      case Affordability.Pricey:
        return 2;
        break;
      case Affordability.Luxurious:
        return 3;
        break;
      default:
        return 0;
        break;
    }
  }

  List<Widget> afford(int count) {
    return List.generate(count, (index) => Icon(Icons.money));
  }

  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    // this.removeItem
  });

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealDetailScreen.routeName, arguments: id)
        .then((result) {
      //if(result!=null)
      //removeItem(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Stack(children: <Widget>[
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Image.network(
                  imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            Positioned(
              bottom: 15,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                width: 250,
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                // decoration:
                //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 26, color: Colors.white),
                  softWrap:
                      true, // if softWrap is true then if text is long then it would adjust according to the space.
                  overflow: TextOverflow
                      .fade, // if text is still unadjustable then the remaining text will fade away.
                ),
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.schedule),
                    SizedBox(
                      width: 4,
                    ),
                    Text('$duration min')
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.work),
                    SizedBox(
                      width: 4,
                    ),
                    Text(complexityText)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.attach_money_rounded),
                    SizedBox(
                      width: 2,
                    ),
                    ...afford(affordabilityText)
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
