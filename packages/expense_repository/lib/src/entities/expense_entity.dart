import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class ExpenseEntity {
  String expenseId;
  String uid;
  Category category;
  DateTime date;
  int amount;

  ExpenseEntity({
    required this.expenseId,
    required this.uid,
    required this.category,
    required this.date,
    required this.amount,

  });
  Map<String, Object?> toDocument() {
    return {
      'expenseId': expenseId,
      'uid': uid,
      'category': category.toEntity().toDocument(),
      'date': date,
      'amount': amount,
    };
  }

  static ExpenseEntity fromDocument(Map<String, dynamic> doc) {
    return ExpenseEntity(
      expenseId: doc['expenseId'],
      uid: doc['uid'],
      category:Category.fromEntity(CategoryEntity.fromDocument(doc['category'])),
      date: (doc['date'] as Timestamp).toDate() ,
      amount: doc['amount'],
    );
  }
}
