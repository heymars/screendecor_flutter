import 'package:bloc/bloc.dart';
import 'package:screen_decor/api/repository/photo_repository.dart';
import 'package:screen_decor/models/photo_model.dart';
import 'package:screen_decor/ui/home/home_event.dart';
import 'package:screen_decor/ui/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  PhotoRepository _photoRepository = PhotoRepository();
  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetPhotos) {
      yield HomeStateLoading();
      try {
        List<PhotoModel> list = await _photoRepository.getPhotos(event.page);
        if (list != null) {
          yield HomeStateSuccess(photoModelList: list);
        }
      } catch (e) {
        print(e);
        yield HomeStateFailure(e);
      }
    }
  }
}
