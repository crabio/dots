import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:dots_client/gen/spot/v1/spot_v1.pbgrpc.dart' as proto;
import 'package:dots_client/data/gen/spot_qr_code.pb.dart' as qr_code_proto;
import 'package:qr_code_scanner/qr_code_scanner.dart';
part 'events.dart';
part 'state.dart';
part 'bloc.g.dart';

class JoinSpotPageBloc extends Bloc<JoinSpotPageEvent, JoinSpotPageState> {
  final proto.SpotServiceClient client;
  final String playerUuid;

  JoinSpotPageBloc({
    required this.client,
    required this.playerUuid,
  }) : super(const JoinSpotPageInitial(spotUuid: "", error: "")) {
    on<NewSpotUuidEvent>((event, emit) =>
        emit(JoinSpotPageInitial(spotUuid: event.spotUuid, error: "")));
    on<QrCodeScannerInitedEvent>((event, emit) => event
        .controller.scannedDataStream
        .listen((barcode) => add(NewQrCodeScannerEvent(barcode: barcode))));
    on<NewQrCodeScannerEvent>(_onNewQrCodeScannerEvent);
    on<JoinSpotEvent>(_onJoinSpotEvent);
  }

  Future<void> _onJoinSpotEvent(
    JoinSpotEvent event,
    Emitter<JoinSpotPageState> emit,
  ) async {
    final curState = state;
    if (curState is JoinSpotPageInitial) {
      await client
          .joinToSpot(proto.JoinToSpotRequest(
            spotUuid: event.spotUuid,
            playerUuid: playerUuid,
          ))
          .then(
            (response) => emit(JoinedSpotState(spotUuid: event.spotUuid)),
            onError: (grpcError) =>
                emit(curState.copyWith(error: grpcError.toString())),
          );
    }
  }

  Future<void> _onNewQrCodeScannerEvent(
    NewQrCodeScannerEvent event,
    Emitter<JoinSpotPageState> emit,
  ) async {
    final curState = state;
    if (curState is JoinSpotPageInitial) {
      if (event.barcode.rawBytes == null) {
        emit(curState.copyWith(error: "Bar code has no data"));
      } else {
        final qrCodeData = qr_code_proto.SpotQrCode.fromBuffer(
            event.barcode.rawBytes!.toList());
        add(JoinSpotEvent(spotUuid: qrCodeData.spotUuid));
      }
    }
  }
}
