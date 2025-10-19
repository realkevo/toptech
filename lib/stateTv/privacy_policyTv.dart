import 'package:flutter/material.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  // Helper methods (_buildSectionHeader, _buildBodyText, _buildListItem)
  // remain exactly the same.
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
                fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: _buildBodyText(text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // CORE CHANGE: Replace the `Material` widget with a `Builder` widget.
    // This gives the ListView a proper context from which to build the Text widgets,
    // ensuring they inherit the correct theme and styles without a white background.
    return Builder(
      builder: (BuildContext newContext) {
        return ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            // Using `newContext` here, though `context` would also work.
            // It's good practice to use the new context provided by the Builder.
            const Text(
              'Last Updated: October 18, 2025',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 16),
            _buildBodyText(
              'Welcome to eye ("we," "our," "us"). We are committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application (the "App"). Please read this privacy policy carefully. If you do not agree with the terms of this privacy policy, please do not access the application.',
            ),

            _buildSectionHeader('1. Information We Collect', newContext),
            _buildBodyText(
              'We may collect information about you in a variety of ways. The information we may collect via the App depends on the content and materials you use, and includes:',
            ),
            _buildListItem(
              'Personal Data: While using our App, we may ask you to provide us with certain personally identifiable information, such as email address, name, and user-generated content (e.g., text and images).',
            ),
            _buildListItem(
              'Usage Data: We may automatically collect information like your device\'s IP address, device type, operating system, and usage statistics to improve app functionality.',
            ),
            _buildListItem(
              'Data from Third-Party Services: Our App uses services like Firebase/Cloud Firestore to store and sync data. Please review the privacy policy of Google Firebase for more information.',
            ),

            _buildSectionHeader('2. How We Use Your Information', newContext),
            _buildBodyText(
              'Having accurate information about you permits us to provide you with a smooth, efficient, and customized experience. Specifically, we may use information collected about you via the App to:',
            ),
            _buildListItem('Create and manage your account.'),
            _buildListItem(
                'Display user-generated content, such as slogans and images, within the App.'),
            _buildListItem(
                'Monitor and analyze usage and trends to improve your experience.'),
            _buildListItem(
                'Ensure the security and operational functionality of our App.'),

            _buildSectionHeader('3. Disclosure of Your Information', newContext),
            _buildBodyText(
              'We do not sell, trade, or rent your Personal Data to others. We may share information we have collected about you in certain situations:',
            ),
            _buildListItem(
                'By Law or to Protect Rights: If we believe the release of information about you is necessary to respond to legal process or to protect the rights, property, and safety of others.'),
            _buildListItem(
                'Third-Party Service Providers: We may share your information with third parties that perform services for us, such as data storage (Google Firebase) and analysis.'),

            _buildSectionHeader('4. Security of Your Information', newContext),
            _buildBodyText(
              'We use administrative, technical, and physical security measures to help protect your personal information. While we have taken reasonable steps to secure the information you provide, please be aware that no security measures are perfect or impenetrable.',
            ),

            _buildSectionHeader('5. Your Data Protection Rights', newContext),
            _buildBodyText(
              'Depending on your location, you may have rights regarding your personal information, including the right to access, rectify, or request erasure of your data. To exercise these rights, please contact us.',
            ),

            _buildSectionHeader('6. Children\'s Privacy', newContext),
            _buildBodyText(
              'Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. If we become aware that we have collected data from a child, we will take steps to remove it.',
            ),

            _buildSectionHeader('7. Changes to This Privacy Policy', newContext),
            _buildBodyText(
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new policy on this page and updating the "Last Updated" date. You are advised to review this Privacy Policy periodically.',
            ),

            _buildSectionHeader('8. Contact Us', newContext),
            _buildBodyText(
                'If you have questions or comments about this Privacy Policy, please contact us:'),
            _buildListItem('Email: [Your Support Email Address]'),
            _buildListItem('Website: [Your Website, if any]'),
            _buildListItem('Address: [Your Physical or Mailing Address]'),

            const SizedBox(height: 32), // Extra space at the bottom
          ],
        );
      },
    );
  }
}
