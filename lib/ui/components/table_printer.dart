import 'dart:io';

void printTable({
  required List<String> headers,
  required List<List<String>> rows,
  int tabs = 4, // number of tabs to indent
}) {
  final String indent = '\t' * tabs;

  // Calculate max width per column
  List<int> colWidths = List.generate(headers.length, (i) {
    int maxRowWidth = rows.map((r) => r[i].length).fold(0, (prev, e) => e > prev ? e : prev);
    return headers[i].length > maxRowWidth ? headers[i].length : maxRowWidth;
  });

  // Helper to print a horizontal separator
  void printSeparator() {
    stdout.write('$indent+');
    for (var w in colWidths) {
      stdout.write('-' * (w + 2) + '+');
    }
    stdout.writeln();
  }

  // Print header
  printSeparator();
  stdout.write('$indent|');
  for (int i = 0; i < headers.length; i++) {
    stdout.write(' ${headers[i].padRight(colWidths[i])} |');
  }
  stdout.writeln();
  printSeparator();

  // Print rows
  for (var row in rows) {
    stdout.write('$indent|');
    for (int i = 0; i < row.length; i++) {
      stdout.write(' ${row[i].padRight(colWidths[i])} |');
    }
    stdout.writeln();
  }
  printSeparator();
}
