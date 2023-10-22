import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DetailedNewsPage extends StatefulWidget {
  final String title;
  final String content;

  const DetailedNewsPage({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  _DetailedNewsPageState createState() => _DetailedNewsPageState();
}

class _DetailedNewsPageState extends State<DetailedNewsPage> {
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();

    flutterTts.setLanguage("hi-IN");
    flutterTts.setSpeechRate(0.5);
    flutterTts.setVolume(1.0);
    flutterTts.setPitch(1.0);
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: () => _speak(widget.content),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(widget.content),
          ],
        ),
      ),
    );
  }
}
