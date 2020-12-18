import 'package:flutter/material.dart';
import 'package:form_updated/infra/db_sqflite.dart';
import 'package:form_updated/models/user.dart';
import 'package:form_updated/pages/form_user.dart';
import 'package:form_updated/repositories/user_repository.dart';

class ListUsersPage extends StatefulWidget {
  @override
  _ListUsersPageState createState() => _ListUsersPageState();
}

class _ListUsersPageState extends State<ListUsersPage> {
  //var users = <User>[];

  var repository = UserRepository(DBSQLite());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
      ),
      body: FutureBuilder(
        initialData: <User>[],
        future: repository.getUsers(),
        builder: (_, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var users = snapshot.data;
          return ListView.builder(
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
                onLongPress: () async {
                  var deleted = await repository.deleteUser(user.id);
                  if (deleted) {
                    setState(() {
                      users.removeAt(index);
                    });
                  }
                },
              );
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
              //users.add(user);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
