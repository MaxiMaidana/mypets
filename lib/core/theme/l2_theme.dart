
// import 'package:flutter/material.dart';

// class ThemeDataApp {
//   static ThemeData? get lightTheme {
//     return ThemeData(
//       appBarTheme: AppBarTheme(
//         backgroundColor: AppColors.backgroundColor,
//         foregroundColor: AppColors.primaryColor,
//         titleTextStyle: TextStyles.h6.copyWith(
//           color: AppColors.licorice,
//         ),
//       ),
//       backgroundColor: AppColors.backgroundColor,
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         backgroundColor: Colors.white,
//         elevation: 10,
//         selectedLabelStyle: TextStyles.bodyTextSmall,
//         unselectedLabelStyle: TextStyles.bodyTextSmall,
//         selectedItemColor: AppColors.primaryColor,
//         unselectedItemColor: AppColors.cello,
//         type: BottomNavigationBarType.fixed,
//         showUnselectedLabels: true,
//       ),
//       bottomSheetTheme: const BottomSheetThemeData(
//         backgroundColor: AppColors.backgroundColor,
//       ),
//       brightness: Brightness.light,
//       checkboxTheme: CheckboxThemeData(
//         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         checkColor: MaterialStateProperty.resolveWith<Color?>(
//           (Set<MaterialState> states) {
//             return Colors.white;
//           },
//         ),
//         fillColor: MaterialStateProperty.resolveWith<Color?>(
//           (Set<MaterialState> states) {
//             return AppColors.cello;
//           },
//         ),
//       ),
//       dialogTheme: DialogTheme(
//         backgroundColor: Colors.white,
//         elevation: 24,
//         titleTextStyle: TextStyles.h4.copyWith(color: AppColors.licorice),
//         contentTextStyle: TextStyles.bodyTextLarge.copyWith(
//           color: AppColors.cello,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.resolveWith<Color?>(
//             (Set<MaterialState> states) {
//               if (states.contains(MaterialState.disabled)) {
//                 return AppColors.primaryColor.withOpacity(0.5);
//               }
//               return AppColors.primaryColor;
//             },
//           ),
//           foregroundColor: MaterialStateProperty.resolveWith<Color?>(
//             (Set<MaterialState> states) {
//               return Colors.white;
//             },
//           ),
//           textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
//             (Set<MaterialState> states) {
//               return TextStyles.bodyTextLarge;
//             },
//           ),
//           padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
//             (Set<MaterialState> states) {
//               return const EdgeInsets.symmetric(vertical: 7.5);
//             },
//           ),
//           shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
//             (Set<MaterialState> states) {
//               return const StadiumBorder();
//             },
//           ),
//         ),
//       ),
//       errorColor: AppColors.error,
//       floatingActionButtonTheme: const FloatingActionButtonThemeData(
//         backgroundColor: AppColors.licorice,
//         foregroundColor: AppColors.alice,
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5),
//           borderSide: BorderSide.none,
//         ),
//         errorBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8)),
//           borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
//         ),
//         errorStyle: TextStyles.bodyTextSmall.copyWith(color: AppColors.error),
//         focusedErrorBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8)),
//           borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
//         ),
//         errorMaxLines: 2,
//         fillColor: AppColors.alice,
//         filled: true,
//         focusedBorder: OutlineInputBorder(
//           borderRadius: const BorderRadius.all(Radius.circular(8)),
//           borderSide: BorderSide(
//             color: AppColors.primaryColor.withOpacity(0.4),
//             width: 3.0,
//           ),
//         ),
//         counterStyle: TextStyles.bodyTextSmall,
//         hintStyle: TextStyles.bodyTextLarge.copyWith(
//           color: AppColors.mischka,
//         ),
//         suffixIconColor: AppColors.cello,
//       ),
//       primaryColor: AppColors.primaryColor,
//       primarySwatch: AppColors.generateMaterialColor(AppColors.primaryColor),
//       scaffoldBackgroundColor: AppColors.alice,
//       snackBarTheme: SnackBarThemeData(
//         backgroundColor: AppColors.licorice,
//         contentTextStyle: TextStyles.bodyTextSmall.copyWith(
//           color: Colors.white,
//         ),
//       ),
//       textSelectionTheme: const TextSelectionThemeData(
//         cursorColor: AppColors.licorice,
//       ),
//       textTheme: TextTheme(
//         subtitle1: TextStyles.bodyTextLarge,
//         bodyText2: TextStyles.bodyTextLarge,
//       ),
//       toggleableActiveColor: AppColors.primaryColor,
//     );
//   }

//   static ThemeData? get darkTheme {
//     return ThemeData(
//       appBarTheme: AppBarTheme(
//         backgroundColor: AppColors.darkBackgroundColor,
//         foregroundColor: AppColors.darkPrimaryColor,
//         titleTextStyle: TextStyles.h6.copyWith(
//           color: AppColors.whiteHighEmphasisColor,
//         ),
//         elevation: 4,
//       ),
//       applyElevationOverlayColor: true,
//       backgroundColor: AppColors.darkBackgroundColor,
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         backgroundColor: AppColors.darkBackgroundColor,
//         elevation: 8,
//         selectedLabelStyle: TextStyles.bodyTextSmall,
//         unselectedLabelStyle: TextStyles.bodyTextSmall,
//         selectedItemColor: AppColors.darkPrimaryColor,
//         unselectedItemColor: AppColors.whiteMediumEmphasisColor,
//         type: BottomNavigationBarType.fixed,
//         showUnselectedLabels: true,
//       ),
//       bottomSheetTheme: const BottomSheetThemeData(
//         backgroundColor: AppColors.darkBackgroundColor,
//       ),
//       brightness: Brightness.dark,
//       colorScheme: const ColorScheme.dark(
//         primary: AppColors.darkPrimaryColor,
//         secondary: AppColors.darkPrimaryColor,
//       ),
//       checkboxTheme: CheckboxThemeData(
//         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         checkColor: MaterialStateProperty.resolveWith<Color?>(
//           (Set<MaterialState> states) {
//             return AppColors.darkBackgroundColor;
//           },
//         ),
//         fillColor: MaterialStateProperty.resolveWith<Color?>(
//           (Set<MaterialState> states) {
//             return AppColors.whiteMediumEmphasisColor;
//           },
//         ),
//       ),
//       dialogTheme: DialogTheme(
//         backgroundColor: AppColors.darkBackgroundColor,
//         elevation: 24,
//         titleTextStyle: TextStyles.h4.copyWith(
//           color: AppColors.whiteHighEmphasisColor,
//         ),
//         contentTextStyle: TextStyles.bodyTextLarge.copyWith(
//           color: AppColors.whiteMediumEmphasisColor,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.resolveWith<Color?>(
//             (Set<MaterialState> states) {
//               if (states.contains(MaterialState.disabled)) {
//                 return AppColors.darkPrimaryColor.withOpacity(0.5);
//               }
//               return AppColors.darkPrimaryColor;
//             },
//           ),
//           foregroundColor: MaterialStateProperty.resolveWith<Color?>(
//             (Set<MaterialState> states) {
//               if (states.contains(MaterialState.disabled)) {
//                 return Colors.black;
//               }
//               return Colors.black;
//             },
//           ),
//           shadowColor: MaterialStateProperty.resolveWith<Color?>(
//             (Set<MaterialState> states) {
//               return Colors.transparent;
//             },
//           ),
//           textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
//             (Set<MaterialState> states) {
//               return TextStyles.bodyTextLarge;
//             },
//           ),
//           padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
//             (Set<MaterialState> states) {
//               return const EdgeInsets.symmetric(vertical: 7.5);
//             },
//           ),
//           shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
//             (Set<MaterialState> states) {
//               return const StadiumBorder();
//             },
//           ),
//         ),
//       ),
//       errorColor: AppColors.darkError,
//       floatingActionButtonTheme: const FloatingActionButtonThemeData(
//         backgroundColor: AppColors.cromaticGrey,
//         foregroundColor: Colors.black,
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5),
//           borderSide: BorderSide.none,
//         ),
//         errorBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8)),
//           borderSide: BorderSide(color: AppColors.darkError, width: 2),
//         ),
//         errorStyle:
//             TextStyles.bodyTextSmall.copyWith(color: AppColors.darkError),
//         focusedErrorBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8)),
//           borderSide: BorderSide(color: AppColors.darkError, width: 2),
//         ),
//         errorMaxLines: 2,
//         fillColor: AppColors.darkAlice,
//         filled: true,
//         focusedBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8)),
//           borderSide: BorderSide(
//             color: AppColors.darkPrimaryColor,
//             width: 2,
//           ),
//         ),
//         counterStyle: TextStyles.bodyTextSmall.copyWith(
//           color: AppColors.whiteMediumEmphasisColor,
//         ),
//         hintStyle: TextStyles.bodyTextLarge.copyWith(
//           color: AppColors.whiteMediumEmphasisColor,
//         ),
//         //suffixIconColor: AppColors.whiteMediumEmphasisColor,
//       ),
//       primaryColor: AppColors.darkPrimaryColor,
//       progressIndicatorTheme: const ProgressIndicatorThemeData(
//         color: AppColors.darkPrimaryColor,
//       ),
//       radioTheme: RadioThemeData(
//         fillColor: MaterialStateProperty.resolveWith<Color?>(
//           (Set<MaterialState> states) {
//             if (states.contains(MaterialState.selected)) {
//               return AppColors.darkPrimaryColor;
//             }
//             return AppColors.whiteMediumEmphasisColor;
//           },
//         ),
//       ),
//       scaffoldBackgroundColor: AppColors.darkBackgroundColor,
//       snackBarTheme: SnackBarThemeData(
//         backgroundColor: AppColors.whiteHighEmphasisColor,
//         contentTextStyle: TextStyles.bodyTextSmall.copyWith(
//           color: Colors.black,
//         ),
//       ),
//       textSelectionTheme: const TextSelectionThemeData(
//         cursorColor: AppColors.mischka,
//       ),
//       textTheme: TextTheme(
//         subtitle1: TextStyles.bodyTextLarge.copyWith(
//           color: AppColors.whiteHighEmphasisColor,
//         ),
//         bodyText2: TextStyles.bodyTextLarge.copyWith(
//           color: AppColors.whiteHighEmphasisColor,
//         ),
//       ),
//       toggleableActiveColor: AppColors.darkPrimaryColor,
//     );
//   }
// }
