import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_link_preview_2/flutter_link_preview_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, PreviewData> datas = {};

  List<String> get urls => const [
        'https://google.com',
      ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: urls.length,
        itemBuilder: (context, index) => Align(
          alignment: Alignment.centerLeft,
          child: Container(
            key: ValueKey(urls[index]),
            margin: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Color(0xfff7f7f8),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: LinkPreview(
                enableAnimation: true,
                onPreviewDataFetched: (data) {
                  setState(() {
                    datas = {
                      ...datas,
                      urls[index]: data,
                    };
                  });
                },
                previewData: datas[urls[index]],
                text: urls[index],
                width: MediaQuery.of(context).size.width,
                loadingIndecator: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  padding: const EdgeInsets.all(10.0),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
