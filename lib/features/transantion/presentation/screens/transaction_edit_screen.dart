import 'package:flutter/material.dart';
import 'package:money_management/core/constant/app_text.dart';
import 'package:money_management/core/constant/validation.dart';
import 'package:money_management/features/transantion/data/model/trasnsaction_model.dart';
import 'package:money_management/features/transantion/presentation/provider/transaction_provider.dart';
import 'package:money_management/features/transantion/presentation/screens/bottom_navigation/navigation_pages/home.dart';
import 'package:money_management/features/transantion/presentation/widgets/app_toast.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_app_bar.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_date_picker.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_drop_down_field.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_eleveted_button.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_text_field.dart';
import 'package:money_management/features/transantion/presentation/widgets/custon_input_label.dart';
import 'package:money_management/features/transantion/presentation/widgets/transaction_type_button.dart';
import 'package:provider/provider.dart';

class TransactionEditScreen extends StatefulWidget {
  final int id;
  final String title;
  final String amount;
  final String category;
  final String type;
  final String date;

  TransactionEditScreen({
    super.key,

    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
  });

  @override
  State<TransactionEditScreen> createState() => _TransactionEditScreenState();
}

class _TransactionEditScreenState extends State<TransactionEditScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();
  @override
  void initState() {
    super.initState();

    _titleController.text = widget.title;
    _amountController.text = widget.amount.toString();

    _selectedCategory = widget.category;
    _selectedType = widget.type;
    _chosenDate = DateTime.parse(widget.date);
  }

  String? _selectedCategory;
  final List<String> _categories = [
    'Salary',
    'Food',
    'Shopping',
    'Rent',
    'Others',
  ];
  String _selectedType = 'Income';
  DateTime? _chosenDate;
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  bool _showDateError = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> updateTransaction() async {
    final isValid = _formKey.currentState!.validate();

    setState(() {
      _showDateError = _chosenDate == null;
    });

    if (!isValid || _chosenDate == null) return;

    final transaction = TransactionModel(
      id: widget.id,
      title: _titleController.text.trim(),
      amount: double.parse(_amountController.text),
      category: _selectedCategory!,
      type: _selectedType,
      date: _chosenDate.toString(),
    );

    await Provider.of<TransactionProvider>(
      context,
      listen: false,
    ).updateTransaction(transaction);

    if (!mounted) return;

    CustomSnackBar.show(context, message: 'Transaction updated successfully!');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppText.editTransaction),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                CustomInputLabel(text: AppText.title, isRequired: true),

                CustomTextFormField(
                  validator: AppValidator.validateTitle,
                  controller: _titleController,
                  hintText: AppText.enterTitle,
                  prefixIcon: Icons.account_balance_wallet_rounded,
                ),

                CustomInputLabel(text: AppText.amount, isRequired: true),

                CustomTextFormField(
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  validator: AppValidator.validateAmount,
                  controller: _amountController,
                  hintText: AppText.enterAmount,
                  prefixIcon: Icons.account_balance_wallet_rounded,
                ),
                CustomInputLabel(text: AppText.category, isRequired: true),
                CustomDropdownField(
                  hintText: 'Select category',
                  prefixIcon: Icons.local_offer_outlined,
                  value: _selectedCategory,
                  items: _categories,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),

                CustomInputLabel(
                  text: AppText.transactionType,
                  isRequired: true,
                ),
                TransactionTypeButtons(
                  selectedType: _selectedType,
                  onTypeChanged: (newType) {
                    setState(() {
                      _selectedType = newType;
                    });
                  },
                ),

                CustomInputLabel(text: AppText.date, isRequired: true),
                CustomDatePickerField(
                  showError: _showDateError,
                  isRequired: true,
                  selectedDate: _chosenDate,
                  onDateSelected: (newDate) {
                    setState(() {
                      _chosenDate = newDate;
                      _showDateError = false;
                    });
                  },
                ),

                SizedBox(height: 20),
                CustomSaveButton(
                  onPressed: updateTransaction,
                  text: 'Update Transaction',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
