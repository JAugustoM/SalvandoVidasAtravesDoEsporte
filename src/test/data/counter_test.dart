import 'package:salvando_vidas/data/stores/home/counter.dart';
import 'package:test/test.dart';

void main() {
  test("Teste da classe Counter", () {
    Counter? counter;

    setUp(() {
      counter = Counter();
    });

    expect(counter?.value, 0);
  });
}
