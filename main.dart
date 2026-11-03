import 'package:flutter/material.dart';

void main() => runApp(const EduLiveApp());

class EduLiveApp extends StatelessWidget {
  const EduLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduLive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3157D5),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        fontFamily: 'Roboto',
        cardTheme: CardTheme(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      home: const RoleLoginScreen(),
    );
  }
}

class RoleLoginScreen extends StatelessWidget {
  const RoleLoginScreen({super.key});

  void _open(BuildContext context, bool isTeacher) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(isTeacher: isTeacher),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EDFF),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(Icons.cast_for_education,
                    color: Color(0xFF3157D5), size: 38),
              ),
              const SizedBox(height: 24),
              const Text('EduLive',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              const Text(
                'Your classroom, wherever you are.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 44),
              const Text('Continue as',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              _RoleCard(
                title: 'Teacher',
                subtitle: 'Start and manage live classes',
                icon: Icons.co_present_rounded,
                onTap: () => _open(context, true),
              ),
              const SizedBox(height: 14),
              _RoleCard(
                title: 'Student',
                subtitle: 'Join classes and access learning materials',
                icon: Icons.school_rounded,
                onTap: () => _open(context, false),
              ),
              const Spacer(),
              const Center(
                child: Text('PRIVATE CLASSROOM • VERSION 0.1',
                    style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.2,
                        color: Colors.black38,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xFFE8EDFF),
                child: Icon(icon, color: const Color(0xFF3157D5)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final bool isTeacher;
  const HomeScreen({super.key, required this.isTeacher});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EduLive',
            style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () => _message(context, 'Notifications will appear here.'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3157D5), Color(0xFF6482F0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isTeacher ? 'TEACHER DASHBOARD' : 'STUDENT DASHBOARD',
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        letterSpacing: 1.3,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Text(
                  isTeacher ? 'Ready to teach?' : 'Ready to learn?',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 7),
                Text(
                  isTeacher
                      ? 'Your next class is just one tap away.'
                      : 'Join your classroom and learn live.',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF3157D5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LiveClassScreen(isTeacher: isTeacher),
                      ),
                    ),
                    icon: Icon(isTeacher ? Icons.videocam : Icons.play_arrow),
                    label: Text(isTeacher ? 'Start Live Class' : 'Join Live Class'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const _SectionTitle(title: 'Quick access'),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.45,
            children: [
              _QuickTile(
                icon: Icons.menu_book_rounded,
                title: 'Study Materials',
                subtitle: 'PDF notes and files',
                onTap: () => _message(context, 'Study Materials module is planned for the next build.'),
              ),
              _QuickTile(
                icon: Icons.video_library_rounded,
                title: 'Recordings',
                subtitle: 'Previous lectures',
                onTap: () => _message(context, 'Recordings module is planned for the next build.'),
              ),
              _QuickTile(
                icon: Icons.campaign_rounded,
                title: 'Announcements',
                subtitle: 'Class updates',
                onTap: () => _message(context, 'Announcements module is planned for the next build.'),
              ),
              _QuickTile(
                icon: Icons.fact_check_rounded,
                title: 'Attendance',
                subtitle: 'Class participation',
                onTap: () => _message(context, 'Attendance module is planned for the next build.'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionTitle(title: 'Classroom status'),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFEAF7EF),
                child: Icon(Icons.wifi_tethering, color: Color(0xFF239653)),
              ),
              title: const Text('No class is live right now',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: const Text('Your teacher can announce the next session here.'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.live_tv_outlined), label: 'Classes'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
        onDestinationSelected: (index) {
          if (index != 0) _message(context, 'This section will be added in a later build.');
        },
      ),
    );
  }
}

class LiveClassScreen extends StatefulWidget {
  final bool isTeacher;
  const LiveClassScreen({super.key, required this.isTeacher});

  @override
  State<LiveClassScreen> createState() => _LiveClassScreenState();
}

class _LiveClassScreenState extends State<LiveClassScreen> {
  bool micOn = true;
  bool cameraOn = true;
  bool chatOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF10131B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF10131B),
        foregroundColor: Colors.white,
        title: Text(widget.isTeacher ? 'Live classroom' : 'Class in progress'),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Row(children: [
                Icon(Icons.circle, color: Colors.red, size: 9),
                SizedBox(width: 6),
                Text('LIVE', style: TextStyle(fontWeight: FontWeight.w800)),
              ]),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 112,
                      width: 112,
                      decoration: BoxDecoration(
                        color: const Color(0xFF252B3A),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: const Icon(Icons.videocam_rounded,
                          color: Colors.white70, size: 54),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Live video will appear here',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Streaming connection is not configured yet.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white60),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 9),
                      decoration: BoxDecoration(
                        color: const Color(0xFF252B3A),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text('Next: connect secure live video',
                          style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (chatOpen)
            Container(
              height: 150,
              width: double.infinity,
              color: const Color(0xFF1B2130),
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Class chat\nChat messages will be connected in a later build.',
                style: TextStyle(color: Colors.white70, height: 1.7),
              ),
            ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            decoration: const BoxDecoration(
              color: Color(0xFF1B2130),
              borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ControlButton(
                  icon: micOn ? Icons.mic : Icons.mic_off,
                  label: 'Mic',
                  active: micOn,
                  onTap: () => setState(() => micOn = !micOn),
                ),
                _ControlButton(
                  icon: cameraOn ? Icons.videocam : Icons.videocam_off,
                  label: 'Camera',
                  active: cameraOn,
                  onTap: () => setState(() => cameraOn = !cameraOn),
                ),
                _ControlButton(
                  icon: Icons.chat_bubble_outline,
                  label: 'Chat',
                  active: chatOpen,
                  onTap: () => setState(() => chatOpen = !chatOpen),
                ),
                _ControlButton(
                  icon: Icons.call_end,
                  label: 'End',
                  active: false,
                  danger: true,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final bool danger;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = danger
        ? const Color(0xFFD83B45)
        : active
            ? const Color(0xFF34415F)
            : const Color(0xFF303644);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
                color: bg, borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 7),
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
      );
}

class _QuickTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFF3157D5), size: 25),
              const SizedBox(height: 10),
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 3),
              Text(subtitle,
                  style: const TextStyle(fontSize: 11, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}

void _message(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
  );
}
