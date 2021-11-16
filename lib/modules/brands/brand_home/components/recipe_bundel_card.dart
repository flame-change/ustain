import 'package:aroundus_app/modules/brands/brand_home/models/RecipeBundel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RecipeBundelCard extends StatelessWidget {
  final RecipeBundle? recipeBundle;
  final Function()? press;

  const RecipeBundelCard({this.recipeBundle, this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: recipeBundle!.color,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20), //20
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Text(
                      recipeBundle!.title!,
                      style: TextStyle(color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      recipeBundle!.description!,
                      style: TextStyle(color: Colors.white54),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    buildInfoRow(
                      text: "${recipeBundle!.recipes!} Recipes",
                    ),
                    SizedBox(height: 5), //5
                    buildInfoRow(
                      text: "${recipeBundle!.chefs!} Chefs",
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(width: 5), //5
          ],
        ),
      ),
    );
  }

  Row buildInfoRow({text}) {
    return Row(
      children: <Widget>[
        Image.network('https://picsum.photos/200/200/',
            repeat: ImageRepeat.noRepeat),
        SizedBox(width: 10), // 10
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
