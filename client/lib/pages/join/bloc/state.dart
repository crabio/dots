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
  // Flag indicies that QR code scaned successfully
  final bool success;

  const JoinSpotPageInitial({
    required this.spotUuid,
    required this.error,
    required this.success,
  });

  @override
  List<Object?> get props => [
        spotUuid,
        error,
        success,
      ];
}

class JoinedSpotState extends JoinSpotPageState {
  final String spotUuid;

  const JoinedSpotState({required this.spotUuid});

  @override
  List<Object?> get props => [spotUuid];
}
