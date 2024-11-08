import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_with_flutter_firebase_and_stripe/screens/register_screen.dart';
import 'package:ecommerce_with_flutter_firebase_and_stripe/screens/category_screen.dart'; // Adjust the import to your project structure
import 'package:ecommerce_with_flutter_firebase_and_stripe/screens/login_screen.dart'; // Adjust the import

// Mock FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RegisterScreen Tests', () {
    late MockFirebaseAuth mockFirebaseAuth;

    // Set up the mockFirebaseAuth before each test
    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
    });

    testWidgets('successful registration navigates to CategoriesScreen',
        (WidgetTester tester) async {
      // Arrange: Mock the Firebase createUserWithEmailAndPassword to return a user 
 when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).thenAnswer((s) async => UserCredential(
        user: mockUser,
        additionalUserInfo: AdditionalUserInfo(isNewUser: true, providerId: ''),
        credential: AuthCredential(providerId: '', signInMethod: ''),
      ));
      // Act: Build the RegisterScreen widget
      await tester.pumpWidget(
        MaterialApp(
          home: RegisterScreen(),
        ),
      );

      // Enter valid email and password
      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      // Tap the register button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert: Check that the navigation to CategoriesScreen happens
      expect(find.byType(CategoriesScreen), findsOneWidget);
    });

    testWidgets('shows error message on registration failure',
        (WidgetTester tester) async {
      // Arrange: Mock the Firebase createUserWithEmailAndPassword to throw an exception
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).thenThrow(FirebaseAuthException(
          message: 'Invalid email or password', code: '421'));

      // Act: Build the RegisterScreen widget
      await tester.pumpWidget(
        MaterialApp(
          home: RegisterScreen(),
        ),
      );

      // Enter valid email and password
      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      // Tap the register button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert: Check that the error message is shown
      expect(find.text('Invalid email or password'), findsOneWidget);
    });

    testWidgets('navigates to LoginScreen when login link is tapped',
        (WidgetTester tester) async {
      // Act: Build the RegisterScreen widget
      await tester.pumpWidget(
        MaterialApp(
          home: RegisterScreen(),
        ),
      );

      // Tap the "Already have an account? Login here." link
      await tester.tap(find.text('Already have an account? Login here.'));
      await tester.pumpAndSettle();

      // Assert: Check that the LoginScreen is shown
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
