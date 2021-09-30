import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/store/store_home/cubit/store_cubit.dart';
import 'package:aroundus_app/modules/store/store_home/view/view.dart';
import 'package:aroundus_app/repositories/store_repository/models/collection.dart';
import 'package:aroundus_app/repositories/store_repository/src/store_repository.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/bottom_navbar.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class StoreHomeScreen extends StatefulWidget {
  static String routeName = 'store_home_screen';

  @override
  State<StatefulWidget> createState() => _StoreHomeScreen();
}

class _StoreHomeScreen extends State<StoreHomeScreen> {
  bool isOpen = false;
  late Collection selectedMenu;

  late User user;

  @override
  void initState() {
    super.initState();
    user = context.read<AuthenticationBloc>().state.user;
    selectedMenu = user.collections!.last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          // child: _offsetPopup(),
          child: Row(
            children: [
              Text("${selectedMenu.name}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              isOpen
                  ? Icon(Icons.keyboard_arrow_up_sharp)
                  : Icon(Icons.keyboard_arrow_down_sharp),
            ],
          ),
        ),
        elevation: 0,
        actions: [
          Icon(Icons.search, size: Adaptive.sp(20)),
          Icon(Icons.notifications, size: Adaptive.sp(20)),
        ],
      ),
      body: BlocProvider(
        create: (_) =>
            StoreCubit(RepositoryProvider.of<StoreRepository>(context)),
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: isOpen ? 0.3 : 0,
              duration: Duration(milliseconds: 700),
              child: Container(
                height: Adaptive.h(100),
                color: Colors.black,
              ),
            ),
            AnimatedContainer(
              color: Colors.white,
              height: isOpen ? user.collections!.length * 50 : 0,
              duration: Duration(milliseconds: 700),
              curve: Curves.fastOutSlowIn,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      print(user.collections![index]);
                      setState(() {
                        isOpen = !isOpen;
                        selectedMenu = user.collections![index];
                      });
                    },
                    title: Text("${user.collections![index].name}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  );
                },
                itemCount: user.collections!.length,
                itemExtent: 50,
              ),
            ),
            StorePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.store),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'cart_screen');
          },
          child: Icon(Icons.shopping_cart_outlined)),
    );
  }
}
