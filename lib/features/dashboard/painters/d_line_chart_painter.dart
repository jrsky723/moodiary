// import 'package:flutter/material.dart';
// import 'package:moodiary/constants/mood.dart';
// import 'package:moodiary/constants/sizes.dart';
// import 'package:moodiary/features/dashboard/models/mood_entry.dart';
// import 'package:moodiary/painter_utils.dart';

// class LineChartPainter extends CustomPainter {
//   final List<MoodEntry> moodEntries;
//   final bool isMonthly;

//   LineChartPainter({
//     required this.moodEntries,
//     required this.isMonthly,
//   });

//   void drawMoodLines({
//     required List<MoodEntry> moodEntries,
//     required Canvas canvas,
//     required Size size,
//   }) {
//     const minScore = 1;
//     const maxScore = 5;
//     // 각 점을 연결하는 선에 그라데이션 적용
//     for (int i = 0; i < moodEntries.length - 1; i++) {
//       final startX = size.width * i / moodEntries.length;
//       final endX = size.width * (i + 1) / moodEntries.length;

//       final startYValue =
//           (moodEntries[i].mood.score - minScore) / (maxScore - minScore);
//       final endYValue =
//           (moodEntries[i + 1].mood.score - minScore) / (maxScore - minScore);

//       final startY = size.height - startYValue * size.height;
//       final endY = size.height - endYValue * size.height;

//       final startPoint = Offset(startX, startY);
//       final endPoint = Offset(endX, endY);

//       final gradient = Paint()
//         ..shader = LinearGradient(
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//           colors: [moodEntries[i].mood.color, moodEntries[i + 1].mood.color],
//         ).createShader(Rect.fromPoints(startPoint, endPoint))
//         ..strokeWidth = 2;

//       // 점마다 원 그리기
//       final circlePaint = Paint()
//         ..color = moodEntries[i].mood.color
//         ..style = PaintingStyle.fill;

//       const circleRadius = 3.0;
//       canvas.drawCircle(startPoint, circleRadius, circlePaint);
//       canvas.drawCircle(endPoint, circleRadius, circlePaint);

//       canvas.drawLine(startPoint, endPoint, gradient);
//     }
//   }

//   void drawVerticalLines({
//     required int interval,
//     required Canvas canvas,
//     required Size size,
//   }) {
//     final linePaint = Paint()
//       ..color = Colors.grey.withOpacity(0.3)
//       ..strokeWidth = 2;

//     for (int i = 0; i < moodEntries.length; i += interval) {
//       final x = size.width * i / moodEntries.length;
//       final start = Offset(x, 0);
//       final end = Offset(x, size.height);
//       drawDottedVerticalLine(canvas, start, end, linePaint);
//     }
//   }

//   void drawText({
//     required int interval,
//     required Canvas canvas,
//     required Size size,
//     required bool isMonthly,
//   }) {
//     final textPainter = TextPainter(
//       textDirection: TextDirection.ltr,
//     );

//     for (int i = 0; i < moodEntries.length; i += interval) {
//       final x = size.width * i / moodEntries.length;
//       // date text Example: 01/01
//       final dateText = isMonthly
//           ? "${moodEntries[i].date.month}/${moodEntries[i].date.day}"
//           : "${moodEntries[i].date.month}";
//       textPainter.text = TextSpan(
//         text: dateText,
//         style: const TextStyle(
//           color: Colors.grey,
//           fontSize: Sizes.size12,
//         ),
//       );
//       textPainter.layout(
//         minWidth: 0,
//         maxWidth: size.width,
//       );
//       textPainter.paint(
//         canvas,
//         Offset(
//           x - textPainter.width / 2,
//           size.height + textPainter.height,
//         ),
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     drawMoodLines(
//       moodEntries: moodEntries,
//       canvas: canvas,
//       size: size,
//     );

//     if (isMonthly) {
//       drawVerticalLines(
//         interval: 5,
//         canvas: canvas,
//         size: size,
//       );
//       drawText(
//         interval: 5,
//         canvas: canvas,
//         size: size,
//         isMonthly: isMonthly,
//       );
//     } else {
//       drawVerticalLines(
//         interval: 1,
//         canvas: canvas,
//         size: size,
//       );
//       drawText(
//         interval: 1,
//         canvas: canvas,
//         size: size,
//         isMonthly: isMonthly,
//       );
//     }
//   }
// }
