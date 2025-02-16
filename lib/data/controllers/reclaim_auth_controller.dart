import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/enum.dart';
import '../../utils/locator.dart';
import '../local/secure_storage_service.dart';
import '../services/reclaim_auth_service.dart';
import 'base_controller.dart';

final reclaimAuthController = ChangeNotifierProvider<ReclaimAuthController>(
    (ref) => ReclaimAuthController());

class ReclaimAuthController extends BaseChangeNotifier {
  final ReclaimAuthService _authService = ReclaimAuthService();
  String _status = '';
  String _proofData = '';

  String get status => _status;
  String get proofData => _proofData;

  Future<bool> signInWithProvider(AuthProvider provider) async {
    loadingState = LoadingState.loading;
    try {
      final reclaimProofRequest =
          await _authService.initializeProofRequest(provider);
      final requestUrl =
          await _authService.generateRequestUrl(reclaimProofRequest);

      await _authService.launchUrl(requestUrl);

      await _authService.startVerificationSession(
        reclaimProofRequest,
        _handleProofSuccess,
        _handleProofError,
      );

      loadingState = LoadingState.idle;
      return true;
    } catch (e) {
      loadingState = LoadingState.idle;
      _handleError('Error during authentication', e);
      return false;
    }
  }

  void _handleProofSuccess(dynamic proof) async {
    try {
      // Convert proof data to string if it isn't already
      String proofString = proof is String ? proof : proof.toString();

      // Extract email from the proof data
      if (proof is String) {
        // If proof is already a string, parse it as JSON
        Map<String, dynamic> proofMap = json.decode(proofString);
        if (proofMap.containsKey('extractedParameters') &&
            proofMap['extractedParameters'] is Map &&
            proofMap['extractedParameters'].containsKey('email')) {
          String email = proofMap['extractedParameters']['email'];
          // Remove extra quotes if present
          email = email.replaceAll('"', '');

          await _saveEmail(email);
        }
      } else {
        // Handle case where proof is an object with claimData
        if (proof?.claimData?.context != null) {
          Map<String, dynamic> contextMap =
              json.decode(proof.claimData.context);
          if (contextMap.containsKey('extractedParameters') &&
              contextMap['extractedParameters'].containsKey('email')) {
            String email = contextMap['extractedParameters']['email'];
            email = email.replaceAll('"', '');

            await _saveEmail(email);
          }
        }
      }

      _status = 'Authentication successful!';
      notifyListeners();
    } catch (e) {
      log('Error processing proof data: $e');
      _status = 'Error processing authentication data';
      notifyListeners();
    }
  }

  Future<void> _saveEmail(String email) async {
    try {
      await locator<SecureStorageService>().write(
        key: 'user_email',
        value: email,
      );
      log('Email saved successfully: $email');
    } catch (e) {
      log('Error saving email: $e');
      throw Exception('Failed to save email');
    }
  }

  void _handleProofError(Exception error) {
    _handleError('Error in proof generation', error);
  }

  void _handleError(String message, dynamic error) {
    log('$message: $error');
    _status = '$message: ${error.toString()}';
    notifyListeners();
  }
}
