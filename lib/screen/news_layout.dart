import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/network/dio_helper.dart';
import 'package:news/network/shard_pref.dart';
import 'package:news/screen/search_screen.dart';

import '../cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state){},
        builder: (context, state){
          var cubit=NewsCubit.get(context);
          return    Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
               IconButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder:(context)=>SearchScreen()));
               }, icon: Icon(Icons.search)),
                IconButton(onPressed: (){
                  NewsCubit.get(context).changeAppMode();

                    // SharedPref().save(SharedPref().isDark);

                }, icon: Icon(Icons.brightness_4)),
              ],
            ),
            body: cubit.screen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
               cubit.changeBottomNavBar(index);
              },
              items:cubit.bottomItems,
            ),
          );
        },

      );
  }
}
