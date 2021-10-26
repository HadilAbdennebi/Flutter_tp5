import 'package:atelier5_1/models/list_etudiants.dart';
import 'package:atelier5_1/util/dbuse.dart';
import 'package:flutter/material.dart';

class ScolListDialog1 {
  final txtNomEtud = TextEditingController();
  final txtPreEtud = TextEditingController();
  final txtNdate = TextEditingController();
  final txtNClass = TextEditingController();
  Widget buildDialog1(BuildContext context, ListEtudiants list, bool isNew) {
    dbuse helper = dbuse();
    if (!isNew) {
      txtNomEtud.text = list.nom.toString();
      txtPreEtud.text = list.prenom.toString();
      txtNdate.text = list.datNais;
      txtNClass.text = list.codClass.toString();
    }
    return AlertDialog(
        title: Text((isNew) ? 'Etudiant list' : 'Edit Etudiant list'),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextField(
                controller: txtNomEtud,
                decoration: InputDecoration(hintText: 'ETUDIANT List Name')),
            TextField(
              controller: txtPreEtud,
              decoration:
                  InputDecoration(hintText: 'Class List prenom of student'),
            ),
            TextField(
              controller: txtNdate,
              readOnly: true,
              decoration: InputDecoration(
                  hintText: 'Class List date naissance of student'),
              onTap: () async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1960),
                    initialDate: DateTime.now(),
                    lastDate: DateTime(2100));
                if (date != null) {
                  // final df = new DateFormat('dd-MM-yyyy');
                  // txtNdate.text = df.format(date);
                }
              },
            ),
            RaisedButton(
              child: Text('Save Etudiant List'),
              onPressed: () {
                list.datNais = txtNdate.text;
                list.nom = txtNomEtud.text;
                list.prenom = txtPreEtud.text;
                var text = (isNew) ? 'Etudiant list' : 'Edit Etudiant list';
                if (text == "Edit Etudiant list")
                  helper.updateEtudiant(ListEtudiants(list.id, list.codClass,
                      list.nom, list.prenom, list.datNais));
                else
                  helper.insertEtud(list);
                Navigator.pop(context);
              },
            ),
          ]),
        ));
  }
}
