import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx_auth/controllers/user_controller.dart';
import 'package:totalx_auth/models/user_profile.dart';
import 'package:totalx_auth/services/user_service.dart';

class UserView extends StatelessWidget {
  Color bcolor = const Color.fromARGB(255, 198, 198, 198);
  String selectedSortOption = 'All';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.place, color: Colors.white),
        backgroundColor: Colors.black,
        leadingWidth: 10,
        title: const Text('Nilambur',
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: bcolor)),
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      onChanged: (s) {
                        context.read<UserService>().searchuser(s);
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "search by name",
                        hintStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                        prefixIcon: Image.asset('assets/srch.png'),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Default sorting option

                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext contex) {
                          return StatefulBuilder(builder: (_, setter) {
                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                      title: Text(
                                    "Sort",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),
                                  ListTile(
                                    title: Text('All'),
                                    leading: Radio(
                                      value: 'All',
                                      groupValue: selectedSortOption,
                                      onChanged: (value) {
                                        setter(() {
                                          selectedSortOption = value as String;
                                          contex
                                              .read<UserService>()
                                              .sortByAge(selectedSortOption);
                                        });
                                        Navigator.pop(contex);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text('Age: Elder'),
                                    leading: Radio(
                                      value: 'Elder',
                                      groupValue: selectedSortOption,
                                      onChanged: (value) {
                                        setter(() {
                                          selectedSortOption = value as String;
                                          contex
                                              .read<UserService>()
                                              .sortByAge(selectedSortOption);
                                        });
                                        Navigator.pop(contex);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text('Age: Younger'),
                                    leading: Radio(
                                      value: 'Younger',
                                      groupValue: selectedSortOption,
                                      onChanged: (value) {
                                        setter(() {
                                          selectedSortOption = value as String;
                                          contex
                                              .read<UserService>()
                                              .sortByAge(selectedSortOption);
                                        });
                                        Navigator.pop(contex);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<UserService>(
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddUserBottomSheet(context);
        },
        child: const Icon(Icons.add),
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
    String? name, age, image;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add User',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // ignore: unnecessary_null_comparison
              if (name != null && age != null && image != null) {
                Navigator.pop(context);
                context.read<UserService>().adduser(name, age, image);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
