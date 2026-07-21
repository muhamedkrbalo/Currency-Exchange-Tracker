import 'package:currency_exchange_tracker/core/network/api_client.dart';
import 'package:currency_exchange_tracker/core/network/api_config.dart';
import 'package:currency_exchange_tracker/features/rates/data/datasources/remote/rates_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MockApiClient client;
  late CurrencyRemoteDataSource dataSource;
  const config = ApiConfig();

  setUp(() {
    client = MockApiClient();
    dataSource = CurrencyRemoteDataSource(client, config);
  });

  final body = {
    'date': '2026-06-01',
    'egp': {'usd': 0.02},
  };

  test('getLatest fetches the latest endpoint and parses the DTO', () async {
    when(() => client.get<Map<String, dynamic>>(config.latest()))
        .thenAnswer((_) async => body);

    final dto = await dataSource.getLatest();

    expect(dto.date, '2026-06-01');
    expect(dto.rates['usd'], 0.02);
    verify(() => client.get<Map<String, dynamic>>(config.latest())).called(1);
  });

  test('getByDate fetches the dated endpoint for the requested day', () async {
    final date = DateTime(2026, 6, 1);
    when(() => client.get<Map<String, dynamic>>(config.onDate(date)))
        .thenAnswer((_) async => body);

    final dto = await dataSource.getByDate(date);

    expect(dto.rates['usd'], 0.02);
    verify(() => client.get<Map<String, dynamic>>(config.onDate(date)))
        .called(1);
  });
}
