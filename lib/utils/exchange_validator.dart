/// Validates if a user can exchange points.
///
/// Returns:
/// - null if the exchange is allowed
/// - an error message if not allowed
String? validateExchange({
  required int currentPoints,
  required int requiredPoints,
  required int enteredPoints,
}) {
  if (enteredPoints <= 0 ||
      currentPoints < requiredPoints ||
      enteredPoints > currentPoints) {
    return "Poin kamu tidak mencukupi";
  }
  return null;
}
