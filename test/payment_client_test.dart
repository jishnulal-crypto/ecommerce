import 'dart:convert';
import 'package:payment_client/payment_client.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient mockClient;
  late PaymentClient paymentClient;

  setUp(() {
    mockClient = MockClient();
    paymentClient = PaymentClient(client: mockClient);
  });

  group('PaymentClient', () {
    test('processPayment returns expected result on success', () async {
      final mockResponse = json.encode({
        'status': 'success',
        'paymentMethodId': 'pm_test',
      });

      when(mockClient.post(Uri.parse(ENDPOINT_METHOD_ID_URL),
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await paymentClient.processPayment(
        paymentMethodId: 'pm_test',
        items: [
          {'id': 'item1', 'price': 100}
        ],
      );

      expect(result['status'], 'success');
      expect(result['paymentMethodId'], 'pm_test');

      verify(mockClient.post(
        Uri.parse(ENDPOINT_METHOD_ID_URL),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'paymentMethodId': 'pm_test',
          'items': [
            {'id': 'item1', 'price': 100}
          ],
          'currency': 'eur',
          'useStripeSdk': true,
        }),
      )).called(1);
    });

    test('confirmPayment returns expected result on success', () async {
      final mockResponse = json.encode({
        'status': 'confirmed',
        'paymentIntentId': 'pi_test',
      });

      when(mockClient.post(Uri.parse(ENDPOINT_METHOD_ID_URL),
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result =
          await paymentClient.confirmPayment(paymentIntentId: 'pi_test');

      expect(result['status'], 'confirmed');
      expect(result['paymentIntentId'], 'pi_test');

      verify(mockClient.post(
        Uri.parse(ENDPOINT_INTENT_ID_URL),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'paymentIntentId': 'pi_test'}),
      )).called(1);
    });

    test('processPayment returns error message on failure', () async {
      final mockErrorResponse = json.encode({'error': 'Something went wrong'});

      when(mockClient.post(Uri.parse(ENDPOINT_METHOD_ID_URL),
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockErrorResponse, 400));

      final result = await paymentClient.processPayment(
        paymentMethodId: 'pm_invalid',
        items: [
          {'id': 'item1', 'price': 100}
        ],
      );

      expect(result['error'], 'Something went wrong');
    });

    test('confirmPayment returns error message on failure', () async {
      final mockErrorResponse =
          json.encode({'error': 'Invalid payment intent'});

      when(mockClient.post(Uri.parse(ENDPOINT_METHOD_ID_URL),
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockErrorResponse, 400));

      final result =
          await paymentClient.confirmPayment(paymentIntentId: 'pi_invalid');

      expect(result['error'], 'Invalid payment intent');
    });
  });
}
