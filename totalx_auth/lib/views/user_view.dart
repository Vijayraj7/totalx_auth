import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        // leading: const Icon(Icons.place, color: Colors.white),
        backgroundColor: Colors.black,
        leadingWidth: 10,
        title: Row(
          children: [
            Icon(Icons.place, color: Colors.white),
            Text('Nilambur',
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 0, top: 10, right: 10),
            // margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
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
                        backgroundColor: Colors.white,
                        // isScrollControlled: true,
                        builder: (BuildContext contex) {
                          return StatefulBuilder(builder: (_, setter) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
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
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 160),
                  itemCount: controller.users.length,
                  itemBuilder: (context, index) {
                    final UserProfile user = controller.users[index];
                    return Card(
                      // shadowColor: Colors.white,
                      // surfaceTintColor: Colors.white,
                      color: Colors.white,
                      child: ListTile(
                        minVerticalPadding: 25,
                        tileColor: Colors.transparent,
                        leading: user.image.startsWith("http")
                            ? CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(user.image),
                              )
                            : user.image.startsWith("/data")
                                ? CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        FileImage(File(user.image)),
                                  )
                                : CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(user.image),
                                  ),
                        title: Text(
                          user.name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: CircleBorder(),
        onPressed: () {
          _showAddUserBottomSheet(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showAddUserBottomSheet(BuildContext context) {
    saved = false;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (contex) =>
          AddUserBottomSheet(screenHeight - keyboardHeight - 145),
    );
  }
}

String name = "";
String age = "";
String image = "";
bool saved = true;

class AddUserBottomSheet extends StatelessWidget {
  double height;
  AddUserBottomSheet(this.height);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
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
            StatefulBuilder(builder: (_, setter) {
              return GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    // File location of the picked image
                    String imagePath = pickedFile.path;
                    setter(() {
                      image = imagePath;
                    });
                    // print('Image location: $imagePath');
                  } else {
                    // print('No image selected.');
                  }
                },
                child: Center(
                  child: image.isEmpty
                      ? Image.asset('assets/selpic.png')
                      : CircleAvatar(
                          backgroundImage: FileImage(File(image)),
                          radius: 50,
                        ),
                ),
              );
            }),
            const SizedBox(height: 8),
            add_user_textfield(
              name: "Name",
              onChanged: (s) {
                name = s;
              },
            ),
            const SizedBox(height: 18),
            add_user_textfield(
              name: "Age",
              onChanged: (s) {
                age = s;
              },
              type: TextInputType.number,
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
                      // image = "assets/usr/usr2.png";
                      // ignore: unnecessary_null_comparison
                      if (name.isNotEmpty &&
                          age.isNotEmpty &&
                          image.isNotEmpty) {
                        Navigator.pop(context);
                        if (saved == false) {
                          context.read<UserService>().adduser(name, age, image);
                          name = "";
                          age = "";
                          image = "";
                          saved = true;
                        }
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
      {required void Function(String)? onChanged,
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
                color: Colors.grey[600],
                fontSize: 13,
                fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[350]!)),
          child: TextField(
            keyboardType: type,
            // controller: cntrl,
            onChanged: onChanged,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: name,
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
                contentPadding: EdgeInsets.all(7)),
          ),
        )
      ],
    );
  }
}
