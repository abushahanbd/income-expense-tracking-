import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_management/core/constant/app_color.dart';
import 'package:money_management/core/constant/app_text.dart';
import 'package:money_management/features/transantion/presentation/provider/transaction_provider.dart';
import 'package:money_management/features/transantion/presentation/widgets/current_balance_card.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_app_bar.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_pi_chart.dart';
import 'package:money_management/features/transantion/presentation/widgets/custom_stas_filter.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  String selectedPeriod = 'This Month';

  final List<Color> categoryColors = [
    Colors.blue,
    Colors.orange,
    Colors.pinkAccent,
    AppColors.primary,
  ];
  @override
  Widget build(BuildContext context) {
    final categories = ['Food', 'Rent', 'Shopping', 'Others'];
    final provider = context.watch<TransactionProvider>();
    final sections = categories.asMap().entries.map((entry) {
      final index = entry.key;
      final category = entry.value;

      final totalAmount = provider.transaction
          .where((t) => t.category == category && t.type == 'Expense')
          .fold<double>(0, (sum, t) => sum + t.amount);

      return PieChartSectionData(
        value: totalAmount,
        color: categoryColors[index],
        radius: 75,
        showTitle: false,
      );
    }).toList();

    final totalExpense = provider.transaction
        .where((t) => t.type == 'Expense')
        .fold<double>(0, (sum, t) => sum + t.amount);

    return Scaffold(
      appBar: CustomAppBar(
        iconColor: AppColors.textSecondary,
        title: AppText.statistics,
        leftIcon: Icons.bar_chart,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time Filter
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    ...['This Month', 'Last Month', 'This Year'].map((period) {
                      final isSelected = selectedPeriod == period;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPeriod = period;
                            });
                          },
                          child: customStatsfilter(
                            isSelected: isSelected,
                            period: period,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Income vs Expense Chart
              CustomIcomeExpensePiChart(
                icomeAmount: provider.totalIncome,
                expenseAmount: provider.totalExpense,
                totalAmount: provider.totalTransaction.toString(),
              ),

              const SizedBox(height: 12),

              // Balance Card
              CurrentBalanceCard(
                currentBalance: provider.currentBalance.toString(),
              ),

              const SizedBox(height: 30),

              // Expense By Category
              const Text(
                'Expense by Category',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 30),

              // Category Pie Chart and Legend
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: 165,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 0,
                          startDegreeOffset: -90,
                          sections: sections,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        ...categories.asMap().entries.map((entry) {
                          int index = entry.key;
                          String name = entry.value;

                          final amount = provider.transaction
                              .where(
                                (t) =>
                                    t.category == name && t.type == 'Expense',
                              )
                              .fold<double>(0, (sum, t) => sum + t.amount);

                          final percentage = totalExpense == 0
                              ? 0.0
                              : (amount / totalExpense) * 100;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                // Color Icon
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color: categoryColors[index],
                                    shape: BoxShape.circle,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // Category Name
                                Expanded(child: Text(name)),

                                // Percentage
                                Text(
                                  '${percentage.toStringAsFixed(1)}%',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
