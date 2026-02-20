import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://gzpbwccsfeqgyamluhtg.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd6cGJ3Y2NzZmVxZ3lhbWx1aHRnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjcwODIxMTEsImV4cCI6MjA4MjY1ODExMX0.0CvBinkREcM22QR_dffBiSJCzoZ9R9EcA_OySn8GAjA',
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}