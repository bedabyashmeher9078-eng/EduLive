import 'package:flutter/material.dart';

void main() {
  runApp(const EduLiveApp());
}

const Color primaryBlue = Color(0xFF2457D6);
const Color darkBlue = Color(0xFF142B59);
const Color backgroundColor = Color(0xFFF5F7FC);

class EduLiveApp extends StatelessWidget {
  const EduLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduLive',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
        ),
        fontFamily: 'Roboto',
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// LOGIN SCREEN

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [darkBlue, primaryBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: 75,
                ),
                const SizedBox(height: 15),
                const Text(
                  'EduLive',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Learn. Teach. Grow.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 65),

                const Text(
                  'Welcome to EduLive',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Choose how you want to continue',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 35),

                roleButton(
                  context,
                  'Continue as Teacher',
                  Icons.cast_for_education,
                  true,
                ),

                const SizedBox(height: 16),

                roleButton(
                  context,
                  'Continue as Student',
                  Icons.person,
                  false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget roleButton(
    BuildContext context,
    String title,
    IconData icon,
    bool teacher,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomeScreen(isTeacher: teacher),
            ),
          );
        },
        icon: Icon(icon),
        label: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// HOME SCREEN

class HomeScreen extends StatefulWidget {
  final bool isTeacher;

  const HomeScreen({super.key, required this.isTeacher});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Map<String, String>> classes = [];

  final List<String> subjects = [
    'Botany',
    'Zoology',
    'Biotechnology',
  ];

  void createClass() {
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Live Class'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: 'Enter class name',
            labelText: 'Class Name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.trim().isEmpty) return;

              setState(() {
                classes.add({
                  'title': titleController.text.trim(),
                  'id': 'EDU${1000 + classes.length + 1}',
                });
              });

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Class created successfully!'),
                ),
              );
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void joinClass() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Join Live Class'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Enter Class ID',
            hintText: 'Example: EDU1001',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final id = controller.text.trim();

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    id.isEmpty
                        ? 'Please enter a Class ID'
                        : 'Class ID received: $id. Live service setup pending.',
                  ),
                ),
              );
            },
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'EduLive',
          style: TextStyle(
            color: darkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
            icon: const Icon(
              Icons.notifications_none,
              color: darkBlue,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: IndexedStack(
        index: selectedIndex,
        children: [
          dashboard(),
          const MaterialsScreen(),
          const AnnouncementsScreen(),
          const ProfileScreen(),
        ],
      ),

      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: widget.isTeacher ? createClass : joinClass,
              backgroundColor: primaryBlue,
              foregroundColor: Colors.white,
              icon: Icon(
                widget.isTeacher ? Icons.add : Icons.video_call,
              ),
              label: Text(
                widget.isTeacher ? 'Create Class' : 'Join Class',
              ),
            )
          : null,

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Materials',
          ),
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined),
            label: 'Updates',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget dashboard() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [darkBlue, primaryBlue],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isTeacher
                    ? 'Teacher Dashboard'
                    : 'Student Dashboard',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.isTeacher
                    ? 'Welcome, Teacher!'
                    : 'Welcome, Student!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your learning journey starts here.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              const Icon(
                Icons.auto_stories,
                color: Colors.white,
                size: 42,
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Quick Access',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: darkBlue,
          ),
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            Expanded(
              child: quickCard(
                Icons.video_camera_front,
                'Live Classes',
                primaryBlue,
                () => widget.isTeacher ? createClass() : joinClass(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: quickCard(
                Icons.picture_as_pdf,
                'Study Notes',
                Colors.orange,
                () => setState(() => selectedIndex = 1),
              ),
            ),
          ],
        ),

        const SizedBox(height: 25),

        const Text(
          'Your Classes',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: darkBlue,
          ),
        ),

        const SizedBox(height: 12),

        if (classes.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const Icon(
                    Icons.video_library_outlined,
                    size: 45,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'No classes available yet',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.isTeacher
                        ? 'Create your first class'
                        : 'Join a class using Class ID',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

        ...classes.map(
          (item) => Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE8EEFF),
                child: Icon(Icons.video_call, color: primaryBlue),
              ),
              title: Text(item['title']!),
              subtitle: Text('Class ID: ${item['id']}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget quickCard(
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22),
          child: Column(
            children: [
              Icon(icon, color: color, size: 35),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// STUDY MATERIALS

class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 65,
            color: primaryBlue,
          ),
          SizedBox(height: 15),
          Text(
            'Study Materials',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: darkBlue,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'PDFs and notes will appear here.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// ANNOUNCEMENTS

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.campaign,
            size: 65,
            color: primaryBlue,
          ),
          SizedBox(height: 15),
          Text(
            'Announcements',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: darkBlue,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'No announcements yet.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// PROFILE

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 42,
            backgroundColor: Color(0xFFE8EEFF),
            child: Icon(
              Icons.person,
              size: 48,
              color: primaryBlue,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'EduLive User',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: darkBlue,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Welcome to EduLive',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 25),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
