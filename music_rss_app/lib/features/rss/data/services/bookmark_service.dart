import '../../../../core/services/supabase_service.dart';

class BookmarkService {
  Future<void> saveBookmark({
    required String title,
    required String link,
    required String imageUrl,
  }) async {
    await SupabaseService.client.from('bookmarks').insert({
      'title': title,
      'link': link,
      'image_url': imageUrl,
    });
  }
}
