import 'package:flutter/material.dart';
import 'achievement_page.dart';

class AchievementScreen extends StatefulWidget {
  static String routeName = 'achievement_screen';

  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  @override
  Widget build(BuildContext context) {
    return AchievementPage();
  }
}
