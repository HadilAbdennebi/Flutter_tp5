import 'package:atelier5_1/models/list_etudiants.dart';
import 'package:flutter/material.dart';

import '../models/scol_list.dart';
import '../util/dbuse.dart';

class StudentsScreen extends StatefulWidget {
  final ScolList scolList;
  StudentsScreen(this.scolList);
  @override
  _StudentsScreenState createState() => _StudentsScreenState(this.scolList);
}

class _StudentsScreenState extends State<StudentsScreen> {
  final ScolList scolList;

  _StudentsScreenState(this.scolList);

  dbuse? helper;
  late List<ListEtudiants?> students;

  @override
  Widget build(BuildContext context) {
    helper = dbuse();
    showData(this.scolList.codClass);
    return Scaffold(
        appBar: AppBar(
          title: Text(scolList.nomClass),
        ),
        body: ListView.builder(
            itemCount: (students != null) ? students.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(students[index]!.nom),
                subtitle: Text(
                    'Prenom: ${students[index]!.prenom} - Date Nais:${students[index]!.datNais}'),
                onTap: () {},
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              );
            }));
  }

  Future showData(int idList) async {
    await helper!.openDb();
    students = await helper!.getEtudiants(idList);
    setState(() {
      students = students;
    });
  }
}
