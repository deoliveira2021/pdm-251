import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/user_list_screen_provider.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..fetchUsers()),
      ],
      child: MaterialApp(
        title: 'Flutter API Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: UserListScreenProvider(), // ou UserListScreen para versão sem Provider
      ),
    );
  }
}