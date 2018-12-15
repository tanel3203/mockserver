import 'dart:async';

import 'package:aqueduct/aqueduct.dart';   

class Migration1 extends Migration { 
  @override
  Future upgrade() async {
   database.createTable(SchemaTable("_SingleEndpoint", [
SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("name", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: true),
SchemaColumn("response", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
],
));


  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {
    final endpoints = [["one", "{'oneKey': 'oneVal', 'oneKey2': 'oneVal2'}"], ["two", "{'twoKey': 'twoVal', 'twoKey2': 'twoVal2'}"]];

    for (final endpoint in endpoints) {
      await database.store.execute("INSERT INTO _SingleEndpoint (name, response) VALUES (@name, @response)", substitutionValues: {
        "name": endpoint.elementAt(0), "response": endpoint.elementAt(1)
      });
    }
  }
}
    