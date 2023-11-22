import 'dart:math';

import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AnimatedDigitWidgetExample());
}

class AnimatedDigitWidgetExample extends StatefulWidget {
  const AnimatedDigitWidgetExample({Key? key}) : super(key: key);

  @override
  State<AnimatedDigitWidgetExample> createState() =>
      _AnimatedDigitWidgetExampleState();
}

class _AnimatedDigitWidgetExampleState
    extends State<AnimatedDigitWidgetExample> {
  final AnimatedDigitController _controller = AnimatedDigitController(111.987);

  double textScaleFactor = 1.0;

  @override
  void initState() {
    super.initState();
    textScaleFactor = MediaQuery.textScalerOf(context).scale(1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _add() {
    _controller.addValue(Random().nextInt(DateTime.now().year + 1));
  }

  void _remove() {
    _controller.minusValue(Random().nextInt(DateTime.now().year));
  }

  void _reset() {
    _controller.resetValue(0);
  }

  void updateFontScale() {
    setState(() {
      textScaleFactor = textScaleFactor == 1.0 ? 1.2 : 1.0;
    });
  }

  void _addDecimal() {
    var val = num.parse(Random().nextDouble().toStringAsFixed(2));
    _controller.addValue(val);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Animated Digit Widget Example"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 80),
              ValueListenableBuilder(
                valueListenable: _controller,
                builder: (BuildContext context, num value, Widget? child) {
                  return Text(
                    "current value:$value",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                    ),
                  );
                },
              ),
              const SizedBox(height: 80),
              AnimatedDigitWidget(
                controller: _controller,
              ),
              const SizedBox(height: 30),
              AnimatedDigitWidget(
                controller: _controller,
                textStyle: const TextStyle(color: Colors.orange, fontSize: 30),
                enableSeparator: true,
              ),
              const SizedBox(height: 30),
              AnimatedDigitWidget(
                controller: _controller,
                textStyle:
                    const TextStyle(color: Colors.pinkAccent, fontSize: 30),
                enableSeparator: true,
                fractionDigits: 1,
              ),
              const SizedBox(height: 30),
              AnimatedDigitWidget(
                controller: _controller,
                textStyle: const TextStyle(color: Colors.cyan, fontSize: 30),
                curve: Curves.easeOutCubic,
                enableSeparator: true,
                fractionDigits: 2,
                valueColors: [
                  ValueColor(
                    condition: () => _controller.value <= 0,
                    color: Colors.red,
                  ),
                  ValueColor(
                    condition: () => _controller.value >= 1999,
                    color: Colors.orange,
                  ),
                  ValueColor(
                    condition: () => _controller.value >= 2999,
                    color: const Color.fromARGB(255, 247, 306, 24),
                  ),
                  ValueColor(
                    condition: () => _controller.value >= 3999,
                    color: Colors.green,
                  ),
                  ValueColor(
                    condition: () => _controller.value >= 4999,
                    color: Colors.cyan,
                  ),
                  ValueColor(
                    condition: () => _controller.value >= 5999,
                    color: Colors.blue,
                  ),
                  ValueColor(
                    condition: () => _controller.value >= 6999,
                    color: Colors.purple,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              AnimatedDigitWidget(
                controller: _controller,
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 85, 226, 179),
                  fontSize: 30,
                ),
                fractionDigits: 3,
                enableSeparator: true,
                separateSymbol: "·",
                separateLength: 3,
                decimalSeparator: ",",
                prefix: "\$",
                suffix: "€",
              ),
              const SizedBox(height: 30),
              Container(
                width: 188,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SingleDigitProvider(
                  data: SingleDigitData(
                    useTextSize: false,
                    builder: (size, value, isNumber, child) {
                      return isNumber ? child : const FlutterLogo();
                    },
                  ),
                  child: AnimatedDigitWidget(
                    controller: _controller,
                    textStyle: TextStyle(color: Colors.pink[300], fontSize: 30),
                    separateLength: 1,
                    separateSymbol: "#",
                    enableSeparator: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: _add,
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: updateFontScale,
              child: const Icon(Icons.font_download),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: _reset,
              child: const Icon(Icons.restart_alt),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: _remove,
              child: const Icon(Icons.remove),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: _addDecimal,
              tooltip: "add decimal",
              child: const Icon(Icons.add_box_outlined),
            ),
          ],
        ),
      ),
      builder: (context, home) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(textScaleFactor)),
          child: home!,
        );
      },
    );
  }
}
