import 'package:flutter/material.dart';
import 'package:form_updated/infra/db_sqflite.dart';
import 'package:form_updated/models/user.dart';
import 'package:form_updated/repositories/user_repository.dart';
import 'package:form_updated/widgets/default_input.dart';

class FormUserPage extends StatefulWidget {
  final User user;

  const FormUserPage({this.user});

  @override
  _FormUserPageState createState() => _FormUserPageState();
}

class _FormUserPageState extends State<FormUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User user;

  @override
  void initState() {
    super.initState();

    user = widget?.user ?? User();
  }

  void saveUser() async {
    if (!_formKey.currentState.validate()) {
      showSnackBar('Formulário Inválido', Colors.red);
      return;
    }

    _formKey.currentState.save();

    var repository = UserRepository(DBSQLite());

    if (user.id != null) {
      var updated = await repository.updateUser(user);
      if (!updated) {
        showSnackBar('Usuário não atualizado', Colors.red);
        return;
      } else {
        user.id = await repository.saveUser(user);
      }
    }

    user.id = await repository.saveUser(user);

    Navigator.of(context).pop(user);
  }

  void showSnackBar(String message, Color color) {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  String validator(String value) => value.isEmpty ? 'Campo obrigatório' : null;

  // final user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('${user.name == null ? 'Novo' : 'Editar'} Usuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DefaultInput(
                        initialValue: user?.name,
                        label: 'Nome Completo',
                        validator: validator,
                        onSaved: (value) => user.name = value,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DefaultInput(
                        initialValue: user?.email,
                        label: 'Email',
                        validator: validator,
                        onSaved: (value) => user.email = value,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DefaultInput(
                        initialValue: user?.cpf,
                        label: 'CPF',
                        validator: validator,
                        onSaved: (value) => user.cpf = value,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DefaultInput(
                              initialValue: user?.cep,
                              label: 'CEP',
                              validator: validator,
                              onSaved: (value) => user.cep = value,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: OutlineButton.icon(
                              textColor: Color(0xFF6200EE),
                              //highlightedBorderColor:
                              //Colors.black.withOpacity(0.12),
                              onPressed: () {},
                              icon: Icon(Icons.search,
                                  size: 18, color: Colors.black),
                              label: Text(
                                'Buscar CEP',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DefaultInput(
                              initialValue: user?.rua,
                              label: 'Rua ',
                              validator: validator,
                              onSaved: (value) => user.rua = value,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: DefaultInput(
                              initialValue: user?.numero,
                              label: 'Número',
                              validator: validator,
                              onSaved: (value) => user.numero = value,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: DefaultInput(
                              initialValue: user?.bairro,
                              label: 'Bairro',
                              validator: validator,
                              onSaved: (value) => user.bairro = value,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: DefaultInput(
                              initialValue: user?.cidade,
                              label: 'Cidade',
                              validator: validator,
                              onSaved: (value) => user.cidade = value,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: DefaultInput(
                              initialValue: user?.uf,
                              label: 'UF',
                              validator: validator,
                              onSaved: (value) => user.uf = value,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: DefaultInput(
                              initialValue: user?.pais,
                              label: 'País',
                              validator: validator,
                              onSaved: (value) => user.pais = value,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlineButton(
                onPressed: saveUser,
                child: Text(
                  'Cadastrar',
                  style: TextStyle(color: Colors.red),
                ),
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
