import 'package:aroundus_app/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:aroundus_app/modules/store/store_home/components/store_product_widget.dart';
import 'package:aroundus_app/repositories/store_repository/models/collection.dart';
import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/store/store_home/cubit/store_cubit.dart';
import 'package:aroundus_app/support/base_component/login_needed.dart';
import 'package:aroundus_app/modules/store/cart/view/cart_screen.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  late AuthenticationStatus user_status;
  late StoreCubit _storeCubit;
  late Collection _selectedCollection;

  final _scrollController = ScrollController();

  int page = 1;

  @override
  void initState() {
    super.initState();
    _storeCubit = BlocProvider.of<StoreCubit>(context);
    user_status = context.read<AuthenticationBloc>().state.status;
    _storeCubit.getSubCollection();
    _selectedCollection =
        Collection(_storeCubit.state.selectedMenu!.Id, '전체보기');
    _storeCubit.getProductsByCollection(
        _storeCubit.state.selectedMenu!, "price.sale", page);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll == 0 && _storeCubit.state.maxIndex == false) {
      page += 1;
      _storeCubit.getProductsByCollection(
          _selectedCollection, "price.sale", page);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
      return state.collections != null
          ? Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  elevation: 0,
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () => pageController.animateToPage(0,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeOut),
                            child: Icon(Icons.menu, color: Colors.black)),
                        Text('${_selectedCollection.name}',
                            style: TextStyle(
                                fontSize: Adaptive.dp(12),
                                color: Colors.black)),
                        GestureDetector(
                            onTap: () => user_status ==
                                    AuthenticationStatus.authenticated
                                ? Navigator.pushNamed(
                                    context, CartScreen.routeName)
                                : showLoginNeededDialog(context),
                            child: SvgPicture.asset("assets/icons/cart.svg"))
                      ])),
              body: Stack(children: [
                BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
                  if (state.products != null) {
                    return SingleChildScrollView(
                        controller: _scrollController,
                        padding: basePadding(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 서브 카테고리
                              Container(
                                  height: 30,
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                            onTap: () => setState(() {
                                                  _selectedCollection = state
                                                      .subCollections![index];
                                                  page = 1;
                                                  _storeCubit
                                                      .getProductsByCollection(
                                                          _selectedCollection,
                                                          "price.sale",
                                                          page);
                                                }),
                                            child: Container(
                                                color: _selectedCollection ==
                                                        state.subCollections![
                                                            index]
                                                    ? Colors.black
                                                    : Colors.grey[300],
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(5),
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Text(
                                                    "${state.subCollections![index].name}",
                                                    style: TextStyle(
                                                        color: _selectedCollection ==
                                                                state.subCollections![
                                                                    index]
                                                            ? Colors.white
                                                            : Colors.black))));
                                      },
                                      itemCount: state.subCollections!.length)),
                              state.products!.isNotEmpty
                                  ? GridView.count(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 15,
                                      childAspectRatio: (4 / 7),
                                      children: List.generate(
                                          state.products!.length,
                                          (index) => storeProduct(
                                              context, state.products![index])))
                                  : Container(
                                      padding:
                                          EdgeInsets.only(top: Adaptive.h(30)),
                                      child:
                                          Center(child: Text("등록된 상품이 없습니다.")))
                            ]));
                  } else {
                    return Center(
                        child: Image.asset('assets/images/indicator.gif'));
                  }
                })
              ]))
          : Center(child: Image.asset('assets/images/indicator.gif'));
    });
  }
}
