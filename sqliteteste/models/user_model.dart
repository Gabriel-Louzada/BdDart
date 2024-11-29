class User {
  final int id;
  final String nome;
  final int idade;

  //Construtor
  User({
    required this.id,
    required this.nome,
    required this.idade,
  });

  //Esse metodo irá me retornar um user apartir de um mapa
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["id"], //dentro das aspas esta o nome da coluna dentro do banco de dados
      nome: map["name"], //dentro das aspas esta o nome da coluna dentro do banco de dados
      idade: map["age"], //dentro das aspas esta o nome da coluna dentro do banco de dados
    );
  }
}
