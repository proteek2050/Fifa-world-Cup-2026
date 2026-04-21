import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:worldcup_2026_bd/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const WorldCup2026App());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
