import 'package:expense_repository/expense_repository.dart';

abstract class ExpenseRepository {
  Future<void> createCategory(Category category);
  Future<List<Category>> getCategory();

  Future<void> createExpense(Expense expense);
  Future<List<Expense>> getExpenses(String uid);

  Future<void> createUser(AppUser appUser);
  Future<void> updateUser(String uid, DateTime lastLogin);
}
