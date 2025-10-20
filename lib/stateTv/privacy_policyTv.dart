import 'package:flutter/material.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBodyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        height: 1.5,
        color: Colors.white70,
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: _buildBodyText(text)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext newContext) {
        return ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            const Text(
              'Last Updated: October 19, 2025',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 16),
            _buildBodyText(
              'Eye (“the App”) is a mobile application that allows users to scan, analyze, and organize images on their device. All processing happens locally — no photos, text, or personal data leave your device.',
            ),

            _buildSectionHeader('1. Information We Collect', newContext),
            _buildListItem(
                'Personal Data: Eye does not collect or store personal data on external servers.'),
            _buildListItem(
                'Usage Data: The app may collect anonymous data such as device model, Android version, and crash logs to improve performance. All this is collected offline and handled offline. Does not leave the users device'),
            _buildListItem(
                'Advertising Data: Eye integrates Google AdMob, which may collect advertising identifiers, IP address, and interaction data. See Google’s privacy policy for details.'),

            _buildSectionHeader('2. How We Use Information', newContext),
            _buildListItem('To perform local image and OCR scanning.'),
            _buildListItem('To manage cached embeddings for faster scanning.'),
            _buildListItem('To display ads through Google AdMob.'),
            _buildListItem('To improve stability and detect crashes.'),

            _buildSectionHeader('3. Data Storage and Security', newContext),
            _buildBodyText(
              'All scan data, cache, and embeddings are stored locally on your device. No cloud backups or remote servers are used. You can clear all data using the “Clear Cache” option in the app. Uninstalling the app removes all stored data.',
            ),

            _buildSectionHeader('4. Third-Party Services', newContext),
            _buildListItem('Google AdMob – for displaying ads.'),

            _buildSectionHeader('5. User Rights', newContext),
            _buildListItem('Deny app permissions such as storage or camera at any time.'),
            _buildListItem('Opt out of personalized ads where available.'),
            _buildListItem('Clear all cached or scanned data from within the app.'),
            _buildListItem('Contact the developer for data-related inquiries.'),

            _buildSectionHeader('6. Children’s Privacy', newContext),
            _buildBodyText(
              'Eye is not intended for children under 13. The app does not knowingly collect data from minors. If a child’s data is found, it will be deleted immediately upon notice.',
            ),

            _buildSectionHeader('7. Policy Updates', newContext),
            _buildBodyText(
              ' Updates will be posted within the app and on the official website. Continued use of the app indicates acceptance of the updated terms.',
            ),

            _buildSectionHeader('8. Contact Information', newContext),
            _buildListItem('Email: support.toptech.com'),
            _buildListItem('Developer: toptech'),
            _buildListItem('Website: https://toptech-1dc04.web.app/#/privacy'),

            const SizedBox(height: 32),
            _buildBodyText(
              'Summary: Eye respects your privacy. Your images, scans, and text data never leave your device. Ad data is managed solely by Google AdMob under its privacy policy.',
            ),
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }
}
