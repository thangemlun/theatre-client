part of 'cinema_v2_bloc.dart';

@immutable
sealed class CinemaV2Event {
  final String time;
  final String citiId;
  final String apiFilmId;

  const CinemaV2Event(this.time, this.citiId, this.apiFilmId);
}

class CinemaV2UpdateEvent extends CinemaV2Event {
  CinemaV2UpdateEvent(super.time, super.citiId, super.apiFilmId);
}