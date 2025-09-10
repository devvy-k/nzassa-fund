import 'dart:async';
import 'dart:developer' as console;

import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectBudget extends StatefulWidget {
  final ProjectModel project;
  const ProjectBudget({super.key, required this.project});

  @override
  State<ProjectBudget> createState() => _ProjectBudgetState();
}

class _ProjectBudgetState extends State<ProjectBudget> {
  double collected = 1850600;
  double target = 2000000;
  bool showTooltip = false;

  Timer? _timer;

  @override
  void initState(){
    super.initState();
    console.log('Pourcentage: ${(widget.project.totalCollected! / widget.project.collectGoal * 100).toStringAsFixed(1)}%');
  }

  void _onTapBar() {
    setState(() {
      showTooltip = true;
    });

    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        showTooltip = false;
      });
    });
  }

  String formatAmount(double amount) {
    return NumberFormat("#,##0", "fr_FR").format(amount) + ' FCFA';
  }

  @override
  Widget build(BuildContext context) {
    final progress = (widget.project.totalCollected! /
            widget.project.collectGoal)
        .clamp(0.0, 1.0);
    final percentage = (progress * 100).toStringAsFixed(1);

    return LayoutBuilder(
      builder: (context, constraints) {
        final barWidth = constraints.maxWidth;
        final tooltipX = (progress * barWidth).clamp(0.0, barWidth - 90);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _onTapBar,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange.shade100,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.transparent,
                        color: progress == 1 ? Colors.green : Colors.orange,
                        minHeight: 20,
                      ),
                    ),
                  ),
                  Text(
                    '$percentage%',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (showTooltip)
                    Positioned(
                      left: tooltipX,
                      top: -35,
                      child: Material(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            formatAmount((widget.project.totalCollected ?? 0).toDouble()),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40),
                Text(
                  '🎯 ${formatAmount((widget.project.collectGoal).toDouble())}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}