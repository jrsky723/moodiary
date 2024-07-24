// import 'package:flutter/material.dart';
// import 'package:moodiary/constants/mood.dart';
// import 'package:moodiary/constants/sizes.dart';
// import 'package:moodiary/features/dashboard/models/mood_entry.dart';

// class BarChartPainter extends CustomPainter {
//   final List<MoodEntry> moodEntries;

//   BarChartPainter({required this.moodEntries});

//   @override
//   void paint(Canvas canvas, Size size) {
//     const int minScore = 1;
//     const int maxScore = 5;
//     const int scoreRange = maxScore - minScore + 1;
//     final Map<Mood, int> frequencyMap = {};
//     int totalEntries = moodEntries.length;

//     // 점수별 빈도수 계산
//     for (var entry in moodEntries) {
//       frequencyMap[entry.mood] = (frequencyMap[entry.mood] ?? 0) + 1;
//     }

//     // 각 점수별 바와 퍼센트 그리기
//     Mood.values.asMap().forEach((index, mood) {
//       final scoreFrequency = frequencyMap[mood] ?? 0;
//       final percentage = (scoreFrequency / totalEntries) * 100;
//       final barAreaHeight = size.height / scoreRange;
//       final barHeight = size.height / scoreRange * 0.8;
//       final barLength = size.width * percentage / 100;

//       final paint = Paint()
//         ..color = mood.color
//         ..style = PaintingStyle.fill;

//       // 가로 바(bar) 그리기
//       final rect = Rect.fromLTWH(
//         0,
//         index * barAreaHeight + (barAreaHeight - barHeight) / 2,
//         barLength,
//         barHeight,
//       );
//       canvas.drawRect(rect, paint);

//       // 퍼센트 값 그리기
//       final percentageText = "${percentage.toStringAsFixed(1)}%";
//       final textSpan = TextSpan(
//         text: percentageText,
//         style: TextStyle(
//           color: Colors.grey.shade500,
//           fontSize: Sizes.size12,
//         ),
//       );
//       final textPainter = TextPainter(
//         text: textSpan,
//         textDirection: TextDirection.ltr,
//       );
//       textPainter.layout(minWidth: 0, maxWidth: size.width);
//       final x = barLength + Sizes.size8;
//       final y =
//           index * barAreaHeight + (barAreaHeight - textPainter.height) / 2;
//       textPainter.paint(canvas, Offset(x, y));
//     });
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
