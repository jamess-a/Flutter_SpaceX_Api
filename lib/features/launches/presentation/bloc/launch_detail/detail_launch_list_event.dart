abstract class DetailLaunchEvent {}
abstract class DetailRocketLEvent {}

class FetchDetailLaunch extends DetailLaunchEvent {
  String id;

  FetchDetailLaunch(this.id);
}

class FetchRocketDetail extends DetailRocketLEvent {
  String id;

  FetchRocketDetail(this.id);
}
