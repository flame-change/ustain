import 'package:aroundus_app/modules/brands/brand_home/models/RecipeBundel.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';
import 'categories.dart';
import 'recipe_bundel_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Categories(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: recipeBundles.length,
                itemBuilder: (context, index) => RecipeBundelCard(
                  recipeBundle: recipeBundles[index],
                  press: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
