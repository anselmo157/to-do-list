import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/data/controllers/main_controller.dart';
import 'package:to_do_list/app/data/models/task_model.dart';
import 'package:to_do_list/app/data/services/auth_service.dart';
import 'package:to_do_list/app/ui/pages/add_task_page.dart';
import 'package:to_do_list/app/ui/pages/edit_task_page.dart';
import 'package:to_do_list/app/ui/pages/home_page.dart';
import 'package:to_do_list/app/ui/pages/login_page.dart';
import 'package:to_do_list/app/ui/pages/register_page.dart';
import 'package:to_do_list/app/ui/pages/view_task_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => MainController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const HomePage(),
          '/add-task': (context) {
            final args =
                ModalRoute.of(context)?.settings.arguments as MainController;
            return AddTaskPage(mainController: args);
          },
          '/edit-task': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as List;
            return EditTaskPage(
              mainController: args[0],
              task: args[1],
            );
          },
          '/view-task': (context) {
            final args =
                ModalRoute.of(context)?.settings.arguments as TaskModel;
            return ViewTaskPage(task: args);
          },
        },
      ),
    );
  }
}
