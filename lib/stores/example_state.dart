import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class ExampleNotifier extends AutoDisposeAsyncNotifier<String> {
  @override
  Future<String> build() async {
    final res = await http.get(Uri.https('example.com', '/'));
    return res.body;
  }
}

final getExamplePageProvider = AsyncNotifierProvider.autoDispose<ExampleNotifier, String>(ExampleNotifier.new);
