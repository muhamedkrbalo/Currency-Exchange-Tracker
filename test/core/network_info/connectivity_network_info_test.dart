import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currency_exchange_tracker/core/network_info/connectivity_network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late MockConnectivity connectivity;
  late ConnectivityNetworkInfo networkInfo;

  setUp(() {
    connectivity = MockConnectivity();
    networkInfo = ConnectivityNetworkInfo(connectivity);
  });

  group('isConnected', () {
    test('is true when any transport is available', () async {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);

      expect(await networkInfo.isConnected, isTrue);
    });

    test('is true when several transports are reported', () async {
      when(() => connectivity.checkConnectivity()).thenAnswer(
        (_) async => [ConnectivityResult.mobile, ConnectivityResult.vpn],
      );

      expect(await networkInfo.isConnected, isTrue);
    });

    test('is false when the only result is none', () async {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);

      expect(await networkInfo.isConnected, isFalse);
    });

    test('is false when no transports are reported', () async {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => <ConnectivityResult>[]);

      expect(await networkInfo.isConnected, isFalse);
    });
  });

  group('onStatusChange', () {
    test('maps connectivity results to a bool stream', () {
      when(() => connectivity.onConnectivityChanged).thenAnswer(
        (_) => Stream.fromIterable([
          [ConnectivityResult.wifi],
          [ConnectivityResult.none],
          [ConnectivityResult.mobile],
        ]),
      );

      expect(networkInfo.onStatusChange, emitsInOrder([true, false, true]));
    });

    test('emits only distinct values (collapses consecutive duplicates)', () {
      when(() => connectivity.onConnectivityChanged).thenAnswer(
        (_) => Stream.fromIterable([
          [ConnectivityResult.wifi],
          [ConnectivityResult.ethernet], // still connected -> duplicate `true`
          [ConnectivityResult.none],
          [ConnectivityResult.none], // duplicate `false`
          [ConnectivityResult.mobile],
        ]),
      );

      expect(
        networkInfo.onStatusChange,
        emitsInOrder([true, false, true, emitsDone]),
      );
    });
  });
}
