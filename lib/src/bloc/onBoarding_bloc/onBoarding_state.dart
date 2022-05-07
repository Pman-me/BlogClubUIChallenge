import 'package:blog_club/src/data/model/onboarding_model.dart';
import 'package:equatable/equatable.dart';


 class OnBoardingState extends Equatable{
   List<OnBoardingModel> onBoardingItems;
   bool isReachedMaxPage;

  @override
  List<Object?> get props => [onBoardingItems,isReachedMaxPage];

  OnBoardingState({required this.onBoardingItems,required this.isReachedMaxPage});

   OnBoardingState copyWith({
     List<OnBoardingModel>? onBoardingItems,
     bool? isReachedMaxPage,
   }) {
     return OnBoardingState(
       onBoardingItems: onBoardingItems ?? this.onBoardingItems,
       isReachedMaxPage: isReachedMaxPage ?? this.isReachedMaxPage,
     );
   }
}
