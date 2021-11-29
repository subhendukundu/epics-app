import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  getAllNotifications(String userUid) {
    return Supabase.instance.client
        .from('notifications')
        .select('*,user_from(*),posts(*)')
        .eq('user_to', userUid)
        .order('created_on', ascending: false)
        .execute();
  }
}
