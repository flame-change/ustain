import 'package:aroundus_app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget categoryTag(BuildContext context, List<String> categories){
  User user = context.read<AuthenticationBloc>().state.user;

  return Wrap(
    runSpacing: 5,
    spacing: 10,
    children: List.generate(
      categories.length,
          (index) => Container(
        color: Colors.blue,
        padding: EdgeInsets.all(5),
        child: Text("#${user.categoryTransfer(categories[index])}"),
      ),
    ),
  );
}