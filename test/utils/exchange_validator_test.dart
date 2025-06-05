import 'package:flutter_test/flutter_test.dart';
import 'package:smartbin/utils/exchange_validator.dart';

void main() {
  group('validateExchange()', () {
    // PURPOSE:
    // To verify the behavior of the validateExchange() utility function,
    // which validates whether a user's point exchange request is allowed.

    // ASSUMPTIONS / PREREQUISITES:
    // - User must have at least `requiredPoints`.
    // - enteredPoints must be > 0 and ≤ currentPoints.
    // - If conditions are not met, a string error is returned.
    // - If valid, the function returns null.

    test('returns null if user has enough points and input is valid', () {
      // PURPOSE:
      // To test when all conditions are valid (user has sufficient points and input is acceptable)

      // EXPECTED:
      // The function returns null, indicating successful validation.
      final result = validateExchange(
        currentPoints: 150,
        requiredPoints: 100,
        enteredPoints: 100,
      );
      expect(result, isNull);
    });

    test('returns error if current points < required points', () {
      // PURPOSE:
      // To verify that the function blocks exchange if user doesn’t meet minimum required points

      // EXPECTED:
      // Returns "Poin kamu tidak mencukupi"
      final result = validateExchange(
        currentPoints: 80,
        requiredPoints: 100,
        enteredPoints: 80,
      );
      expect(result, 'Poin kamu tidak mencukupi');
    });

    test('returns error if enteredPoints > currentPoints', () {
      // PURPOSE:
      // To ensure that users can’t exchange more points than they currently have

      // EXPECTED:
      // Returns "Poin kamu tidak mencukupi"
      final result = validateExchange(
        currentPoints: 120,
        requiredPoints: 100,
        enteredPoints: 150,
      );
      expect(result, 'Poin kamu tidak mencukupi');
    });

    test('returns error if enteredPoints is 0', () {
      // PURPOSE:
      // To check edge case where user attempts to exchange 0 points

      // EXPECTED:
      // Returns "Poin kamu tidak mencukupi"
      final result = validateExchange(
        currentPoints: 120,
        requiredPoints: 100,
        enteredPoints: 0,
      );
      expect(result, 'Poin kamu tidak mencukupi');
    });

    test('returns error if enteredPoints is negative', () {
      // PURPOSE:
      // To validate the function rejects negative point entries

      // EXPECTED:
      // Returns "Poin kamu tidak mencukupi"
      final result = validateExchange(
        currentPoints: 120,
        requiredPoints: 100,
        enteredPoints: -10,
      );
      expect(result, 'Poin kamu tidak mencukupi');
    });
  });
}
