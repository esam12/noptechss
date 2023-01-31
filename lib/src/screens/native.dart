// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class NativeCodeScreen extends StatefulWidget {
//   const NativeCodeScreen({super.key});

//   @override
//   State<NativeCodeScreen> createState() => _NativeCodeScreenState();
// }

// class _NativeCodeScreenState extends State<NativeCodeScreen> {
//   static const platform = MethodChannel('webviewNative');
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             ElevatedButton(
//               onPressed: _getBatteryLevel,
//               child: const Text('Get Battery Level'),
//             ),
//             Text(_batteryLevel),
//           ],
//         ),
//       ),
//     );
//   }

//   String _batteryLevel = 'Unknown battery level.';

//   Future<void> _getBatteryLevel() async {
//     String batteryLevel;
//     try {
//       final int result = await platform.invokeMethod('getBatteryLevel');
//       batteryLevel = 'Battery level at $result % .';
//     } on PlatformException catch (e) {
//       batteryLevel = "Failed to get battery level: '${e.message}'.";
//     }

//     setState(() {
//       _batteryLevel = batteryLevel;
//     });
//   }
// }
