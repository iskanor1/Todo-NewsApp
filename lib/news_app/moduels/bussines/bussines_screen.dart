import 'package:flutter/material.dart'; // Use Material.dart instead of Cupertino.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../componets/componets.dart';
import '../../cubit/cubit.dart'; // Ensure the correct path
import '../../cubit/states.dart'; // Ensure the correct path

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var list = NewCubit.get(context).business;

        return articleBuilder(list, context);
      },
    );
  }
}