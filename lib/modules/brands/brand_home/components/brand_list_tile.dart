import 'package:aroundus_app/modules/brands/brand_detail/view/brand_detail_screen.dart';
import 'package:aroundus_app/support/style/size_util.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';

class BrandListTile extends StatelessWidget {
  BrandListTile(
      {@required this.Id,
      @required this.name,
      @required this.description,
      @required this.logo});

  final String? Id, name, description, logo;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: Adaptive.h(2)),
        padding: EdgeInsets.symmetric(vertical: Adaptive.h(0.5)),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 0.5))
            ],
            borderRadius: BorderRadius.circular(sizeWidth(4))),
        child: ListTile(
            onTap: () => Navigator.pushNamed(
                context, BrandDetailScreen.routeName,
                arguments: {'Id': this.Id}),
            leading: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey)),
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(this.logo!),
                  radius: sizeWidth(8)),
            ),
            title:
                Text(this.name!, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(this.description!,
                maxLines: 2, overflow: TextOverflow.ellipsis),
            isThreeLine: true));
  }
}
