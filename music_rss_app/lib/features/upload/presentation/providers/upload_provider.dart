import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/upload_service.dart';

final uploadServiceProvider = Provider((ref) => UploadService());

final uploadLoadingProvider = StateProvider<bool>((ref) => false);
