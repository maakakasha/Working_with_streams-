import 'dart:async';

class StreamsHandlers {
  StreamsHandlers();
  final controller = StreamController<int>();

// Adding data to the stream
  initializeStreaming() {
    controller.add(1);
    controller.add(2);

// Listening to the stream
    controller.stream.listen((data) {
      print(data); // 1, 2
    });
  }

  // Periodic streaming:
  final streamPeriodic =
      Stream.periodic(Duration(seconds: 2), (count) => count);

  periodicStreming() {
    streamPeriodic.listen((data) {
      print(data); // 0, 1, 2, ...
    });
  }

  void dispose() {
    controller.close();
  }
}
