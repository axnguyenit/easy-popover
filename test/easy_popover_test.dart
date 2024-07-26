import 'package:easy_popover/easy_popover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Popover opens and closes correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PopoverOverlay(
          builder: (context) => Scaffold(
            body: Center(
              child: Popover(
                context,
                action: const Text('Open Popover'),
                content: const Material(
                  child: Text('Popover Content'),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Popover Content'), findsNothing);

    await tester.tap(find.text('Open Popover'));
    await tester.pumpAndSettle();
    expect(find.text('Popover Content'), findsOneWidget);

    await tester.tapAt(const Offset(10.0, 10.0));
    await tester.pumpAndSettle();
    expect(find.text('Popover Content'), findsNothing);
  });

  testWidgets('Popover should not close when tapping outside',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PopoverOverlay(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Popover(
                  context,
                  scrollEnabled: true,
                  action: const Text('Open Popover'),
                  content: const Material(
                    child: Text('Popover Content'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Popover'));
    await tester.tapAt(const Offset(10.0, 10.0));
    await tester.pumpAndSettle();
    expect(find.text('Popover Content'), findsOneWidget);
  });

  testWidgets('Popover displays arrow with specified size',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PopoverOverlay(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Popover(
                  context,
                  arrowSize: 28,
                  action: const Text('Open Popover'),
                  content: const Material(
                    child: Text('Popover Content'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Popover'));
    await tester.pumpAndSettle();
    expect(find.text('Popover Content'), findsOneWidget);

    final arrow = tester.widgetList<CustomPaint>(find.byType(CustomPaint)).last;

    expect(arrow.size, const Size(28.0, 28.0));
  });

  testWidgets('Popover alignment and appearance', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PopoverOverlay(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Popover(
                  context,
                  alignment: PopoverAlignment.topCenter,
                  backgroundColor: Colors.blue,
                  boxShadow: const [
                    BoxShadow(color: Colors.black, blurRadius: 4.0)
                  ],
                  action: const Text('Open Popover'),
                  content: const Text('Popover Content'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Popover'));
    await tester.pumpAndSettle();

    final popover = tester.widget<Popover>(find.byType(Popover));

    expect(find.text('Popover Content'), findsOneWidget);
    expect(popover.alignment, PopoverAlignment.topCenter);
    expect(popover.backgroundColor, Colors.blue);
    expect(popover.boxShadow,
        [const BoxShadow(color: Colors.black, blurRadius: 4.0)]);
  });

  testWidgets('Popover alignment top-left', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PopoverOverlay(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Popover(
                  context,
                  alignment: PopoverAlignment.topLeft,
                  action: const Text('Open Popover'),
                  content: const Text('Popover Content'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Popover'));
    await tester.pumpAndSettle();

    final popover = tester.widget<Popover>(find.byType(Popover));

    expect(find.text('Popover Content'), findsOneWidget);
    expect(popover.alignment, PopoverAlignment.topLeft);
  });

  testWidgets('Popover alignment top-right', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PopoverOverlay(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Popover(
                  context,
                  alignment: PopoverAlignment.topRight,
                  action: const Text('Open Popover'),
                  content: const Text('Popover Content'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Popover'));
    await tester.pumpAndSettle();

    final popover = tester.widget<Popover>(find.byType(Popover));

    expect(find.text('Popover Content'), findsOneWidget);
    expect(popover.alignment, PopoverAlignment.topRight);
  });

  testWidgets('Popover alignment bottom-left', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PopoverOverlay(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Popover(
                  context,
                  alignment: PopoverAlignment.bottomLeft,
                  action: const Text('Open Popover'),
                  content: const Text('Popover Content'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Popover'));
    await tester.pumpAndSettle();

    final popover = tester.widget<Popover>(find.byType(Popover));

    expect(find.text('Popover Content'), findsOneWidget);
    expect(popover.alignment, PopoverAlignment.bottomLeft);
  });

  testWidgets('Popover alignment bottom-right', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PopoverOverlay(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Popover(
                  context,
                  alignment: PopoverAlignment.bottomRight,
                  action: const Text('Open Popover'),
                  content: const Text('Popover Content'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Popover'));
    await tester.pumpAndSettle();

    final popover = tester.widget<Popover>(find.byType(Popover));

    expect(find.text('Popover Content'), findsOneWidget);
    expect(popover.alignment, PopoverAlignment.bottomRight);
  });

  testWidgets('Popover alignment left-top', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PopoverOverlay(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Popover(
                  context,
                  alignment: PopoverAlignment.leftTop,
                  action: const Text('Open Popover'),
                  content: const Text('Popover Content'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Popover'));
    await tester.pumpAndSettle();

    final popover = tester.widget<Popover>(find.byType(Popover));

    expect(find.text('Popover Content'), findsOneWidget);
    expect(popover.alignment, PopoverAlignment.leftTop);
  });

  testWidgets('Popover alignment left-center', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PopoverOverlay(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Popover(
                  context,
                  alignment: PopoverAlignment.leftCenter,
                  action: const Text('Open Popover'),
                  content: const Text('Popover Content'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Popover'));
    await tester.pumpAndSettle();

    final popover = tester.widget<Popover>(find.byType(Popover));

    expect(find.text('Popover Content'), findsOneWidget);
    expect(popover.alignment, PopoverAlignment.leftCenter);
  });

  testWidgets('Popover alignment left-bottom', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PopoverOverlay(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Popover(
                  context,
                  alignment: PopoverAlignment.leftBottom,
                  action: const Text('Open Popover'),
                  content: const Text('Popover Content'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Popover'));
    await tester.pumpAndSettle();

    final popover = tester.widget<Popover>(find.byType(Popover));

    expect(find.text('Popover Content'), findsOneWidget);
    expect(popover.alignment, PopoverAlignment.leftBottom);
  });

  testWidgets('Popover alignment right-top', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PopoverOverlay(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Popover(
                  context,
                  alignment: PopoverAlignment.rightTop,
                  action: const Text('Open Popover'),
                  content: const Text('Popover Content'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Popover'));
    await tester.pumpAndSettle();

    final popover = tester.widget<Popover>(find.byType(Popover));

    expect(find.text('Popover Content'), findsOneWidget);
    expect(popover.alignment, PopoverAlignment.rightTop);
  });

  testWidgets('Popover alignment right-center', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PopoverOverlay(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Popover(
                  context,
                  alignment: PopoverAlignment.rightCenter,
                  action: const Text('Open Popover'),
                  content: const Text('Popover Content'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Popover'));
    await tester.pumpAndSettle();

    final popover = tester.widget<Popover>(find.byType(Popover));

    expect(find.text('Popover Content'), findsOneWidget);
    expect(popover.alignment, PopoverAlignment.rightCenter);
  });

  testWidgets('Popover alignment right-bottom', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PopoverOverlay(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Popover(
                  context,
                  alignment: PopoverAlignment.rightBottom,
                  action: const Text('Open Popover'),
                  content: const Text('Popover Content'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open Popover'));
    await tester.pumpAndSettle();

    final popover = tester.widget<Popover>(find.byType(Popover));

    expect(find.text('Popover Content'), findsOneWidget);
    expect(popover.alignment, PopoverAlignment.rightBottom);
  });
}
