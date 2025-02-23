abstract class NewsStates{}
class NewsInitiaState extends NewsStates{}
class NewsBottomNavState extends NewsStates{}
class NewsLoadingState extends NewsStates{}
class NewsBusinessSuccessState extends NewsStates{}
class NewsBusinessErrorState extends NewsStates{
  final String error;

  NewsBusinessErrorState(this.error);
}
class NewsSportsLoadingState extends NewsStates{}
class NewsSportsSuccessState extends NewsStates{}
class NewsSportsErrorState extends NewsStates{
  final String error;

  NewsSportsErrorState(this.error);
}
class NewsScienceLoadingState extends NewsStates{}
class NewsScienceSuccessState extends NewsStates{}
class NewsScienceErrorState extends NewsStates{
  final String error;

  NewsScienceErrorState(this.error);
}