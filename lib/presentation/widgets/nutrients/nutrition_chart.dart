import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class NutritionChart extends StatelessWidget {
  final double? calories;
  final double? proteins;
  final double? fats;
  final double? carbohydrates;

  final double dailyCaloriesLimit = 2000;
  final double dailyProteinsLimit = 50;
  final double dailyFatsLimit = 70;
  final double dailyCarbohydratesLimit = 310;

  const NutritionChart({
    Key? key,
    this.calories,
    this.proteins,
    this.fats,
    this.carbohydrates,
  }) : super(key: key);
  double calculatePercentage(double value, double limit) {
    return (value / limit) * 100;
  }

  @override
  Widget build(BuildContext context) {
    double safeCalories = calories ?? 0;
    double safeProteins = proteins ?? 0;
    double safeFats = fats ?? 0;
    double safeCarbohydrates = carbohydrates ?? 0;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: calculatePercentage(safeCalories, dailyCaloriesLimit),
                width: 20,
                color: Colors.red,
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: calculatePercentage(safeProteins, dailyProteinsLimit),
                width: 20,
                color: Colors.green,
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: calculatePercentage(safeFats, dailyFatsLimit),
                width: 20,
                color: Colors.blue,
              ),
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                toY: calculatePercentage(
                    safeCarbohydrates, dailyCarbohydratesLimit),
                width: 20,
                color: Colors.yellow,
              ),
            ],
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 25,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text('${value.toInt()}%',
                    style: const TextStyle(color: Color(0xff7589a2)));
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (double value, TitleMeta meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Text('Calorías');
                  case 1:
                    return const Text('Proteínas');
                  case 2:
                    return const Text('Grasas');
                  case 3:
                    return const Text('Carbohidratos');
                  default:
                    return const Text('');
                }
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
      ),
    );
  }
}
