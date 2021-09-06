import 'package:aroundus_app/modules/home/home.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/magazine_home.dart';
import 'package:aroundus_app/modules/store/store_home/view/store_home_screen.dart';
import 'package:aroundus_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import 'base_component.dart';

enum MenuState { home, magazine, store, community, my_page }

extension MenuStateToString on MenuState {
  String get name {
    return ["home", "magazine", "store", "community", "my_page"][this.index];
  }


  Widget get page {
    return [
      HomeScreen(),
      MagazineHomeScreen(),
      StoreHomeScreen(),
      HomeScreen(),
      HomeScreen()
    ][this.index];
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({required this.selectedMenu});

  final MenuState selectedMenu;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  int get _selectedIndex => this.widget.selectedMenu.index;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: List.generate(
          MenuState.values.length,
          (index) => BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/bottomNavigationBar/${MenuState.values[index].name}.svg",
                ),
                label: "${MenuState.values[index].name}",
              )),
      selectedItemColor: Colors.lightBlue,
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedIndex,
      selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      onTap: (index) {
        Navigator.of(context).pushAndRemoveUntil(routePage(MenuState.values[index].page), (route) => false);
      },
    );
  }
}

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    this.size = 20.0,
    required this.menu,
    required this.changedColor,
    required this.onPressed,
  });

  final double size;
  final Color changedColor;
  final String menu;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: this.onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon(Icons.home, color: Colors.black, size: this.size),
            SvgPicture.asset(
              "assets/icons/bottomNavigationBar/$menu.svg",
            ),
            Text(
              menu,
              style: TextStyle(fontSize: 8.sp),
            ),
          ],
        ));
  }
}
