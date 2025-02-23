import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/news_app/cubit/cubit.dart';

import '../../../componets/componets.dart';
import '../../cubit/states.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var list = NewCubit.get(context).science;

        return articleBuilder(list, context);
      },
    );  }
}