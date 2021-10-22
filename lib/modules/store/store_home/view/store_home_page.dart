import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/store/store_home/components/store_product_widget.dart';
import 'package:aroundus_app/modules/store/store_home/cubit/store_cubit.dart';
import 'package:aroundus_app/repositories/store_repository/models/collection.dart';
import 'package:aroundus_app/repositories/store_repository/models/menu.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
export 'package:sizer/sizer.dart';

class StorePage extends StatefulWidget {
  StorePage(this.pageController);

  final PageController pageController;

  @override
  State<StatefulWidget> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with SingleTickerProviderStateMixin {
  PageController get pageController => this.widget.pageController;

  late StoreCubit _storeCubit;
  late User user;
  late Collection _selectedMenu;
  bool isOpen = false;
  late int collPath;

  @override
  void initState() {
    super.initState();
    _storeCubit = BlocProvider.of<StoreCubit>(context);
    user = context.read<AuthenticationBloc>().state.user;
    _selectedMenu = _storeCubit.state.selectedMenu!;

    user.collections!.forEach((menu) {
      if(menu.collection.contains(_selectedMenu)){
        collPath = user.collections!.indexOf(menu);
      }
    });

    _storeCubit.getProductsByCollection(_selectedMenu, "price.sale");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  pageController.jumpToPage(0);
                },
                icon: Icon(Icons.menu),
                color: Colors.black,
                padding: EdgeInsets.zero,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${_selectedMenu.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    isOpen
                        ? Icon(Icons.keyboard_arrow_up_sharp, color: Colors.black)
                        : Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                    color: Colors.black,
                    padding: EdgeInsets.zero,
                  ),
                ],
              )
            ],
          )),
      body: Stack(
        children: [
          BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
            print(state.products);
            print(_selectedMenu);
            if (state.products != null) {
              if(state.products!.isEmpty) {
                return Center(child: Text("등록된 상품이 없습니다."));
              } else {
                return SingleChildScrollView(
                  padding: basePadding(),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: Adaptive.h(3)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "PRODUCT",
                              style: theme.textTheme.headline4!
                                  .copyWith(fontWeight: FontWeight.w900),
                            ),
                            Text("인기순 필터")
                          ],
                        ),
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 15,
                        childAspectRatio: (4 / 7),
                        children: List.generate(state.products!.length,
                                (index) => storeProduct(context, state.products![index])),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
          IndexedStack(index: 1, children: [
            AnimatedOpacity(
              opacity: isOpen ? 0.3 : 0,
              duration: Duration(milliseconds: 700),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
                child: Container(
                  height: Adaptive.h(100),
                  color: Colors.black,
                ),
              ),
            ),
            AnimatedContainer(
              color: Colors.white,
              height: isOpen ? user.collections![collPath].collection.length * 50 : 0,
              duration: Duration(milliseconds: 700),
              curve: Curves.fastOutSlowIn,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        isOpen = !isOpen;
                        _selectedMenu = user.collections![collPath].collection[index];
                        _storeCubit.getProductsByCollection(_selectedMenu, "price.sale");
                      });
                    },
                    title: Text("${user.collections![collPath].collection[index].name}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  );
                },
                itemCount: user.collections![collPath].collection.length,
                itemExtent: 50,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
