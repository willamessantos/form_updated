import 'package:flutter/material.dart';
import 'package:form_updated/pages/form_user.dart';

import 'pages/list_user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(    
        primarySwatch: Colors.red,        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListUsersPage(),

      
    );
  }
}


