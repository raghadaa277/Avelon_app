// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// class HistorySearchWidget extends StatelessWidget {
//   HistorySearchWidget({super.key});

//   // final controller = Get.find<HistorySearchContoller>();

//   @override
//   Widget build(BuildContext context) {
//     debugPrint("LIST LENGTH => ${controller.historySearchList.length}");
//     return ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),

//       itemCount: controller.historySearchList.length,

//       separatorBuilder: (_, __) => const SizedBox(height: 12),

//       itemBuilder: (context, index) {
//         final item = controller.historySearchList[index];

//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//           decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 151, 148, 150),
//             borderRadius: BorderRadius.circular(17),
//           ),

//           child: Row(
//             children: [
//               const Icon(Icons.history, color: Colors.black),

//               const SizedBox(width: 12),

//               Expanded(
//                 child: Text(item.keyword, style: const TextStyle(fontSize: 15)),
//               ),

//               IconButton(
//                 icon: Icon(Icons.close, color: Colors.red[200]),
//                 onPressed: () {
//                   debugPrint("DELETE CLICKED => ${item.keyword}");
//                   Get.defaultDialog(
//                     title: "Delete Search",
//                     middleText:
//                         "Are you sure you want to delete '${item.keyword}' from history?",
//                     radius: 16,

//                     cancel: TextButton(
//                       onPressed: () => Get.back(),
//                       child: const Text(
//                         "Cancel",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ),

//                     confirm: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.redAccent[200],
//                       ),
//                       onPressed: () async {
//                         Get.back();

//                         await controller.cleareonehistorysearch(item.keyword);
//                       },
//                       child: const Text(
//                         "Delete",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
