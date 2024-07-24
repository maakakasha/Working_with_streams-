import 'package:flutter/material.dart';
import 'package:woeking_with_streams/api_streaming.dart';
import 'package:woeking_with_streams/streams_handlers.dart';

StreamsHandlers streamsHandlerInstance = StreamsHandlers();
ApiPolling apiPolling = ApiPolling();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You are establishing a streamm connection:',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: apiPolling.dataStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text(
                    'Something went wrong loading your data',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  );
                }
                var data = snapshot.data!;
                return Column(
                  children: [
                    Text(
                      '${data['results'][0]['name']}',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      '${data['results'][0]['name']['title']}, ${data['results'][0]['name']['first']}',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      '${data['results'][0]['name']['last']}',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter;
          // streamsHandlerInstance.initializeStreaming();
          // streamsHandlerInstance.periodicStreming();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
