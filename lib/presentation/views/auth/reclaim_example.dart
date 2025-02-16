// import 'package:flutter/material.dart';
// import 'package:reclaim_sdk/reclaim.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:zkdating/core/constants/env_api_constants.dart';

// class ReclaimExample extends StatefulWidget {
//   @override
//   _ReclaimExampleState createState() => _ReclaimExampleState();
// }

// class _ReclaimExampleState extends State<ReclaimExample> {
//   String _status = '';
//   String _proofData = '';

//   Future<void> _startVerificationSession(ReclaimProofRequest request) async {
//     await request.startSession(
//       onSuccess: _handleProofSuccess,
//       onError: _handleProofError,
//     );
//   }

//   void _handleProofSuccess(dynamic proof) {
//     print('Proof received: $proof');
//     var proofDataValue = '';
//     if (proof is String) {
//       // Handle custom callback URL response
//       proofDataValue = proof;
//     } else {
//       if (proof is List) {
//         /* 
//         when using provider with multiple proofs, we get an array of proofs
//         we need to extract the claim data from each proof in a variable and then add it to the proofDataValue
//       */
//         var allProofs = '';
//         for (var proof in proof) {
//           allProofs += '${proof.claimData.context}\n\n';
//         }
//         proofDataValue =
//             'Extracted data: $allProofs\n\nFull proof: ${proof.toString()}';
//       } else {
//         /* 
//           when using provider with a single proof, we get a single proof object
//           we need to extract the claim data from the proof object and then add it to the proofDataValue
//         */
//         proofDataValue =
//             'Extracted data: ${proof.claimData.context}\n\nFull proof: ${proof.toString()}';
//       }
//     }
//     setState(() {
//       _status = 'Proof received!';
//       _proofData = proofDataValue;
//     });
//   }

//   void _handleProofError(Exception error) {
//     _handleError('Error in proof generation', error);
//   }

//   void _handleError(String message, dynamic error) {
//     print('$message: $error');
//     setState(() => _status = '$message: ${error.toString()}');
//   }

//   Future<ReclaimProofRequest> _initializeProofRequest() async {
//     final reclaimProofRequest = await ReclaimProofRequest.init(
//       APPLICATION_ID,
//       APPPLICATION_SECRET,
//       'f9f383fd-32d9-4c54-942f-5e9fda349762',
//     );
//     return reclaimProofRequest;
//   }

//   Future<String> _generateRequestUrl(ReclaimProofRequest request) async {
//     final requestUrl = await request.getRequestUrl();
//     print('Request URL: $requestUrl');
//     return requestUrl;
//   }

//   Future<void> _launchUrl(String url) async {
//     if (await canLaunchUrl(Uri.parse(url))) {
//       final launched = await launchUrl(
//         Uri.parse(url),
//         mode: LaunchMode.externalApplication,
//       );
//       if (launched) {
//         setState(() => _status = 'Session started. Waiting for proof...');
//       } else {
//         throw 'Could not launch $url';
//       }
//     }
//   }

//   Future<void> startReclaimSession() async {
//     try {
//       print('Starting Reclaim session');
//       final reclaimProofRequest = await _initializeProofRequest();
//       final requestUrl = await _generateRequestUrl(reclaimProofRequest);
//       await _launchUrl(requestUrl);
//       await _startVerificationSession(reclaimProofRequest);
//     } catch (error) {
//       _handleError('Error starting Reclaim session', error);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Reclaim SDK Demo')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: startReclaimSession,
//               child: const Text('Start Reclaim Session'),
//             ),
//             const SizedBox(height: 20),
//             Text(_status, style: const TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 20),
//             if (_proofData.isNotEmpty)
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Text(_proofData),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
