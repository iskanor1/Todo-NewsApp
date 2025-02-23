import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/news_app/cubit/cubit.dart';
import 'package:new_app/news_app/cubit/states.dart';

import '../../cubit.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewCubit()..getBusiness(), // Fetch business news initially
      child: BlocConsumer<NewCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News App',
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    // Implement search functionality
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                  ),
                  onPressed: () {
                    AppCubit.get(context).changeAppMode();
                  },
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomItem, // Fix: Use `bottomItem` instead of `bottomItems`
            ),
          );
        },
      ),
    );
  }
}