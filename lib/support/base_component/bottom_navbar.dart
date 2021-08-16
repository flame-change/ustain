import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import 'base_component.dart';

enum MenuState { home, magazine, store, community, my_page }

extension MenuStateToString on MenuState {
  String get name {
    return ["home", "magazine", "store", "community", "my_page"][this.index];
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({required this.selectedMenu});

  final MenuState selectedMenu;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButtonWidget(
              changedColor: MenuState.home == widget.selectedMenu
                  ? Colors.black
                  : Color(0xFFB6B6B6),
              menu: MenuState.home.name,
              onPressed: () {},
            ),
            IconButtonWidget(
              changedColor: MenuState.magazine == widget.selectedMenu
                  ? Colors.black
                  : Color(0xFFB6B6B6),
              menu: MenuState.magazine.name,
              onPressed: () {},
            ),
            IconButtonWidget(
              changedColor: MenuState.store == widget.selectedMenu
                  ? Colors.black
                  : Color(0xFFB6B6B6),
              menu: MenuState.store.name,
              onPressed: () {},
            ),
            IconButtonWidget(
              changedColor: MenuState.community == widget.selectedMenu
                  ? Colors.black
                  : Color(0xFFB6B6B6),
              menu: MenuState.community.name,
              onPressed: () {},
            ),
            IconButtonWidget(
              changedColor: MenuState.my_page == widget.selectedMenu
                  ? Colors.black
                  : Color(0xFFB6B6B6),
              menu: MenuState.my_page.name,
              onPressed: () {},
            ),
          ],
        ),
      ),
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
              // height: this.size,
            ),
            Text(
              menu,
              style: TextStyle(fontSize: 8.sp),
            ),
          ],
        ));
  }
}
