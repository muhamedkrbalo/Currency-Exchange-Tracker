import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/network_info/network_info.dart';

class ConnectivityCubit extends Cubit<bool> {
  ConnectivityCubit(this._networkInfo) : super(true) {
    _subscription = _networkInfo.onStatusChange.listen(_onStatus);
    unawaited(_emitInitialStatus());
  }

  final NetworkInfo _networkInfo;
  late final StreamSubscription<bool> _subscription;

  bool get isOnline => state;

  Future<void> _emitInitialStatus() async {
    _onStatus(await _networkInfo.isConnected);
  }

  void _onStatus(bool isConnected) {
    if (!isClosed && isConnected != state) emit(isConnected);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
