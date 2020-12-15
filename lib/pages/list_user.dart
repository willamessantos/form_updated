import 'package:flutter/material.dart';
import 'package:form_updated/models/user.dart';
import 'package:form_updated/pages/form_user.dart';

class ListUsersPage extends StatefulWidget {
  @override
  _ListUsersPageState createState() => _ListUsersPageState();
}

class _ListUsersPageState extends State<ListUsersPage> {
  var users = <User>[
    User(
        name: 'Willames Azevedo',
        email: 'will.santos.azevedo@gmail.com',
        cpf: '11122233344',
        cep: '12345678',
        rua: 'Projetada',
        numero: '140',
        bairro: 'São Paulo',
        cidade: 'Santana do Ipanema',
        uf: 'AL',
        pais: 'Brasil'),
    User(
        name: 'Willames Azevedo',
        email: 'will.santos.azevedo@gmail.com',
        cpf: '11122233344',
        cep: '87654321',
        rua: 'Projetada',
        numero: '140',
        bairro: 'Rio de Janeiro',
        cidade: 'Santana do Ipanema',
        uf: 'AL',
        pais: 'Brasil'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (_, index) {
          var user = users[index];

          return ListTile(
            leading: Icon(Icons.person),
            title: Text('${user.name}, CPF : ${user.cpf}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${user.email} '),
                Text('Endereço: Rua ${user.rua}, Bairro: ${user.bairro}'),
                Text('Cidade: ${user.cidade}, CEP: ${user.cep}'),
                Text('UF: ${user.uf} | País: ${user.pais}'),
              ],
            ),
            isThreeLine: true,
            onTap: () async {
              var userUpdated = await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => FormUserPage(user: user)),
              );

              if (userUpdated != null) {
                setState(() {
                  user = userUpdated;
                });
              }
            },
            onLongPress: () {
              setState(() {
                users.removeAt(index);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var user = await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => FormUserPage()),
          );
          if (user != null) {
            setState(() {
              users.add(user);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
