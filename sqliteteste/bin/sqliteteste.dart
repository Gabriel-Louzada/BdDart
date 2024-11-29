import 'dart:io';

import 'package:sqlite3/sqlite3.dart';
import 'package:sqliteteste/sqliteteste.dart';

void main() {
  Database db = openDatabaseConnection();
  createTable(db);

  menu(db);
}

checarValor() {
  String? valor = stdin.readLineSync();
  if (valor == null || valor.isEmpty) {
    print("\nCampo não preenchido digite novamente!");
    return checarValor();
  } else {
    return valor;
  }
}

inserirDados(Database db) {
  print("\nDigite o seu nome: ");
  String nome = checarValor();
  print("\nDigite a sua idade: ");
  int idade = int.parse(checarValor());

  insertUser(db, nome, idade);
}

verTodosUsuarios(db) {
  ResultSet mapUsuarios = getUsers(db); // resultset é o nome que se da ao retorno do banco de dados
  for (var i in mapUsuarios) {
    int id = i['id'];
    String name = i['name'];
    int age = i['age'];

    print("$id Nome: $name, Idade: $age");
  }
}

mudarNome(db) {
  print("\nDigite o novo nome: ");
  String nome = checarValor();
  print("\nDigite o nova idade: ");
  String idade = checarValor();
  print("\nDigite o ID: ");
  String id = checarValor();

  print("\nAlterando o Usuario de ID: $id");
  updateUser(db, int.parse(id), nome, int.parse(idade));
}

removerUsuario(db) {
  verTodosUsuarios(db);
  print("\nDigite o ID do usuario que deseja remover: ");

  String id = checarValor();

  deleteUser(db, int.parse(id));
}

menu(db) {
  print(
      "\nEscolha uma Opção: \n 1 - inserir nome \n 2 - Ver nomes \n 3 - Para alterar o nome ou a idade \n 4 - Para remover um usuario \n 5 - Para sair");
  String escolha = checarValor();
  switch (escolha) {
    case "1":
      print("\nInserindo Dados");
      inserirDados(db);
      menu(db);
    case "2":
      print("\nListar nomes:");
      verTodosUsuarios(db);
      menu(db);
    case "3":
      print("\nAlterar nome ou idade: ");
      mudarNome(db);
      menu(db);
    case "4":
      print("\nRemover usuario: ");
      removerUsuario(db);
      menu(db);
    case "5":
      print("\nFechando o App");
      break;
  }
}
