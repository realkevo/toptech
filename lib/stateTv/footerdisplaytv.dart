import 'dart:convert'; // For base64 decoding
import 'dart:typed_data'; // For image byte manipulation

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening links

class FooterDisplayTv extends StatefulWidget {
  const FooterDisplayTv({super.key});

  @override
  _FooterDisplayTvState createState() => _FooterDisplayTvState();
}

class _FooterDisplayTvState extends State<FooterDisplayTv> {
  // Fetch data from Firestore
  Future<Map<String, String>> fetchFooterData() async {
    try {
      var querySnapshot =
      await FirebaseFirestore.instance.collection('footerData').get();

      if (querySnapshot.docs.isNotEmpty) {
        var document = querySnapshot.docs[0];

        return {
          'githubIcon': document['githubIcon'],
          'xIcon': document['xIcon'],
          'redditIcon': document['redditIcon'],
          'facebookIcon': document['facebookIcon'],
          'partnerOneIcon': document['partnerOneIcon'],
          'partnerTwoIcon': document['partnerTwoIcon'],
          'partnerThreeIcon': document['partnerThreeIcon'],
          'copyRightIcon': document['copyRightIcon'],
        };
      } else {
        return {};
      }
    } catch (e) {
      print("Error fetching footer data: $e");
      return {};
    }
  }

  // Decode base64 image
  Image _decodeBase64ToImage(String base64String) {
    try {
      Uint8List bytes = base64Decode(base64String);
      return Image.memory(bytes, fit: BoxFit.contain);
    } catch (e) {
      print("Error decoding base64: $e");
      return Image.asset('assets/placeholder.png', fit: BoxFit.contain);
    }
  }

  // Launch external URL with proper mode for Android/iOS
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightFactor = MediaQuery.of(context).size.height;
    double widthFactor = MediaQuery.of(context).size.width;

    return Container(
      width: widthFactor,
      padding: EdgeInsets.symmetric(
        horizontal: widthFactor * 0.05,
        vertical: heightFactor * 0.012,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0A0E21),
            Color(0xFF12233F),
            Color(0xFF1E3C72),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(7.0),
          topRight: Radius.circular(7.0),
        ),
      ),
      child: FutureBuilder<Map<String, String>>(
        future: fetchFooterData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading data"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          var footerData = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(
              children: [
                // Social Media Links
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Follow us",
                              style: TextStyle(
                                fontSize: heightFactor * 0.014,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          _buildSocialLink(footerData['githubIcon'], 'GitHub',
                              'https://github.com/realkevo'),
                          _buildSocialLink(
                              footerData['xIcon'], 'X', 'https://twitter.com'),
                          _buildSocialLink(footerData['redditIcon'], 'Reddit',
                              'https://reddit.com'),
                          _buildSocialLink(footerData['facebookIcon'],
                              'LinkedIn', 'https://linkedin.com'),
                        ],
                      ),
                    ),

                    // Address Section
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "P.O Box 600-63 Nairobi, Kenya",
                            style: TextStyle(
                              fontSize: heightFactor * 0.014,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Mombasa Road, Platnum Plaza flr 2",
                            style: TextStyle(
                              fontSize: heightFactor * 0.014,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Partners Section
                    Flexible(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(7.0),
                            topRight: Radius.circular(7.0),
                          ),
                          color: Colors.deepOrange,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 2.0, right: 2.0),
                                child: Text(
                                  "Partners and sponsors",
                                  style: TextStyle(
                                    fontSize: heightFactor * 0.024,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            _buildPartnerLogo(footerData['partnerOneIcon']),
                            _buildPartnerLogo(footerData['partnerTwoIcon']),
                            _buildPartnerLogo(footerData['partnerThreeIcon']),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Copyright Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    footerData['copyRightIcon'] != null
                        ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 15,
                      width: 15,
                      child: _decodeBase64ToImage(footerData['copyRightIcon']!),
                    )
                        : const SizedBox.shrink(),
                    const SizedBox(width: 5),
                    Text(
                      "© 2025 Your Company. All Rights Reserved.",
                      style: TextStyle(
                          fontSize: heightFactor * 0.014, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper function to build social links
  Widget _buildSocialLink(String? base64Icon, String label, String url) {
    if (base64Icon != null) {
      return GestureDetector(
        onTap: () => _launchURL(url),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: 20,
              width: 20,
              child: _decodeBase64ToImage(base64Icon),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  // Helper function to build partner logos
  Widget _buildPartnerLogo(String? base64Icon) {
    return base64Icon != null
        ? Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: 20,
      width: 20,
      child: _decodeBase64ToImage(base64Icon),
    )
        : const SizedBox.shrink();
  }
}
