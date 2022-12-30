import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqLite {
  Future<Database> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, 'SQLITE_EXAMPLE');

    print(databasePath);
    print(databaseFinalPath);

    return await openDatabase(
      databaseFinalPath,
      //Nesse local será executado os campos que deseja executar antes do banco ser
      //estartado
      onConfigure: (db) async{
        //Habilita o uso das chaves estrangeiras.
        await db.execute('PRAGMA foreign_keys = ON');
      },
      version: 2,
      //Chamado somente no momento de criacao do banco de dados
      //Primeira vez que carrega o aplicativo
      onCreate: (Database db, int version) {
        print('******* onCreate chamado ******* ');
        final batch = db.batch();

        batch.execute(''' 
        create table teste(
           id Integer primary key autoincrement,
           nome varchar(200) )
        ''');

        //Deve incluir essa tabela aqui, para nos casos do usuario que estiver
        //Baixando o APP pela primeira vez.
        batch.execute(''' 
        create table produto(
           id Integer primary key autoincrement,
           nome varchar(200) )
        ''');

        batch.commit();
      },
      //Será chamado sempre que houver uma alteração no version incremental(1 -> 2)
      onUpgrade: (Database db, int oldVersion, int version) {
        print('******* onUpgrade chamado ******* ');
        final batch = db.batch();

        if (oldVersion == 2) {
          batch.execute(''' 
        create table produto(
           id Integer primary key autoincrement,
           nome varchar(200) )
        ''');
          batch.commit();
        }

        /*if (oldVersion == 3) {
          batch.execute(''' 
        create table categoria(
           id Integer primary key autoincrement,
           nome varchar(200) )
        ''');
          batch.commit();
        }*/
      },
      //Será chamado sempre que houver uma alteração no version decremental(2 -> 1)
      onDowngrade: (Database db, int oldVersion, int version) {
        print('******* onDowngrade chamado oldVersion ******* ');
        print(oldVersion);
        final batch = db.batch();

          if (oldVersion == 3) {
          batch.execute(''' 
        DROP TABLE categoria
        ''');
          batch.commit();
        }
      },
    );
  }
}
