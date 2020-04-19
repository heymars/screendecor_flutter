import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:screen_decor/models/collection_model.dart';

@immutable
abstract class CollectionState extends Equatable {
  CollectionState([List props = const []]) : super(props);
}

class InitialCollectionState extends CollectionState {}

class CollectionStateLoading extends CollectionState {}

class CollectionStateSuccess extends CollectionState {
  final List<CollectionModel> collectionModelList;

  CollectionStateSuccess({@required this.collectionModelList})
      : super([collectionModelList]);

  @override
  String toString() => '';
}

class CollectionStateFailure extends CollectionState {
  final String message;

  CollectionStateFailure(this.message);
}
