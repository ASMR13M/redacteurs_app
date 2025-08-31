import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redacteurs_app/main.dart';

void main() {
  testWidgets('Vérifie que le widget principal se charge', (
    WidgetTester tester,
  ) async {
    // Charge le widget principal
    await tester.pumpWidget(const MyApp());

    // Vérifie que le titre de l'appBar est présent
    expect(find.text('Gestion des Rédacteurs'), findsOneWidget);

    // Vérifie qu'il y a bien le bouton Ajouter
    expect(find.text('Ajouter'), findsOneWidget);

    // Vérifie qu'au moins un TextField est présent
    expect(find.byType(TextField), findsNWidgets(2)); // Nom et Email
  });
}
