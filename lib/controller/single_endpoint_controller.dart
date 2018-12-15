import 'dart:async';
import 'package:mockserver/mockserver.dart';
import 'package:mockserver/model/single_endpoint.dart';
import 'dart:convert';

class SingleEndpointController extends ResourceController {
  SingleEndpointController(this.context);

  final ManagedContext context;

  @Operation.post()
  Future<Response> createMock() async {
    final Map<String, dynamic> body = await request.body.decode();
    final query = Query<SingleEndpoint>(context)
      ..values.name = body['name'] as String
      ..values.response = const JsonEncoder().convert(body['response']);

    final insertedMock = await query.insert();

    return Response.ok(insertedMock);
  }

  @Operation.get()
  Future<Response> getAll({@Bind.query('name') String name}) async {
    final q = Query<SingleEndpoint>(context);
    if (name != null) {
      q.where((h) => h.name).contains(name, caseSensitive: false);
    }
    final result = await q.fetch();

    final firstResponse = result.map((it) => it.response).first.replaceAll("'", "\"");

    return Response.ok(json.decode(firstResponse));
  }

}