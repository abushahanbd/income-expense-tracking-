import 'package:flutter/material.dart';
import 'package:money_management/core/constant/app_color.dart';
import 'package:money_management/core/constant/app_text.dart';
import 'package:money_management/features/transantion/presentation/provider/transaction_provider.dart';
import 'package:money_management/features/transantion/presentation/screens/add_transaction_screen.dart';
import 'package:money_management/features/transantion/presentation/screens/bottom_navigation/navigation_pages/transaction.dart';
import 'package:money_management/features/transantion/presentation/screens/transaction_details_screen.dart';
import 'package:money_management/features/transantion/presentation/widgets/balance_card.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_add_action_button.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_app_bar.dart';
import 'package:money_management/features/transantion/presentation/widgets/summery_card.dart';
import 'package:money_management/features/transantion/presentation/widgets/transaction_list_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    return Scaffold(
      appBar: CustomAppBar(
        leftIcon: Icons.account_balance_wallet_rounded,

        title: AppText.appName,
        rightIcon: Icons.settings,
        onTap: () {
          print('Clicked');
        },
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  SummaryCard(
                    title: AppText.totalIncome,
                    amount: provider.totalIncome.toStringAsFixed(2),
                    icon: Icons.arrow_downward_rounded,
                    color: AppColors.income,
                  ),

                  SummaryCard(
                    title: AppText.totalExpense,
                    amount: provider.totalExpense.toStringAsFixed(2),
                    icon: Icons.arrow_upward_outlined,
                    color: AppColors.expense,
                  ),
                ],
              ),

              BalanceCard(
                title: AppText.currentBalance,
                amount: provider.currentBalance.toStringAsFixed(2),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppText.recentTransactions,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrasnsactionScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      AppText.seeAll,
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: provider.transaction.length,
                  itemBuilder: (context, index) {
                    final _tran = provider.transaction[index];
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
