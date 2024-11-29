import 'package:sqlite3/sqlite3.dart'; // Importando o sqlite3

// Função para criar ou abrir o banco de dados
Database openDatabaseConnection() {
  final databasePath = "example.db"; // Caminho do banco de dados
  final db = sqlite3.open(databasePath); // Abre ou cria o banco de dados
  return db;
}

// Função para criar uma tabela
void createTable(Database db) {
  db.execute('''
    CREATE TABLE IF NOT EXISTS users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      age INTEGER NOT NULL
    );
  ''');
}

// Função para inserir um usuário
void insertUser(Database db, String name, int age) {
  db.execute('''
    INSERT INTO users (name, age) 
    VALUES (?, ?);
  ''', [name, age]);
}

// Função para obter todos os usuários
ResultSet getUsers(Database db) {
  final result = db.select('SELECT * FROM users');
  return result;
}

// Função para atualizar um usuário
void updateUser(Database db, int id, String name, int age) {
  db.execute('''
    UPDATE users 
    SET name = ?, age = ?
    WHERE id = ?;
  ''', [name, age, id]);
}

// Função para excluir um usuário
void deleteUser(Database db, int id) {
  try {
    db.execute('''
    DELETE FROM users WHERE id = ?;
  ''', [id]);
  } catch (error) {
    print("Não foi possivel remover o usuario Motivo: $error");
  }
}

void main() {
  final db = openDatabaseConnection();

  // Criar a tabela
  createTable(db);

  // Inserir usuários
  insertUser(db, 'John Doe', 30);
  insertUser(db, 'Jane Doe', 28);

  // Consultar usuários
  final users = getUsers(db);
  print(users);

  // Atualizar usuário
  updateUser(db, 1, 'John Smith', 31);

  // Excluir um usuário
  deleteUser(db, 2);

  // Consultar novamente após alterações
  final updatedUsers = getUsers(db);
  print(updatedUsers);

  // Fechar o banco de dados
  db.dispose();
}
