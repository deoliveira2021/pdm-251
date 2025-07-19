import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../widgets/user_list_item.dart';
import '../widgets/error_widget.dart'; // This now imports CustomErrorWidget

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<User>> _futureUsers;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _futureUsers = _apiService.fetchUsers();
  }

  Future<void> _refreshData() async {
    setState(() {
      _futureUsers = _apiService.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return CustomErrorWidget( // Changed from ErrorWidget to CustomErrorWidget
              errorMessage: 'Erro ao carregar usuários: ${snapshot.error}',
              onRetry: _refreshData,
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum usuário encontrado'));
          } else {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return UserListItem(user: snapshot.data![index]);
                },
              ),
            );
          }
        },
      ),
    );
  }
}