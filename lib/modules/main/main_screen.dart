import 'package:aroundus_app/modules/magazine/magazine_home/view/magazine_home_screen.dart';
import 'package:aroundus_app/modules/store/store_home/view/store_home_screen.dart';
import 'package:aroundus_app/modules/brands/brand_home/view/brand_screen.dart';
import 'package:aroundus_app/modules/mypage/view/mypage_screen.dart';
import 'package:aroundus_app/modules/home/view/home_screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:aroundus_app/modules/home/home.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';

enum MenuState { home, magazine, store, brands, my_page }

extension MenuStateToString on MenuState {
  String get name {
    return ["home", "magazine", "store", "brands", "my_page"][this.index];
  }

  String get nickName {
    return ["홈", "매거진", "스토어", "브랜드", "내 계정"][this.index];
  }
}

class MainScreen extends StatefulWidget {
  static String routeName = '/main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;

  PageController pageController = PageController();

  void _onPageChanged(int index) => setState(() => pageIndex = index);

  void _onItemTapped(int index) => pageController.jumpToPage(index);

  List<Widget> pageList = [
    HomeScreen(),
    MagazineHomeScreen(),
    StoreHomeScreen(),
    BrandScreen(),
    MyPageScreen()
  ];

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: PageView(
                children: pageList,
                controller: pageController,
                onPageChanged: _onPageChanged,
                physics: NeverScrollableScrollPhysics()),
            bottomNavigationBar: Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black, width: 1.0))),
                child: BottomNavigationBar(
                    items: List.generate(
                        MenuState.values.length,
                        (index) => BottomNavigationBarItem(
                            icon: ImageIcon(Svg(
                                "assets/icons/bottomNavigationBar/${MenuState.values[index].name}.svg",
                                size: Size(Adaptive.dp(18), Adaptive.dp(18)))),
                            label: "${MenuState.values[index].nickName}")),
                    onTap: _onItemTapped,
                    selectedItemColor: theme.accentColor,
                    unselectedItemColor: Color(0xFF8C8C8C),
                    unselectedLabelStyle: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: Adaptive.dp(8),
                      fontWeight: FontWeight.w900,
                    ),
                    selectedLabelStyle: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: Adaptive.dp(8),
                      fontWeight: FontWeight.w900,
                    ),
                    currentIndex: pageIndex,
                    selectedFontSize: 12,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                    elevation: 0))));
  }
}
