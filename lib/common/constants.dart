const String WALLET = 'Wallet';
const String LIST_OF_ACCOUNTS = 'List of accounts';
const String HOME = 'Home';
const String CATEGORIES = 'Categories';

// Colors
const int BLUE_INT = 0xFF42A5F5;
const int GREEN_INT = 0xFF4CAF50;
const int INDIGO_INT = 0xFF5C6BC0;
const int TEAL_INT = 0xFF4DB6AC;
const int ORANGE_INT = 0xFFFFB74D;
const int OFF_WHITE_INT = 0xFFf5f5f5;

const String BLUE_STRING = 'blue';
const String GREEN_STRING = 'green';
const String INDIGO_STRING = 'indigo';
const String TEAL_STRING = 'teal';
const String ORANGE_STRING = 'orange';
const String OFF_WHITE_STRING = 'off_white';

const Map<String, int> COLORS_MAP = {
  BLUE_STRING: BLUE_INT,
  GREEN_STRING: GREEN_INT,
  INDIGO_STRING: INDIGO_INT,
  TEAL_STRING: TEAL_INT,
  ORANGE_STRING: ORANGE_INT,
};

final List<String> colorsListString = COLORS_MAP.keys.toList();

const String EXPENSE_STRING = 'expense';
const String INCOME_STRING = 'income';
const String TRANSFER_STRING = 'transfer';

const int EXPENSE_INT = 0;
const int INCOME_INT = 1;
const int TRANSFER_INT = 2;

const Map<int, String> TRANSACTION_TYPE = {
  EXPENSE_INT: EXPENSE_STRING,
  INCOME_INT: INCOME_STRING,
  TRANSFER_INT: TRANSFER_STRING,
};

// database constants
const String TABLE_ACCOUNTS = 'accounts';
const String COLUMN_ID = 'id';
const String COLUMN_COLOR = 'color';
const String COLUMN_POSITION = 'position';
const String COLUMN_ACCOUNT_TRANSFER_TO_ID = 'account_transfer_to_id';

const String TABLE_ITEMS = 'items';
const String COLUMN_AMOUNT = 'amount';
const String COLUMN_ACCOUNT_ID = 'account_id';
const String COLUMN_CATEGORY_ID = 'category_id';
const String COLUMN_TRANSACTION_TYPE = 'transaction_type';

const String TABLE_CATEGORY = 'categories';
const String COLUMN_NAME = 'name';

// paths
const String PATH_HOME = '/';
const String PATH_ACCOUNT_ADD = '/account/add';
const String PATH_ACCOUNT_SETTINGS = '/account/settings';
const String PATH_ITEM_ADD = '/item/add';
const String PATH_ITEM_UPDATE ='/item/update';
const String PATH_CATEGORY_ADD = '/category/add';

int transferCategoryId;
