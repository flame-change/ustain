import 'package:aroundus_app/modules/home/home.dart';
import 'package:aroundus_app/modules/magazine/magazine_home/magazine_home.dart';
import 'package:aroundus_app/modules/store/store_home/view/store_home_screen.dart';
import 'package:aroundus_app/routes.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

enum MenuState { home, store, magazine, my_page }

extension MenuStateToString on MenuState {
  String get name {
    return ["home", "store", "magazine", "my_page"][this.index];
  }

  String get nickName {
    return ["홈", "스토어", "매거진", "내 계정"][this.index];
  }

  Widget get page {
    return [
      HomeScreen(),
      StoreHomeScreen(),
      MagazineHomeScreen(),
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
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(width: 1))),
      child: BottomNavigationBar(
        items: List.generate(
            MenuState.values.length,
            (index) => BottomNavigationBarItem(
                  icon: ImageIcon(Svg(
                      "assets/icons/bottomNavigationBar/${MenuState.values[index].name}.svg")),
                  label: "${MenuState.values[index].nickName}",
                )),
        selectedItemColor: theme.accentColor,
        unselectedItemColor: Color(0xFF8C8C8C),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: Adaptive.dp(12),
          fontWeight: FontWeight.w900,
        ),
        selectedLabelStyle: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: Adaptive.dp(12),
          fontWeight: FontWeight.w900,
        ),
        currentIndex: _selectedIndex,
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        onTap: (index) {
          Navigator.of(context).pushAndRemoveUntil(
              routePage(MenuState.values[index].page), (route) => false);
        },
      ),
    );
  }
}
