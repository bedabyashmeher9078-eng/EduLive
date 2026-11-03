# EduLive — MVP 0.1

A Flutter starter project for a private teaching app (one teacher, roughly 200–250 students).

## Included in this first build
- Role selection screen (Teacher / Student)
- Home dashboard for each role
- Live classroom interface prototype
- Mic, camera, chat and end-class UI controls
- Quick-access tiles for materials, recordings, announcements and attendance

## Important: what is not connected yet
This is the first UI prototype. It does **not** yet transmit live audio/video, authenticate real users, store attendance, or upload files. The live classroom currently shows a placeholder until a streaming provider and secure token service are configured.

## Run the app
1. Install Flutter SDK and Android Studio.
2. Unzip the project.
3. Open a terminal in this folder.
4. Run:
   ```bash
   flutter pub get
   flutter run
   ```

## Next development stage
1. Add Firebase Authentication with teacher/student access rules.
2. Add a secure backend endpoint that creates short-lived LiveKit room tokens.
3. Integrate LiveKit SDK for teacher camera/microphone publishing and student viewing.
4. Test with a small group, then load-test for 200–250 viewers.
5. Add class scheduling, attendance, chat, notes and recordings.

## Security note
Never put a LiveKit API secret or Firebase service-account key inside the mobile app. Generate streaming tokens on a trusted backend.
