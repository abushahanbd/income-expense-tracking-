import 'package:flutter/material.dart';
import 'package:money_management/core/constant/app_text.dart';
import 'package:money_management/features/transantion/data/model/trasnsaction_model.dart';
import 'package:money_management/features/transantion/presentation/provider/transaction_provider.dart';
import 'package:money_management/features/transantion/presentation/screens/bottom_navigation/navigation_pages/home.dart';
import 'package:money_management/features/transantion/presentation/screens/transaction_edit_screen.dart';
import 'package:money_management/features/transantion/presentation/widgets/action_button_row.dart';
import 'package:money_management/features/transantion/presentation/widgets/app_toast.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_app_bar.dart';
import 'package:money_management/features/transantion/presentation/widgets/delete_confim_dialog.dart';
import 'package:money_management/features/transantion/presentation/widgets/info_list.dart';
import 'package:money_management/features/transantion/presentation/widgets/trasnsangtion_header.dart';
import 'package:provider/provider.dart';

class TrasnsactionDetailsScreen extends StatelessWidget {
  TrasnsactionDetailsScreen({
    super.key,
    required this.category,
    required this.date,
    required this.title,
    required this.type,
    required this.amount,
    required this.isIncome,
    required this.transaction,
  });
  String category;
  String date;
  String title;
  String type;
  String amount;
  final bool isIncome;
  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    return Scaffold(
      appBar: CustomAppBar(title: AppText.transactionDetails),
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Column(
          spacing: 15,
          children: [
            SizedBox(height: 20),
            TransactionHeader(title: title, amount: amount, isIncome: isIncome),

            InfoTileList(
              items: [
                InfoTileItem(
                  icon: Icons.calendar_today_outlined,
                  label: 'Date',
                  value: date,
                ),
                InfoTileItem(
                  icon: Icons.grid_view_rounded,
                  label: 'Category',
                  value: category,
                ),
                InfoTileItem(
                  icon: Icons.description_outlined,
                  label: 'Description',
                  value: type,
                ),
              ],
            ),

            SizedBox(height: 20),

            ActionButtonsRow(
              onEditPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionEditScreen(
                      category: category,
                      date: date,
                      title: title,
                      type: type,
                      amount: amount.toString(),
                      id: transaction.id!,
                    ),
                  ),
                );
              },
              onDeletePressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteConfirmationDialog(
                      title: title,
                      onDeleteConfirmed: () async {
                        await provider.deleteTransaction(transaction);

                        if (context.mounted) {
                          Navigator.pop(context);
                          CustomSnackBar.show(
                            context,
                            message: 'Transaction Deleted successfully!',
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
