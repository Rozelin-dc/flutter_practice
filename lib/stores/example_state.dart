import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final getExamplePageProvider = FutureProvider.autoDispose((ref) async {
  final res = await http.get(Uri.https('example.com', '/'));
  return res.body;
});
