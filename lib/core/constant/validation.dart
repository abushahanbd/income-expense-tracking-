
class AppValidator {
  // Title Validation
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title is required.';
    }
    return null;
  }

  // Amount Validation
  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount is required.';
    }

    final amount = double.tryParse(value.trim());

    if (amount == null) {
      return 'Please enter a valid amount.';
    }

    if (amount < 0) {
      return 'Amount cannot be negative.';
    }

    return null;
  }
}
