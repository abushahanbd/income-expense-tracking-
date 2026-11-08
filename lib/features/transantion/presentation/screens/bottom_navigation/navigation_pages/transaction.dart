import 'package:flutter/material.dart';
import 'package:money_management/core/constant/app_color.dart';
import 'package:money_management/core/constant/app_text.dart';
import 'package:money_management/features/transantion/presentation/provider/transaction_provider.dart';
import 'package:money_management/features/transantion/presentation/screens/add_transaction_screen.dart';
import 'package:money_management/features/transantion/presentation/screens/transaction_details_screen.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_add_action_button.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_app_bar.dart';
import 'package:money_management/features/transantion/presentation/widgets/filter_button.dart';
import 'package:money_management/features/transantion/presentation/widgets/transaction_list_tile.dart';
import 'package:provider/provider.dart';

class TrasnsactionScreen extends StatefulWidget {
  const TrasnsactionScreen({super.key});

  @override
  State<TrasnsactionScreen> createState() => _TrasnsactionScreenState();
}

class _TrasnsactionScreenState extends State<TrasnsactionScreen> {
  // Track the currently selected option
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Income', 'Expense'];
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final filteredTransactions = provider.transaction.where((transaction) {
      if (_selectedFilter == 'All') {
        return true;
      }

      return transaction.type == _selectedFilter;
    }).toList();
    return Scaffold(
      appBar: CustomAppBar(
        iconColor: AppColors.textSecondary,
        title: AppText.transactions,
        leftIcon: Icons.list,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            FilterButtonGroup(
              filters: _filters,
              selectedFilter: _selectedFilter,
              onFilterChanged: (value) {
                setState(() {
                  _selectedFilter = value;
                });
              },
            ),

            Expanded(
              child: filteredTransactions.isEmpty
                  ? const Center(
                      child: Text(
                        'No transactions found',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredTransactions.length,
                      itemBuilder: (context, index) {
                        final _tran = filteredTransactions[index];
                        return TransactionListTile(
                          title: _tran.title,
                          category: _tran.category,
                          amount: _tran.amount.toStringAsFixed(2),
                          date: _tran.date,
                          isIncome: _tran.type == 'Income',
                          icon: _tran.type == 'Income'
                              ? Icons.arrow_downward_outlined
                              : Icons.arrow_upward_outlined,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrasnsactionDetailsScreen(
                                  transaction: _tran,
                                  isIncome: _tran.type == 'Income',
                                  category: _tran.category,
                                  date: _tran.date,
                                  title: _tran.title,
                                  type: _tran.type,
                                  amount: _tran.amount.toStringAsFixed(2),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: CustomAddActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransactionScreen()),
          );
        },
      ),
    );
  }
}
