import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  final String _appVersion = '1.0.0';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          // Preferences Section
          const _SectionHeader(title: 'Preferences'),
          SwitchListTile(
            title: const Text('Notifications'),
            subtitle: const Text('Receive updates about your goals'),
            secondary: const Icon(Icons.notifications_outlined),
            value: _notificationsEnabled,
            activeColor: const Color(0xFF2E7D32),
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    value
                        ? 'Notifications enabled'
                        : 'Notifications disabled',
                  ),
                ),
              );
            },
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Switch to dark theme'),
            secondary: const Icon(Icons.dark_mode_outlined),
            value: _darkModeEnabled,
            activeColor: const Color(0xFF2E7D32),
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Dark mode coming soon!'),
                ),
              );
            },
          ),
          const Divider(height: 32),
          // About Section
          const _SectionHeader(title: 'About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('App Version'),
            trailing: Text(
              _appVersion,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('Developer'),
            subtitle: const Text('Community Savings Team'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Community Savings',
                applicationVersion: _appVersion,
                applicationIcon: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.savings,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                children: const [
                  Text(
                    'An app to help communities save money together for shared goals.',
                  ),
                ],
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Privacy Policy'),
                  content: const SingleChildScrollView(
                    child: Text(
                      'This app stores your data locally on your device. '
                      'We do not collect or share your personal information '
                      'with third parties.\n\n'
                      'All savings data is stored securely using SharedPreferences.',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Terms of Service'),
                  content: const SingleChildScrollView(
                    child: Text(
                      'By using this app, you agree to:\n\n'
                      '1. Use the app for legitimate community savings purposes\n'
                      '2. Provide accurate information\n'
                      '3. Respect other community members\n'
                      '4. Keep your account credentials secure\n\n'
                      'This is a demonstration app for educational purposes.',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(height: 32),
          // Support Section
          const _SectionHeader(title: 'Support'),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & FAQ'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Help & FAQ'),
                  content: const SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Q: How do I create a savings goal?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'A: Tap the + button on the home screen.\n',
                        ),
                        Text(
                          'Q: Can I edit my contributions?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'A: Currently, contributions cannot be edited once added.\n',
                        ),
                        Text(
                          'Q: Is my data safe?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'A: Yes, all data is stored locally on your device.',
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: const Text('Send Feedback'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Feedback form coming soon!'),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2E7D32),
        ),
      ),
    );
  }
}
