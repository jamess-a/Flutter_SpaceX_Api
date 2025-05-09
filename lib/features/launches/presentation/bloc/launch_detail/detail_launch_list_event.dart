abstract class DetailLaunchEvent {}

class FetchDetailLaunch extends DetailLaunchEvent {
  String id;

  FetchDetailLaunch(this.id);
}
