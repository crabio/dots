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

class QrCodeScannerInitedEvent extends JoinSpotPageEvent {
  final QRViewController controller;

  const QrCodeScannerInitedEvent({required this.controller});

  @override
  List<Object> get props => [controller];
}

class NewQrCodeScannerEvent extends JoinSpotPageEvent {
  final Barcode barcode;

  const NewQrCodeScannerEvent({required this.barcode});

  @override
  List<Object> get props => [barcode];
}

class JoinSpotEvent extends JoinSpotPageEvent {
  final String spotUuid;

  const JoinSpotEvent({required this.spotUuid});

  @override
  List<Object> get props => [spotUuid];
}
