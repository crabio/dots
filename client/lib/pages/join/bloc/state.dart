part of 'bloc.dart';

abstract class JoinSpotPageState extends Equatable {
  const JoinSpotPageState();

  @override
  List<Object?> get props => [];
}

@CopyWith()
class JoinSpotPageInitial extends JoinSpotPageState {
  final String spotUuid;
  final String error;

  const JoinSpotPageInitial({
    required this.spotUuid,
    required this.error,
  });

  @override
  List<Object?> get props => [
        spotUuid,
        error,
      ];
}

class JoinedSpotState extends JoinSpotPageState {
  final String spotUuid;

  const JoinedSpotState({required this.spotUuid});

  @override
  List<Object?> get props => [spotUuid];
}
