import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/supabase_service.dart';

final realtimeSongsProvider = StreamProvider((ref) {
  return SupabaseService.client.from('songs').stream(primaryKey: ['id']);
});
