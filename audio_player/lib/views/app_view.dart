import 'package:flutter/material.dart';

typedef PadTapCallback = void Function(int, int);


class PadTile extends StatelessWidget {
  final int x;
  final int y;
  final PadTapCallback? onTap;
  final PadTapCallback? onDoubleTap;
  final PadTapCallback? onLongPress;

  const PadTile({super.key, required this.x, required this.y, this.onTap, this.onDoubleTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap != null? () => { onTap!(x, y)} : null,
        onDoubleTap: onDoubleTap != null? () => { onDoubleTap!(x, y)} : null,
        onLongPress: onLongPress != null? () => { onLongPress!(x, y)} : null,
        child: SizedBox(width: 100.0, height: 100.0),
      ),
    );
  }
}

class PadArray  extends StatelessWidget {
  final int rowCount;
  final int columnCount;
  List<List<PadTile>>? pads;
  final PadTapCallback? onTap;
  final PadTapCallback? onDoubleTap;
  final PadTapCallback? onLongPress;
  
  PadArray.builder(this.rowCount, this.columnCount, {super.key, this.onTap, this.onDoubleTap, this.onLongPress}) {
    pads = List.generate(rowCount, 
      (row) => List.generate(columnCount, 
        (column) => PadTile(x: column, y: row), growable: false), growable: false);
  }

  @override
  Widget build(BuildContext context) {
  return Row(children: pads!.map((row) => Column(children: row.toList())).toList());
  }
}

class AppView extends StatefulWidget {
  final String title;
  late final PadArray padArray;
  AppView({super.key, required this.title}) {
    padArray = PadArray.builder(2, 2);
  }
  
  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            PadArray.builder(2, 2),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}

