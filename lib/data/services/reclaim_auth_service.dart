import 'package:reclaim_sdk/reclaim.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/env_api_constants.dart';

enum AuthProvider { x, google, linkedIn, warpcast }

class ReclaimAuthService {
  static const Map<AuthProvider, String> providerIds = {
    AuthProvider.x: X_PROVIDER_ID,
    AuthProvider.google: GOOGLE_PROVIDER_ID,
    AuthProvider.linkedIn: LINKEDIN_PROVIDER_ID,
    AuthProvider.warpcast: FARCASTER_PROVIDER_ID,
  };

  Future<ReclaimProofRequest> initializeProofRequest(
      AuthProvider provider) async {
    final providerId = providerIds[provider];
    if (providerId == null) throw Exception('Invalid provider');

    return await ReclaimProofRequest.init(
      APPLICATION_ID,
      APPPLICATION_SECRET,
      providerId,
    );
  }

  Future<String> generateRequestUrl(ReclaimProofRequest request) async {
    return await request.getRequestUrl();
  }

  Future<bool> launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      return await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    }
    throw 'Could not launch $url';
  }

  Future<void> startVerificationSession(
    ReclaimProofRequest request,
    Function(dynamic) onSuccess,
    Function(Exception) onError,
  ) async {
    await request.startSession(
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}
