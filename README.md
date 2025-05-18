🗂️ Firebase Notes App


A Flutter application that lets users sign up, log in (via Email/Password or Google), manage notes within categorized folders, and enjoy a polished responsive UI. Built using Firebase Authentication and Cloud Firestore.


🚀 Features

✅ Authentication

🔐 Email & Password Sign Up / Sign In

📧 Email Verification

🔁 Password Reset (Forgot Password)

🔓 Google Sign-In with Firebase

🔒 Auto-login for verified users



📝 Notes & Categories

🗃️ Create, edit, and delete categories

🗒️ Add, update, delete notes inside categories

🧠 Notes stored using Cloud Firestore

📁 Structured as categoris/{user_id}/note/{note_id}



🎨 UI/UX

🖼️ Custom and responsive UI using flutter_screenutil

📱 Modern layout with clean components

🧩 Reusable widgets for buttons, forms, and text areas

🧠 Confirmation dialogs via awesome_dialog



📂 Project Structure

firebase_flutter/

├── auth/               # Auth pages (Login, SignUp)

├── Categoris/          # Category management (Add, Update)

├── components/         # Reusable widgets (Buttons, TextField, etc.)

├── note/               # Note operations (Add, Edit, View)

├── constans.dart       # Custom app colors

├── homepage.dart       # Main homepage

├── main.dart           # App entry point



🛠️ Tech Stack

Flutter 🐦

Firebase Authentication 🔐

Google Sign-In 🟢🔵🟥🟡

Cloud Firestore ☁️

flutter_screenutil 📏

awesome_dialog 💬



🧪 Getting Started

Clone this repo:

git clone https://github.com/yourusername/firebase_flutter.git

cd firebase_flutter

Install dependencies:

flutter pub get

Configure Firebase:

Add your google-services.json to the android/app directory.

Make sure Firebase Auth and Firestore are enabled in your Firebase project.

Run the app:

flutter run



🔐 Firebase Setup Checklist

Firebase Core initialized in main.dart

Email/Password Authentication enabled

Google Sign-In set up

Firestore database rules configured

App correctly handles verified/unverified users



🧑‍💻 Author

Abdellah Ayoujil

🔗 [GitHub Profile](https://github.com/abdellahayoujil)
