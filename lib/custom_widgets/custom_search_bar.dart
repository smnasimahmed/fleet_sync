import 'package:fleet_sync/const/const_strings.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  const CustomSearchBar({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          hintText: ConstStrings.searchHere,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CustomSearchBar extends StatelessWidget {
//   final TextEditingController controller;
//   final VoidCallback onFilterTap;
//   final ValueChanged<String>? onChanged;

//   const CustomSearchBar({
//     super.key,
//     required this.controller,
//     required this.onFilterTap,
//     this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF2A2A2A),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 children: [
//                   const Icon(Icons.search, color: Colors.white54),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: TextField(
//                       controller: controller,
//                       onChanged: onChanged,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: const InputDecoration(
//                         hintText: 'Search here',
//                         hintStyle: TextStyle(color: Colors.white54),
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           GestureDetector(
//             onTap: onFilterTap,
//             child: Container(
//               height: 48,
//               width: 48,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF00FF66),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: SvgPicture.asset(
//                   'assets/icons/filter.svg', // replace with your filter icon
//                   height: 24,
//                   width: 24,
//                   colorFilter: const ColorFilter.mode(
//                     Colors.black,
//                     BlendMode.srcIn,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
