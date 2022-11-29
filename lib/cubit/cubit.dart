import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/states.dart';
import 'package:news/network/shard_pref.dart';
import 'package:news/screen/science_screen.dart';
import 'package:news/screen/sports_screen.dart';

import '../network/dio_helper.dart';
import '../screen/business_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screen = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;

    if (index == 1) getSports();
    if (index == 2) {
      getScience();
    }

    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getSports() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getDate(url:'v2/top-headlines', query: {
      'country':'us',
      'category':'sports',
      'apiKey': 'ad212bc34bea46d1a3649374f19fa841',
    }).then((value) {
      print(value.data['articles'][0]['title']);
      sports = value.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error);
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getDate(url: 'v2/top-headlines', query: {
      'country':'us',
      'category':'business',
      'apiKey':'ad212bc34bea46d1a3649374f19fa841',
    }).then((value) {
      print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error);
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getScience() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getDate(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category':'science',
      'apiKey':'ad212bc34bea46d1a3649374f19fa841',
    }).then((value) {
      print(value.data['articles'][0]['title']);
      science = value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error);
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  void getSearch(String value) {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getDate(url:'v2/everything', query: {
      'q':'$value',
      'apiKey':'ad212bc34bea46d1a3649374f19fa841',
    }).then((value) {
      print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error);
      emit(NewsGetSearchStateError(error.toString()));
    });
  }

  bool isDark = true;

 void changeAppMode({bool form=false}) async{
    if(form){
      isDark=form;
    }else{
      isDark = !isDark;
    }


 await   SharedPref.setDate(key: 'isDark', value: isDark).then((value) {
      emit(NewsChangeModeState());

    });

  }
}
