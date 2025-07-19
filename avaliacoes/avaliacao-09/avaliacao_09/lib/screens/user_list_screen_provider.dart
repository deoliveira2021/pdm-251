import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/user_list_item.dart';
import '../widgets/error_widget.dart'; // This now imports CustomErrorWidget

class UserListScreenProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários (Provider)'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => Provider.of<UserProvider>(context, listen: false).fetchUsers(),
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading && userProvider.users.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (userProvider.error != null) {
            return CustomErrorWidget( // Changed from ErrorWidget to CustomErrorWidget
              errorMessage: userProvider.error!,
              onRetry: () => userProvider.fetchUsers(),
            );
          } else if (userProvider.users.isEmpty) {
            return Center(child: Text('Nenhum usuário encontrado'));
          } else {
            return RefreshIndicator(
              onRefresh: () => userProvider.fetchUsers(),
              child: ListView.builder(
                itemCount: userProvider.users.length,
                itemBuilder: (context, index) {
                  return UserListItem(user: userProvider.users[index]);
                },
              ),
            );
          }
        },
      ),
    );
  }
}