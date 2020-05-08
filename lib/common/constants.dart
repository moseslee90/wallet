final String WALLET = 'Wallet';
final String LIST_OF_ACCOUNTS = 'List of accounts';

// Colors
final int BLUE = 0xFF42A5F5;
final int GREEN = 0xFF4CAF50;
final int INDIGO = 0xFF5C6BC0;
final int TEAL = 0xFF4DB6AC;
final int ORANGE = 0xFFFFB74D;

final int blue = 0;
final int green = 1;
final int indigo = 2;
final int teal = 3;
final int orange = 4;

final Map<int, int> colors = {
  blue: BLUE,
  green: GREEN,
  indigo: INDIGO,
  teal: TEAL,
  orange: ORANGE,
};

final String EXPENSE = 'expense';
final String INCOME = 'income';
final String TRANSFER = 'transfer';

final int expense = 0;
final int income = 1;
final int transfer = 2;

final Map<int, String> transactionType = {
  expense: EXPENSE,
  income: INCOME,
  transfer: TRANSFER,
};

// database constants
final String tableAccounts = 'accounts';
final String columnId = 'id';
final String columnColor = 'color';

final String tableItems = 'items';
final String columnAmount = 'amount';
final String columnAccountId = 'account_id';
final String columnCategoryId = 'category_id';
final String columnTransactionType = 'transaction_type';

final String tableCategory = 'category';
final String columnName = 'name';
