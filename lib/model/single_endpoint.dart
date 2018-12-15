import 'package:mockserver/mockserver.dart';

class SingleEndpoint extends ManagedObject<_SingleEndpoint> implements _SingleEndpoint {}

class _SingleEndpoint {
  @primaryKey
  int id;

  @Column(unique: true)
  String name;

  @Column()
  String response;

}