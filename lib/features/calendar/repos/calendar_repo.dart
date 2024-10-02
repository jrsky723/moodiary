import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarRepository {
  // 캘린더에 해당하는 일기를 가져오기 위한 repository
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> fetchDiariesByUserAndMonth(
      String uid, DateTime month) {
    // 사용자의 uid와 해당 월을 받아서 해당 월에 해당하는 일기들을 가져옴
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 0);

    final query = _db
        .collection('users')
        .doc(uid)
        .collection('diaries')
        .where('date', isGreaterThanOrEqualTo: start)
        .where('date', isLessThanOrEqualTo: end);
    return query.get();
  }
}

final calendarRepo = Provider((ref) => CalendarRepository());
