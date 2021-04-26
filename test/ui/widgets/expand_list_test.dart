import 'package:cherry/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_page.dart';

void main() {
  group('ExpandList', () {
    testWidgets('renders the info', (tester) async {
      await tester.pumpWidget(
        TestPage(
          (context) => ExpandList(
            hint: 'Hint',
            child: Text('Lorem Ipsum'),
          ),
        ),
      );
    });
  });
}
