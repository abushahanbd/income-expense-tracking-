import 'package:flutter/material.dart';
import 'package:money_management/core/constant/app_text.dart';
import 'package:money_management/core/constant/validation.dart';
import 'package:money_management/features/transantion/data/model/trasnsaction_model.dart';
import 'package:money_management/features/transantion/presentation/provider/transaction_provider.dart';
import 'package:money_management/features/transantion/presentation/widgets/app_toast.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_app_bar.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_date_picker.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_drop_down_field.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_eleveted_button.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_text_field.dart';
import 'package:money_management/features/transantion/presentation/widgets/custon_input_label.dart';
import 'package:money_management/features/transantion/presentation/widgets/transaction_type_button.dart';
import 'package:provider/provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
  bool _showDateError = false;
  Future<void> addTransaction() async {
    final isValid = _formKey.currentState!.validate();

    setState(() {
      _showDateError = _chosenDate == null;
    });

    if (!isValid || _chosenDate == null) return;

    print('Valided');
    final transaction = TransactionModel(
      title: _titleController.text.trim(),
      amount: double.parse(_amountController.text),
      category: _selectedCategory!,
      type: _selectedType,
      date: _chosenDate.toString(),
    );
    await Provider.of<TransactionProvider>(
      context,
      listen: false,
    ).addTransaction(transaction);
    CustomSnackBar.show(context, message: 'Transaction added successfully!');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Transaction'),

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
                CustomSaveButton(onPressed: addTransaction),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
