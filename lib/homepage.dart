import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/data/database.dart';
import 'package:todo/utils/ToDoTile.dart';
import 'package:todo/utils/dialouge_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox=Hive.box("mybox");
  final _controller=TextEditingController();
  ToDoDataBase db=ToDoDataBase();
  @override
  void initState() {
    if(_mybox.get("TODOLIST")==null){
      db.createintialdata();
    }
    else{
      db.loaddata();
    }
  }
  void checkboxchanged(bool? value, int index) {
    setState(() {
      db.todolist[index][1]=!db.todolist[index][1];
    });
    db.updatethedata();
  }
  void createnewtask(){
    showDialog(context: context, builder: (context){
      return dialougebox(controller:_controller ,
      onSave: savenewtask,
        onCancel:() => Navigator.of(context).pop(),
      );
    });
  }
  void deleteTask(index){
    setState(() {
      db.todolist.removeAt(index);
    });
    db.updatethedata();
  }
  void savenewtask(){
    setState(() {
      db.todolist.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updatethedata();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.yellow.shade600,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade500,
        title: Center(child: Text("TO DO APP",
        style: TextStyle(
            color: Colors.black
        ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellowAccent,
        onPressed: ()=>createnewtask(),
        child: Icon(Icons.add,color: Colors.black,),
      ),
      body: ListView.builder(
        itemCount: db.todolist.length,
        itemBuilder: (BuildContext context, int index) {
          return ToDoTile(taskName: db.todolist[index][0],
              taskCompleted: db.todolist[index][1],
              onChanged: (value) => checkboxchanged(value,index), deleteFunction: (BuildContext ) { deleteTask(index); },);
        },
      ),
    );
  }}



