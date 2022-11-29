import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
 final TextEditingController searchController = TextEditingController();
 String v ='dd';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.all(20),
                  child:  TextField(
                    controller:searchController,
                   style: TextStyle(
                     color: Colors.black
                   ),
                  onSubmitted: (value){
                      print(value);
                    NewsCubit.get(context).getSearch(value);
                  },

                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                        focusedBorder:InputBorder.none,
                        filled: true,
                            border: OutlineInputBorder(
                        ),

                        prefixIcon: Icon(Icons.search)),

                ),
                ),
                Expanded(

                  child:
                NewsCubit.get(context).search.length==0?Center(
                  child: CircularProgressIndicator(

                  ),
                ):ListView.separated(
                      itemBuilder: (context, index) {
                      return  NewsCubit.get(context).search.length==0?Center(child:  CircularProgressIndicator(
                        color: Colors.deepOrange,
                      )):
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(

                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(NewsCubit.get(context).search[index]['urlToImage'].toString()),
                                    fit: BoxFit.cover,
                                  ),

                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Container(
                                  height: 120,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Text((NewsCubit.get(context).search[index]['title']),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(NewsCubit.get(context).search[index]['publishedAt'],
                                        style: TextStyle(
                                            color: Colors.grey
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 1,
                          width: double.infinity,
                          color:  Colors.grey,

                        );
                      },
                      itemCount: NewsCubit.get(context).search.length),
                )

              ],
            ),
          );
        });
  }
}
