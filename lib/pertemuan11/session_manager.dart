import 'package:shared_preferences/shared_preferences.dart'; // [cite: 81]

class SessionManager { // [cite: 82]
  static const String _isLoggedInKey = 'isLoggedIn'; // [cite: 83]
  static const String _usernameKey = 'username'; // [cite: 83]

  // Menyimpan data sesi // [cite: 84]
  Future<void> saveSession(String username) async { // [cite: 85]
    SharedPreferences prefs = await SharedPreferences.getInstance(); // [cite: 87]
    await prefs.setBool(_isLoggedInKey, true); // [cite: 87]
    await prefs.setString(_usernameKey, username); // [cite: 88]
  } // [cite: 86]

  // Memeriksa apakah pengguna sudah login // [cite: 89]
  Future<bool> isLoggedIn() async { // [cite: 90]
    SharedPreferences prefs = await SharedPreferences.getInstance(); // [cite: 92]
    return prefs.getBool(_isLoggedInKey) ?? false; // [cite: 93]
  } // [cite: 91]

  // Mendapatkan username // [cite: 94]
  Future<String?> getUsername() async { // [cite: 95]
    SharedPreferences prefs = await SharedPreferences.getInstance(); // [cite: 97]
    return prefs.getString(_usernameKey); // [cite: 98]
  } // [cite: 96]

  // Menghapus data sesi // [cite: 99]
  Future<void> clearSession() async { // [cite: 100]
    SharedPreferences prefs = await SharedPreferences.getInstance(); // [cite: 101]
    await prefs.remove(_isLoggedInKey); // [cite: 102]
    await prefs.remove(_usernameKey); // [cite: 103]
  } // [cite: 104]
}