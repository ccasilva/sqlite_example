import 'package:flutter/material.dart';
import 'package:sqlite_example/database/database_sqlite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _database();
  }

  Future<void> _database() async {
    final database = await DatabaseSqLite().openConnection();

    /*database.delete(
      'teste',
      where: 'nome in (?,?,?)',
      whereArgs: ['Carlos Silva', 'Marcelo Romario', 'Maria Jose'],
    );*/

    //database.insert('teste', {'nome': 'Carlos Silva'});
    //database.insert('teste', {'nome': 'Marcelo Romario'});
    //database.insert('teste', {'nome': 'Maria Jose'});

    /*
    database.update('teste', {'nome': 'Academia do Flutter'},
    where: 'id = ?', whereArgs: [8]);*/

    var result = await database.query('teste');
    print(result);

    //database.rawInsert('insert into teste values(null,?)', ['Carlos']);
    //database.rawDelete('update teste set nome = ? where id = ?', ['Carlos Silva', 8]);
    //database.rawUpdate('delete from teste where id = ?', [5]);
    var resultado = await database.rawQuery('select * from teste');
    print(resultado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(),
    );
  }
}
