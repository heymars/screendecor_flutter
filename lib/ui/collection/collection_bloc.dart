import 'package:bloc/bloc.dart';
import 'package:screen_decor/api/repository/photo_repository.dart';
import 'package:screen_decor/models/collection_model.dart';
import 'package:screen_decor/ui/collection/collection_event.dart';
import 'package:screen_decor/ui/collection/collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  PhotoRepository _photoRepository = PhotoRepository();
  @override
  CollectionState get initialState => InitialCollectionState();

  @override
  Stream<CollectionState> mapEventToState(CollectionEvent event) async* {
    if (event is GetCollections) {
      yield CollectionStateLoading();
      try {
        List<CollectionModel> list = await _photoRepository.getCollection();
        if (list != null) {
          yield CollectionStateSuccess(collectionModelList: list);
        }
      } catch (e) {
        print(e);
        yield CollectionStateFailure(e);
      }
    }
  }
}
