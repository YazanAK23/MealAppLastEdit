  import 'package:flutter/material.dart';
  import 'package:transparent_image/transparent_image.dart';
  import 'package:meal_app/models/meal.dart';

  class MealItem extends StatelessWidget {
    const MealItem({super.key, required this.meal, required this.onSelectedMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectedMeal;

    String get complexityText {
      switch (meal.complexity) {
        case Complexity.simple:
          return 'simple';
        case Complexity.challenging:
          return 'challenging';
        case Complexity.hard:
          return 'hard';
        default:
          return 'Unknown';
      }
    }

    String get affordabilityText {
      switch (meal.affordability) {
        case Affordability.affordable:
          return 'affordable';
        case Affordability.pricey:
          return 'pricey';
        case Affordability.luxurious:
          return 'luxurious';
        default:
          return 'Unknown';
      }
    }

    @override
    Widget build(BuildContext context) {
      return Card(
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        child: InkWell(
          onTap: ()=> onSelectedMeal(meal),
          child: Stack(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                  color: Colors.black54,
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.schedule),
                              SizedBox(width: 6),
                              Text("${meal.duration} min",style: TextStyle(color: Colors.white),),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.work),
                              SizedBox(width: 6),
                              Text("$complexityText",style: TextStyle(color: Colors.white),),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.attach_money),
                              SizedBox(width: 6),
                              Text("$affordabilityText", style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
