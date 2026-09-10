
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class VoiceTestScreen extends StatefulWidget {
const VoiceTestScreen({super.key});

@override
State<VoiceTestScreen> createState() => _VoiceTestScreenState();
}

class _VoiceTestScreenState extends State<VoiceTestScreen> {
final stt.SpeechToText _speech = stt.SpeechToText();
final FlutterTts _tts = FlutterTts();
bool _isListening = false;
String _spokenText = '';

@override
void initState() {
super.initState();
_initializeSpeech();
}

Future<void> _initializeSpeech() async {
await _speech.initialize();
}
Future<void> _speak() async {
  await _tts.setLanguage('en-US');
  await _tts.setSpeechRate(0.5);

  await _tts.speak(
    'Hello. What is your main health concern?',
  );
}
void _startListening() {
_speech.listen(
onResult: (result) {
setState(() {
_spokenText = result.recognizedWords;
});
},
);

setState(() {
_isListening = true;
});
}

void _stopListening() {
_speech.stop();

setState(() {
_isListening = false;
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Voice Test'),
),
body: Center(
child: Padding(
padding: const EdgeInsets.all(20),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(
_spokenText.isEmpty
? 'Speak something...'
    : _spokenText,
textAlign: TextAlign.center,
style: const TextStyle(fontSize: 20),
),

const SizedBox(height: 30),
  ElevatedButton.icon(
    onPressed: _speak,
    icon: const Icon(Icons.volume_up),
    label: const Text('Hear Question'),
  ),

  const SizedBox(height: 20),

ElevatedButton.icon(
onPressed: _isListening
? _stopListening
    : _startListening,
icon: Icon(
_isListening
? Icons.stop
    : Icons.mic,
),
label: Text(
_isListening
? 'Stop'
    : 'Speak',
),
),
],
),
),
),
);
}
}

