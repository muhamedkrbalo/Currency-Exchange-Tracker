import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange_tracker/app/connectivity/connectivity_cubit.dart';
import 'package:currency_exchange_tracker/core/network_info/network_info.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeNetworkInfo implements NetworkInfo {
  _FakeNetworkInfo({required this.initial});

  final bool initial;
  final StreamController<bool> controller = StreamController<bool>.broadcast();

  @override
  Future<bool> get isConnected async => initial;

  @override
  Stream<bool> get onStatusChange => controller.stream;
}

void main() {
  late _FakeNetworkInfo networkInfo;

  tearDown(() => networkInfo.controller.close());

  blocTest<ConnectivityCubit, bool>(
    'emits the current offline status on creation',
    build: () {
      networkInfo = _FakeNetworkInfo(initial: false);
      return ConnectivityCubit(networkInfo);
    },
    expect: () => [false],
  );

  blocTest<ConnectivityCubit, bool>(
    'stays online without a redundant emit when already connected',
    build: () {
      networkInfo = _FakeNetworkInfo(initial: true);
      return ConnectivityCubit(networkInfo);
    },
    expect: () => <bool>[],
    verify: (cubit) => expect(cubit.isOnline, isTrue),
  );

  blocTest<ConnectivityCubit, bool>(
    'mirrors status changes from the network stream',
    build: () {
      networkInfo = _FakeNetworkInfo(initial: true);
      return ConnectivityCubit(networkInfo);
    },
    act: (_) => networkInfo.controller
      ..add(false)
      ..add(true),
    expect: () => [false, true],
  );

  blocTest<ConnectivityCubit, bool>(
    'stops listening after close',
    build: () {
      networkInfo = _FakeNetworkInfo(initial: true);
      return ConnectivityCubit(networkInfo);
    },
    act: (cubit) async {
      await cubit.close();
      networkInfo.controller.add(false);
    },
    expect: () => <bool>[],
  );
}
