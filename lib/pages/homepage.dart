// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/auth.dart';
import 'package:todo/data/database.dart';
import 'package:todo/utils/ToDoTile.dart';
import 'package:todo/utils/dialouge_box.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box("mybox");
  final _controller = TextEditingController();
  final User? user = Auth().currentUser;
  ToDoDataBase db = ToDoDataBase();
  List todo_list = [];
  Future<void> signOut() async {
    await Auth().signOut();
  }
  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createintialdata();
      todo_list = db.todolist;
    } else {
      db.loaddata();
    }
  }

  void checkboxchanged(bool? value, int index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
    });
    db.updatethedata();
  }

  void createnewtask() {
    showDialog(
        context: context,
        builder: (context) {
          return dialougebox(
            controller: _controller,
            onSave: savenewtask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(index) {
    setState(() {
      todo_list.removeAt(index);
    });
    db.todolist = todo_list;
    db.updatethedata();
  }

  void savenewtask() {
    setState(() {
      todo_list.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.todolist = todo_list;
    db.updatethedata();
  }
  Widget _signOutButton() {
    return ElevatedButton(
        onPressed: signOut,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow), // Change this to the desired color
      ),
        child: const Text('sign Out'),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade600,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade500,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              user?.email ?? 'User email',
              style: TextStyle(color: Colors.black),
            ),
            _signOutButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellowAccent,
        onPressed: () => createnewtask(),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          SearchBar(),
          Expanded(
            child: ListView.builder(
              itemCount: todo_list.length,
              itemBuilder: (BuildContext context, int index) {
                return ToDoTile(
                    taskName: todo_list[index][0],
                    taskCompleted: todo_list[index][1],
                    onChanged: (value) => checkboxchanged(value, index),
                    deleteFunction: (BuildContext) {
                      deleteTask(index);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget SearchBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.amber.shade200,
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
