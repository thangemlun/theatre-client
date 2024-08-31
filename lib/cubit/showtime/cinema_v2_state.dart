part of 'cinema_v2_bloc.dart';

@immutable
sealed class CinemaV2State {
  final List<CinemaV2> cinemas;
  const CinemaV2State(this.cinemas);
}

final class CinemaV2InitialState extends CinemaV2State {
  CinemaV2InitialState(super.cinemas);
}
