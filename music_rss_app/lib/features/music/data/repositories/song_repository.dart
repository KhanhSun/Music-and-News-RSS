import '../../../../core/services/supabase_service.dart';
import '../../models/song_model.dart';

class SongRepository {
  Future<List<SongModel>> getSongs() async {
    final response = await SupabaseService.client
        .from('songs')
        .select()
        .order('created_at');

    return response.map<SongModel>((song) => SongModel.fromJson(song)).toList();
  }
}
