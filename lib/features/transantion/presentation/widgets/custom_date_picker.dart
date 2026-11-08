import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final String hintText;
  final bool isRequired;
  final bool showError;

  const CustomDatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.hintText = 'Select date',
    this.isRequired = false,
    this.showError = false,
  });

  Future<void> _pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = selectedDate ?? now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate.isAfter(now) ? now : initialDate,
      firstDate: DateTime(2000),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00A843),
              onPrimary: Colors.white,
              onSurface: Color(0xFF1E293B),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError = isRequired && showError && selectedDate == null;

    final String displayText = selectedDate != null
        ? DateFormat('MMM dd, yyyy').format(selectedDate!)
        : hintText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => _pickDate(context),
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasError ? Colors.red : const Color(0xFFE2E8F0),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: hasError ? Colors.red : const Color(0xFF334155),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    displayText,
                    style: TextStyle(
                      color: selectedDate != null
                          ? const Color(0xFF1E293B)
                          : const Color(0xFF94A3B8),
                      fontSize: 14,
                      fontWeight: selectedDate != null
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xFF334155),
                  size: 20,
                ),
              ],
            ),
          ),
        ),

        if (hasError)
          const Padding(
            padding: EdgeInsets.only(left: 12, top: 5),
            child: Text(
              'Date is required.',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
