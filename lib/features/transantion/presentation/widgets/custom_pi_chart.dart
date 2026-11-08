import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_management/core/constant/app_color.dart';

class CustomIcomeExpensePiChart extends StatelessWidget {
  CustomIcomeExpensePiChart({
    super.key,

    required this.icomeAmount,
    required this.expenseAmount,
    required this.totalAmount,
  });

  double icomeAmount;
  double expenseAmount;
  String totalAmount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: SizedBox(
            height: 190,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 48,
                    startDegreeOffset: -90,
                    sections: [
                      PieChartSectionData(
                        value: icomeAmount,
                        color: AppColors.income,
                        radius: 14,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: expenseAmount,
                        color: AppColors.expense,
                        radius: 14,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '৳${totalAmount}',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.circle, color: AppColors.income, size: 10),
                  const SizedBox(width: 7),
                  const Text('Income', style: TextStyle(fontSize: 13)),
                ],
              ),
              const SizedBox(height: 5),

              Padding(
                padding: EdgeInsets.only(left: 17),
                child: Text(
                  '৳ ${icomeAmount}',

                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.income,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  const Icon(Icons.circle, color: AppColors.expense, size: 10),
                  const SizedBox(width: 7),
                  const Text('Expense', style: TextStyle(fontSize: 13)),
                ],
              ),

              const SizedBox(height: 5),

              Padding(
                padding: EdgeInsets.only(left: 17),
                child: Text(
                  '৳ ${expenseAmount}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.expense,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
