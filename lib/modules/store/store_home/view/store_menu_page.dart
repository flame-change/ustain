import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/modules/store/store_home/cubit/store_cubit.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:aroundus_app/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class StoreMenuPage extends StatefulWidget {
  StoreMenuPage(this.pageController);
  final PageController pageController;

  @override
  State<StatefulWidget> createState() => _StoreMenuPage();
}

class _StoreMenuPage extends State<StoreMenuPage> with SingleTickerProviderStateMixin {
  PageController get pageController => this.widget.pageController;

  late StoreCubit _storeCubit;

  late User user;

  @override
  void initState() {
    super.initState();
    _storeCubit = BlocProvider.of<StoreCubit>(context);
    user = context.read<AuthenticationBloc>().state.user;
  }

  @override
  Widget build(BuildContext context) {
    print(user.collections);

    return Scaffold(
      body: PageWire(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: sizeWith(100),
                  padding: EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("CATEGORIES",
                          style: theme.textTheme.headline3!
                              .copyWith(fontSize: Adaptive.dp(20))),
                      IconButton(onPressed: () {}, icon: Icon(Icons.search))
                    ],
                  )),
              Column(
                children: List.generate(
                    user.collections!.length,
                    (i) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${user.collections![i].name}",
                                style: theme.textTheme.headline3!.copyWith(
                                  fontSize: Adaptive.dp(18),
                                )),
                            GridView.count(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              shrinkWrap: true,
                              childAspectRatio: 4 / 1,
                              crossAxisCount: 2,
                              children: List.generate(
                                  user.collections![i].collection.length,
                                  (j) => GestureDetector(
                                    onTap: () {
                                      _storeCubit.selectedCollection(user.collections![i].collection[j]);
                                      pageController.jumpToPage(1);
                                    },
                                    child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: _storeCubit.state.selectedMenu==user.collections![i].collection[j]?
                                              Colors.black:Colors.white,
                                              border: Border.all(color: Colors.black, width: 1)),
                                          child: Text(
                                            "${user.collections![i].collection[j].name}",
                                            style: theme.textTheme.bodyText1!.copyWith(
                                              color: _storeCubit.state.selectedMenu==user.collections![i].collection[j]?Colors.white:Colors.black
                                            ),
                                          ),
                                        ),
                                  )),
                            )
                          ],
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
