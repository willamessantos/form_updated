class User {
  int id;
  String name;
  String email;
  String cpf;
  String cep;
  String rua;
  String numero;
  String bairro;
  String cidade;
  String uf;
  String pais;

  User(
      {this.id,
      this.name,
      this.email,
      this.cpf,
      this.cep,
      this.rua,
      this.numero,
      this.bairro,
      this.cidade,
      this.uf,
      this.pais});

  Map<String, dynamic> toDB() {
    var userMap = {
      'name': this.name,
      'email': this.email,
      'cpf': this.cpf,
      'cep': this.cep,
      'rua': this.rua,
      'numero': this.numero,
      'bairro': this.bairro,
      'cidade': this.cidade,
      'uf': this.uf,
      'pais': this.pais,
    };
  }

  factory User.fromDB(Map<String, dynamic> user) {
    return User(
      id: user['id'] as int,
      name: user['name'],
      email: user['email'],
      cpf: user['cpf'],
      cep: user['cep'],
      rua: user['rua'],
      numero: user['numero'],
      bairro: user['bairro'],
      cidade: user['cidade'],
      uf: user['uf'],
      pais: user['pais'],
    );
  }
}
