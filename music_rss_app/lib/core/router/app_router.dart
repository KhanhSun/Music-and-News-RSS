import 'package:go_router/go_router.dart';
import '../../features/upload/presentation/screens/upload_screen.dart';
import '../../features/home/home_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/upload', builder: (context, state) => const UploadScreen()),
  ],
);
