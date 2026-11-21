import 'package:shared_preferences/shared_preferences.dart';

const String prefHasSeenOnboardingKey = 'has_seen_onboarding';

class OnboardingService {
  const OnboardingService();

  static const OnboardingService instance = OnboardingService();

  Future<bool> hasSeenOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(prefHasSeenOnboardingKey) ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<void> markOnboardingCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(prefHasSeenOnboardingKey, true);
    } catch (_) {
      // Allow user to proceed to app even if preference write fails.
    }
  }

  Future<void> resetOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(prefHasSeenOnboardingKey, false);
    } catch (_) {
      // Ignore storage failures during reset.
    }
  }
}
