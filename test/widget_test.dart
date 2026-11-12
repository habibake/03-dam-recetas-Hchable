import 'package:flutter_test/flutter_test.dart';

import 'package:recetas_app/main.dart';

void main() {
  testWidgets('la app carga y muestra la pantalla de inicio', (tester) async {
    await tester.pumpWidget(const RecetasApp());

    expect(find.text('Recetas App'), findsOneWidget);
    expect(find.text('Sabores del Mayab'), findsOneWidget);
  });
}
