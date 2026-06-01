
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Root App
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Exercise 4 - ThemeData + Dark Mode
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),

      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: HomeScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: (value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
    );
  }
}

/// Main Menu Screen
class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lab 4 - Flutter UI Fundamentals"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(
          children: [
            buildMenuButton(
              context,
              "Exercise 1 - Core Widgets",
              const CoreWidgetsDemo(),
            ),

            buildMenuButton(
              context,
              "Exercise 2 - Input Widgets",
              const InputControlsDemo(),
            ),

            buildMenuButton(
              context,
              "Exercise 3 - Layout Basics",
              const LayoutDemo(),
            ),

            buildMenuButton(
              context,
              "Exercise 4 - Scaffold & Theme",
              ThemeDemo(
                isDarkMode: isDarkMode,
                onThemeChanged: onThemeChanged,
              ),
            ),

            buildMenuButton(
              context,
              "Exercise 5 - UI Fixes",
              const FixCommonErrorsDemo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(
    BuildContext context,
    String title,
    Widget screen,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(title),
        ),
      ),
    );
  }
}

/// =======================================================
/// Exercise 1 - Core Widgets
/// =======================================================

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 1 - Core Widgets"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to Flutter UI",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Center(
              child: Icon(
                Icons.flutter_dash,
                size: 80,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),

            Image.network(
              "https://picsum.photos/400/200",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 4,

              child: const ListTile(
                leading: Icon(Icons.movie),
                title: Text("Movie Item"),
                subtitle: Text("This is a sample ListTile inside a Card"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================================================
/// Exercise 2 - Input Widgets
/// =======================================================

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() =>
      _InputControlsDemoState();
}

class _InputControlsDemoState
    extends State<InputControlsDemo> {
  double sliderValue = 50;
  bool isActive = false;
  String selectedGenre = "None";
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 2 - Input Widgets"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(
          children: [
            const Text(
              "Rating (Slider)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Slider(
              value: sliderValue,
              min: 0,
              max: 100,

              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              },
            ),

            Text("Current value: ${sliderValue.toInt()}"),

            const SizedBox(height: 20),

            const Text(
              "Active (Switch)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Switch(
              value: isActive,
              onChanged: (value) {
                setState(() {
                  isActive = value;
                });
              },
            ),

            Text(
              isActive
                  ? "Movie is active"
                  : "Movie is inactive",
            ),

            const SizedBox(height: 20),

            const Text(
              "Genre (RadioListTile)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            RadioListTile(
              title: const Text("Action"),
              value: "Action",
              groupValue: selectedGenre,

              onChanged: (value) {
                setState(() {
                  selectedGenre = value.toString();
                });
              },
            ),

            RadioListTile(
              title: const Text("Comedy"),
              value: "Comedy",
              groupValue: selectedGenre,

              onChanged: (value) {
                setState(() {
                  selectedGenre = value.toString();
                });
              },
            ),

            Text("Selected genre: $selectedGenre"),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate =
                    await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );

                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },

              child: const Text("Open Date Picker"),
            ),

            const SizedBox(height: 10),

            Text(
              selectedDate == null
                  ? "No date selected"
                  : "Selected date: ${selectedDate.toString().split(" ")[0]}",
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================================================
/// Exercise 3 - Layout Basics
/// =======================================================

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> movies = [
      "Avatar",
      "Inception",
      "Interstellar",
      "Joker",
      "Avengers",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 3 - Layout Basics"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Now Playing",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: movies.length,

                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 12),

                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            movies[index][0],
                          ),
                        ),

                        title: Text(movies[index]),

                        subtitle: const Text(
                          "Sample description",
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================================================
/// Exercise 4 - Scaffold + Theme
/// =======================================================

class ThemeDemo extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const ThemeDemo({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 4 - App Structure"),

        actions: [
          Row(
            children: [
              const Text("Dark"),

              Switch(
                value: isDarkMode,
                onChanged: onThemeChanged,
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("FAB Clicked"),
            ),
          );
        },

        child: const Icon(Icons.add),
      ),

      body: const Center(
        child: Text(
          "This is a simple screen with theme toggle.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

/// =======================================================
/// Exercise 5 - Fix Common UI Errors
/// =======================================================

class FixCommonErrorsDemo extends StatefulWidget {
  const FixCommonErrorsDemo({super.key});

  @override
  State<FixCommonErrorsDemo> createState() =>
      _FixCommonErrorsDemoState();
}

class _FixCommonErrorsDemoState
    extends State<FixCommonErrorsDemo> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    List<String> movies = [
      "Movie A",
      "Movie B",
      "Movie C",
      "Movie D",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 5 - UI Fixes"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Correct ListView inside Column using Expanded",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 250,

                child: ListView.builder(
                  itemCount: movies.length,

                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.movie),
                      title: Text(movies[index]),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Fix state update issue using setState()",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Counter: $counter",
                style: const TextStyle(fontSize: 20),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    counter++;
                  });
                },

                child: const Text("Increase Counter"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                },

                child: const Text(
                  "Open Date Picker Safely",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

