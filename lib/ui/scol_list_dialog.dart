import 'package:atelier5_1/util/dbuse.dart';
import 'package:flutter/material.dart';

import '../models/scol_list.dart';

class ScolListDialog {
  final txtNonClass = TextEditingController();
  final txtNbreEtud = TextEditingController();
  Widget buildDialog(BuildContext context, ScolList list, bool isNew) {
    dbuse helper = dbuse();
    if (!isNew) {
      txtNonClass.text = list.nomClass;
      txtNbreEtud.text = list.nbreEtud.toString();
    }
    return AlertDialog(
        title: Text((isNew) ? 'Class list' : 'Edit class list'),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextField(
                controller: txtNonClass,
                decoration: InputDecoration(hintText: 'Class List Name')),
            TextField(
              controller: txtNbreEtud,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(hintText: 'Class List numbre of student'),
            ),
            RaisedButton(
              child: Text('Save Class List'),
              onPressed: () {
                list.nomClass = txtNonClass.text;
                list.nbreEtud = int.parse(txtNbreEtud.text);
                var text = (isNew) ? 'Class list' : 'Edit class list';
                if (text == "Edit class list") {
                  helper.updateClass(ScolList(list.codClass, txtNonClass.text,
                      int.parse(txtNbreEtud.text)));
                } else
                  helper.insertClass(list);
                Navigator.pop(context);
              },
            ),
          ]),
        ));
  }
}
