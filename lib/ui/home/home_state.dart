import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:screen_decor/models/photo_model.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([List props = const []]) : super(props);
}

class InitialHomeState extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateSuccess extends HomeState {
  final List<PhotoModel> photoModelList;

  HomeStateSuccess({@required this.photoModelList}) : super([photoModelList]);

  @override
  String toString() => '';
}

class HomeStateFailure extends HomeState {
  final String message;

  HomeStateFailure(this.message);
}
