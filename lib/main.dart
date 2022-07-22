import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:linkify/linkify.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Links',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Identify Link and Show Preview'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? url;

  void extractURL(String text) {
    List list = linkify(text);

    for (var i in list) {
      if (i.runtimeType == UrlElement) {
        setState(() {
          url = i.url;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onSubmitted: (val) {
                  extractURL(val);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (url != null) AnyLinkPreview(
                key: ValueKey<String>(url!),
                link: url!,
                errorWidget: const Card(
                  child: Center(
                    child: const Text("Sorry, couldn't load your preview"),
                  ),
                ),
                showMultimedia: true,
                borderRadius: 25,
                bodyMaxLines: 5,
                bodyTextOverflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
