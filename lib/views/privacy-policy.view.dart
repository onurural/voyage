import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeIn(
                child: SizedBox(
                  width: 250,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('Voyage Privacy Policy'),
                      ],
                      onTap: () {

                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FadeIn(
                child: const Text(
                  '1. Introduction',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: const Text(
                  'Welcome to Voyage. This privacy policy governs the collection, use, and disclosure of personal information by the Voyage trip schedule maker application.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              FadeIn(
                child: const Text(
                  '2. Information We Collect',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: const Text(
                  'We may collect information about you, including but not limited to your name, email address, phone number, and trip details, in order to provide you with a personalized experience within the app.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              FadeIn(
                child: const Text(
                  '3. How We Use Your Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: const Text(
                  'We use the information we collect to improve the app, provide personalized trip suggestions, and communicate with you about updates and promotions.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              FadeIn(
                child: const Text(
                  '4. Sharing Your Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: const Text(
                  'We will not share your personal information with third parties without your consent, except as required by law or to protect the rights and safety of our users and the app.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              FadeIn(
                child: const Text(
                  '5. Security',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: const Text(
                  'We take the security of your personal information seriously and implement reasonable measures to protect it from unauthorized access, disclosure, or destruction. However, no method of transmission or storage is 100% secure, so we cannot guarantee absolute security.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              FadeIn(
                child: const Text(
                  '6. Changes to This Privacy Policy',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: const Text(
                  'We may update this privacy policy from time to time. We encourage you to review it periodically to stay informed about our privacy practices. Your continued use of the app constitutes your acceptance of the updated privacy policy.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              FadeIn(
                child: const Text(
                  '7. Contact Us',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: const Text(
                  'If you have any questions or concerns about this privacy policy or our handling of your personal information, please contact us at support@voyageapp.com.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
