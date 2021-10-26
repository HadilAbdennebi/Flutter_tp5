import 'package:atelier5_1/ui/scol_list_dialog.dart';
import 'package:atelier5_1/ui/students_screen.dart';
import 'package:atelier5_1/util/dbuse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/scol_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dbuse helper = dbuse();
    helper.testDb();
    return MaterialApp(
        title: 'Classes List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ShList());
  }
}

class ShList extends StatefulWidget {
  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {
  late List<ScolList> scolList;
  dbuse helper = dbuse();

  late ScolListDialog dialog;

  @override
  void initState() {
    dialog = ScolListDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScolListDialog dialog = ScolListDialog();
    showData();

    return Scaffold(
        appBar: AppBar(
          title: Text(' Classes list'),
        ),
        body: ListView.builder(
            itemCount: (scolList != null) ? scolList.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                  key: Key(scolList[index].nomClass),
                  onDismissed: (direction) {
                    String strName = scolList[index].nomClass;
                    helper.deleteList(scolList[index]);
                    setState(() {
                      scolList.removeAt(index);
                    });
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("$strName deleted")));
                  },
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StudentsScreen(scolList[index])),
                      );
                    },
                    title: Text(scolList[index].nomClass),
                    leading: CircleAvatar(
                      child: Text(scolList[index].codClass.toString()),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => dialog
                                .buildDialog(context, scolList[index], false));
                      },
                    ),
                  ));
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  dialog.buildDialog(context, ScolList(0, '', 0), true),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.pink,
        ));
  }

  Future showData() async {
    await helper.openDb();
    scolList = await helper.getClasses();
    setState(() {
      scolList = scolList;
    });
  }
}
