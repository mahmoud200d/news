abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}
class NewsChangeModeState extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}
class NewsGetSportsSuccessState extends NewsStates {}
class NewsGetScienceSuccessState extends NewsStates {}
class NewsGetSearchSuccessState extends NewsStates {}


class NewsGetBusinessErrorState extends NewsStates {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsErrorState extends NewsStates {
 final String error;

NewsGetSportsErrorState(this.error);
}


class NewsGetScienceErrorState  extends NewsStates {
  final String error;

  NewsGetScienceErrorState(this.error);
}
class NewsGetSearchStateError extends NewsStates {
  late final String error;
  NewsGetSearchStateError(this.error);


}
