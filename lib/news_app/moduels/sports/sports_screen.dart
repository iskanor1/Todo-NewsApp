import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../componets/componets.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class SportsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var list = NewCubit.get(context).sports;

        return articleBuilder(list, context);
      },
    );
  }
}
