import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx_auth/controllers/user_controller.dart';
import 'package:totalx_auth/models/user_profile.dart';
import 'package:totalx_auth/services/user_service.dart';

class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final userController = Provider.of<UserController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: Consumer<UserService>(
        builder: (context, controller, _) {
          return ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              final UserProfile user = controller.users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(user.image),
                ),
                title: Text(user.name),
                subtitle: Text(user.age),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddUserBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddUserBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddUserBottomSheet(),
    );
  }
}

class AddUserBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add User',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: 'Name'),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Add user logic
              // You can access the user controller to add the user
              // For simplicity, I'm just closing the bottom sheet here
              Navigator.pop(context);
              context.read<UserService>().adduser();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
