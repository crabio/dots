part of 'bloc.dart';

class JoinSpotPageEvent extends Equatable {
  const JoinSpotPageEvent();

  @override
  List<Object> get props => [];
}

class NewSpotUuidEvent extends JoinSpotPageEvent {
  final String spotUuid;

  const NewSpotUuidEvent({required this.spotUuid});

  @override
  List<Object> get props => [spotUuid];
}

class JoinSpotEvent extends JoinSpotPageEvent {
  final String spotUuid;

  const JoinSpotEvent({required this.spotUuid});

  @override
  List<Object> get props => [spotUuid];
}
