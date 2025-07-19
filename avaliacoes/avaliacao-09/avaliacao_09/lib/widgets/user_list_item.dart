import 'package:flutter/material.dart';
import '../models/user.dart';

class UserListItem extends StatelessWidget {
  final User user;

  const UserListItem({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: user.avatarUrl != null 
              ? NetworkImage(user.avatarUrl!) 
              : null,
          child: user.avatarUrl == null ? Text(user.name[0]) : null,
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }
}