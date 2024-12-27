import 'package:flutter/material.dart';
import 'package:haajaree/screens/authentication/enter_detail/enter_detail.dart';
import 'package:haajaree/screens/authentication/get_started/create_account.dart';
import 'package:haajaree/screens/authentication/login/login.dart';
import 'package:haajaree/screens/main/mainpage.dart';
import 'package:haajaree/screens/authentication/welcome/welcome.dart';
import 'package:haajaree/routes/routes_names.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeScreen:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
      case createAccountScreen:
        return MaterialPageRoute(
          builder: (context) => const CreateAccount(),
        );
      case mainPage:
        return MaterialPageRoute(
          builder: (context) => const Mainpage(),
        );
      case enterDetailScreen:
        return MaterialPageRoute(
          builder: (context) => const EnterDetail(),
        );
      default:
      // MaterialApp(
      //   theme: ThemeData(scaffoldBackgroundColor: const Color(bgColor)),
      //   debugShowCheckedModeBanner: false,
      //   home: Scaffold(
      //     body: Center(
      //       child: elementRegluar(text: 'Wrong Route Location', context: BuildContext),
      //     ),
      //   ),
      // );
    }
    return null;
  }

  // static Route _modalSheetRoute({
  //   required BuildContext context,
  //   required WidgetBuilder builder,
  // }) {
  //   return MaterialWithModalsPageRoute(
  //     builder: (context) {
  //       Future.delayed(Duration.zero,() => showModalBottomSheet(context: context, builder: builder));
  //     },
  //   );
//   return MaterialWithModalsPageRoute(
//     builder: (context) {
//       Future.delayed(
//         Duration.zero,
//         () => showModalBottomSheet(
//           context: context,
//           isScrollControlled: true,
//           builder: builder,
//         ),
//       );
//       return const SizedBox.shrink(); // Return an empty widget as a placeholder.
//     },
//   );
}
// }
