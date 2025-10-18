import 'dart:convert'; // For base64 decoding
import 'dart:typed_data'; // For image byte manipulation

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/mainuploadclass.dart'; // For opening links

class FooterDisplayTv extends StatefulWidget {
  const FooterDisplayTv({super.key});

  @override
  _FooterDisplayTvState createState() => _FooterDisplayTvState();
}

class _FooterDisplayTvState extends State<FooterDisplayTv> {
  Future<Map<String, String>> fetchFooterData() async {
    try {
      var querySnapshot = await FirebaseFirestore.instance.collection('footerData').get();

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
          'poBoxAddress': document['poBoxAddress'],
          'streetAddress': document['streetAddress'],
        };
      } else {
        return {};
      }
    } catch (e) {
      print("Error fetching footer data: $e");
      return {};
    }
  }

  Image _decodeBase64ToImage(String base64String) {
    try {
      Uint8List bytes = base64Decode(base64String);
      return Image.memory(bytes, fit: BoxFit.contain);
    } catch (e) {
      print("Error decoding base64: $e");
      return Image.asset('assets/placeholder.png', fit: BoxFit.contain);
    }
  }

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

    return FutureBuilder<Map<String, String>>(
      future: fetchFooterData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading data"));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No data available"));
        }

        var footerData = snapshot.data!;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              color: Colors.grey.shade700,
              thickness: 1,
              indent: widthFactor * 0.05,
              endIndent: widthFactor * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widthFactor * 0.05,
                vertical: heightFactor * 0.012,
              ),
              child: Column(
                children: [
                  // Social Media Links, Addresses, and Partners Row
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
                            _buildSocialLink(footerData['githubIcon'], 'GitHub', 'https://github.com/realkevo'),
                            _buildSocialLink(footerData['xIcon'], 'X', 'https://twitter.com'),
                            _buildSocialLink(footerData['redditIcon'], 'Reddit', 'https://reddit.com'),
                            _buildSocialLink(footerData['facebookIcon'], 'LinkedIn', 'https://linkedin.com'),
                          ],
                        ),
                      ),

                      Flexible(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              footerData['poBoxAddress'] ?? 'P.O Box Not Available',
                              style: TextStyle(
                                fontSize: heightFactor * 0.014,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              footerData['streetAddress'] ?? 'Street Address Not Available',
                              style: TextStyle(
                                fontSize: heightFactor * 0.014,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
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
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Copyright Row with some spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (footerData['copyRightIcon'] != null)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 15,
                          width: 15,
                          child: _decodeBase64ToImage(footerData['copyRightIcon']!),
                        ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Mainuploadclass()),
                          );
                        },
                        child: Text(
                          "© 2025 Your Company. All Rights Reserved.",
                          style: TextStyle(fontSize: heightFactor * 0.014, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

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
