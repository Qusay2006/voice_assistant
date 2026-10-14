# 🎙️ Voice Assistant

A Flutter voice assistant named **Allen**. Tap the mic and speak: Allen understands you, answers out loud, or draws an image when you ask for one.

Built to practice **Clean Architecture**, **Cubit**, and working with **AI APIs**.

## 📱 Screenshots

| Home Page | Question | Listening / Processing | Answer | Generated Photo |
| :---: | :---: | :---: | :---: | :---: |
| <img width="175" alt="Home Page" src="https://github.com/user-attachments/assets/0d9e73b2-3c7a-433f-821b-a0cc48773e0e" /> | <img width="175" alt="Question" src="https://github.com/user-attachments/assets/5bc09296-ef8e-4030-b775-1e0056bab832" /> | <img width="175" alt="Listening" src="https://github.com/user-attachments/assets/4606cae9-7d32-44da-a11a-db3200a9ec4f" /> | <img width="175" alt="Answer" src="https://github.com/user-attachments/assets/3ca6201d-b3e3-400d-bf79-f798516b2cda" /> | <img width="175" alt="Generated Photo" src="https://github.com/user-attachments/assets/6e67feb2-1992-48ab-b8ff-46b03a871b2f" /> |


## ✨ Features

- Voice input with live transcription while you speak
- AI replies powered by Gemini, with conversation memory
- Spoken answers using text-to-speech
- Smart intent detection: the AI decides if you want a chat reply or an image, so there are no separate buttons
- Image generation from a voice prompt (free, no key needed)

## 🏗️ Architecture

Clean Architecture with a data layer and a presentation layer:

```
UI  →  Cubit  →  Repository  →  DataSource (Gemini API / Speech-to-Text / TTS)
```

Three Cubits work together: one for speech recognition, one for the AI, and one for text-to-speech. Dependencies are injected automatically with `get_it` and `injectable`.

## 🧰 Tech Stack

`flutter_bloc` · `equatable` · `get_it` + `injectable` · `speech_to_text` · `flutter_tts` · `dio` · Gemini API · Pollinations

## 🚀 Getting Started

```bash
git clone https://github.com/Qusay2006/voice_assistant.git
cd voice_assistant
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Get a free API key from [Google AI Studio](https://aistudio.google.com/app/apikey), then create the file `lib/core/secret/api_key.dart`:

```dart
const String apiKey = 'YOUR_GEMINI_API_KEY';
```

Then run the app and allow microphone access when asked:

```bash
flutter run
```

> Image generation uses Pollinations' free endpoint, which is rate-limited and may change.

## 👤 Author

**Qusai Meshow** · [LinkedIn](https://www.linkedin.com/in/qusay-masho-ab4a6543b/)
