abstract class HomeEvent {}

class GetPhotos extends HomeEvent {
  final int page;
  GetPhotos(
    this.page,
  );
}
