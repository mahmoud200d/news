import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/network/dio_helper.dart';
import 'package:news/network/shard_pref.dart';
import 'package:news/screen/news_layout.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'cubit/constens_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();


  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await SharedPref.init();
 bool  isDark=SharedPref.getDate(key: 'isDark');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp( MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isDark}) : super(key: key);

final bool isDark;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getBusiness()
        ..getSports()
        ..getScience()
      ..changeAppMode(form: isDark),

      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {

          },
          builder: (context, state) {

            return MaterialApp(

              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                  textTheme:
                      TextTheme(bodyText2: TextStyle(color: Colors.black)),

                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                      titleSpacing: 20,
                      iconTheme: IconThemeData(color: Colors.black),
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.dark),
                      backgroundColor: Colors.white,
                      elevation: 0,
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    elevation: 20,
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrange)),
              darkTheme: ThemeData(

                  scaffoldBackgroundColor: Color(333739),
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20,
                      iconTheme: IconThemeData(color: Colors.white),
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Color(333739),
                          statusBarIconBrightness: Brightness.light),
                      backgroundColor: Color(333739),
                      elevation: 0,
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.white,
                      elevation: 20,
                      backgroundColor: Color(333739)),
                  textTheme:
                      TextTheme(bodyText2: TextStyle(color: Colors.white))),
              themeMode: NewsCubit.get(context).isDark?ThemeMode.light:ThemeMode.dark,
              home: NewsLayout(),

            );
          }),
    );
  }
}
