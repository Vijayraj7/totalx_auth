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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[50],
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
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
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
                        isScrollControlled: true,
                        builder: (BuildContext contex) {
                          return StatefulBuilder(builder: (_, setter) {
                            return Container(
                              // height: screenHeight - keyboardHeight - 145,
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
                                  RadioListTile(
                                    title: Text('All'),
                                    // leading: Radio(
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
                                    // ),
                                  ),
                                  RadioListTile(
                                    title: Text('Age: Elder'),
                                    // leading: Radio(
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
                                    // ),
                                  ),
                                  RadioListTile(
                                    title: Text('Age: Younger'),
                                    // leading: Radio(
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
                                    // ),
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
          Container(
              child: ListTile(
            title: Text(
              "Users Lists",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
            ),
          )),
          Expanded(
            child: Consumer<UserService>(
              builder: (context, controller, _) {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemCount: controller.users.length,
                  itemBuilder: (context, index) {
                    final UserProfile user = controller.users[index];
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        minVerticalPadding: 25,
                        tileColor: Colors.transparent,
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(user.image),
                        ),
                        title: Text(
                          user.name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Age: " + user.age,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (contex) =>
          AddUserBottomSheet(screenHeight - keyboardHeight - 145),
    );
  }
}

class AddUserBottomSheet extends StatelessWidget {
  double height;
  TextEditingController name_cntrl = new TextEditingController();
  TextEditingController age_cntrl = new TextEditingController();
  AddUserBottomSheet(this.height);
  @override
  Widget build(BuildContext context) {
    String? name, age, image;
    return SingleChildScrollView(
      child: Container(
        height: height,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Add A New User',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              child: Center(
                child: Image.asset('assets/selpic.png'),
              ),
            ),
            const SizedBox(height: 8),
            add_user_textfield(
              name: "Name",
              cntrl: name_cntrl,
            ),
            const SizedBox(height: 18),
            add_user_textfield(
              name: "Age",
              type: TextInputType.number,
              cntrl: age_cntrl,
            ),
            const SizedBox(height: 36),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // ignore: unnecessary_null_comparison
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      name = name_cntrl.text;
                      age = age_cntrl.text;
                      image = "assets/usr/usr2.png";
                      // ignore: unnecessary_null_comparison
                      if (name != null && age != null && image != null) {
                        Navigator.pop(context);
                        context
                            .read<UserService>()
                            .adduser(name!, age!, image!);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[500],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
          ],
        ),
      ),
    );
  }

  Widget add_user_textfield(
      {required TextEditingController cntrl,
      required String name,
      TextInputType? type}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 15, bottom: 8),
          child: Text(
            name,
            style: TextStyle(
                fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[350]!)),
          child: TextField(
            key: ValueKey(name),
            keyboardType: type,
            controller: cntrl,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: name,
                hintStyle: TextStyle(color: Colors.grey[600]),
                contentPadding: EdgeInsets.all(7)),
          ),
        )
      ],
    );
  }
}
