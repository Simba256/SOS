import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  /// Helper to get user-specific SharedPreferences key
  String _userKey(String key) => '${key}_$currentUserUid';

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    // Note: User-specific data is loaded via loadUserData() after login
  }

  /// Load user-specific data after login.
  /// Name is loaded from SharedPreferences, UserImage from Firestore.
  void loadUserData() {
    if (currentUserUid.isNotEmpty) {
      _safeInit(() {
        _Name = prefs.getString(_userKey('ff_Name')) ?? '';
      });
      // UserImage (photo URL) is loaded from Firestore via currentUserDocument
      // It will be available once authenticatedUserStream emits the user document
      _safeInit(() {
        _UserImage = currentUserDocument?.photoUrl ?? '';
      });
      notifyListeners();
    }
  }

  /// Reload user image from Firestore (call after authenticatedUserStream updates).
  void reloadUserImage() {
    final photoUrl = currentUserDocument?.photoUrl ?? '';
    if (photoUrl != _UserImage) {
      _UserImage = photoUrl;
      notifyListeners();
    }
  }

  /// Clear in-memory user data on logout.
  void clearUserData() {
    _Name = '';
    _UserImage = '';
    _contacts = [];
    _FinalContacts = [];
    notifyListeners();
  }

  void update(VoidCallback callback) {
    callback();
    if (kDebugMode) {
      print(
          '[APP_STATE] notifyListeners() called, currentSOSState=$_currentSOSState at ${DateTime.now().millisecondsSinceEpoch}');
    }
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _Reload = false;
  bool get Reload => _Reload;
  set Reload(bool value) {
    _Reload = value;
  }

  List<String> _testNumbers = ['[\"03269920987\", \"03342153065\"]'];
  List<String> get testNumbers => _testNumbers;
  set testNumbers(List<String> value) {
    _testNumbers = value;
  }

  void addToTestNumbers(String value) {
    testNumbers.add(value);
  }

  void removeFromTestNumbers(String value) {
    testNumbers.remove(value);
  }

  void removeAtIndexFromTestNumbers(int index) {
    testNumbers.removeAt(index);
  }

  void updateTestNumbersAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    testNumbers[index] = updateFn(_testNumbers[index]);
  }

  void insertAtIndexInTestNumbers(int index, String value) {
    testNumbers.insert(index, value);
  }

  String _UserLocation = '';
  String get UserLocation => _UserLocation;
  set UserLocation(String value) {
    _UserLocation = value;
  }

  /// User's Full Name
  String _Name = '';
  String get Name => _Name;
  set Name(String value) {
    _Name = value;
    if (currentUserUid.isNotEmpty) {
      prefs.setString(_userKey('ff_Name'), value);
    }
  }

  /// User's profile image URL (stored in Firestore, not SharedPreferences)
  String _UserImage = '';
  String get UserImage => _UserImage;
  set UserImage(String value) {
    _UserImage = value;
    // Note: UserImage is persisted in Firestore (users/{uid}.photo_url),
    // not in SharedPreferences. The upload_profile_image action handles Firestore update.
  }

  List<ContactStruct> _contacts = [];
  List<ContactStruct> get contacts => _contacts;
  set contacts(List<ContactStruct> value) {
    _contacts = value;
  }

  void addToContacts(ContactStruct value) {
    contacts.add(value);
  }

  void removeFromContacts(ContactStruct value) {
    contacts.remove(value);
  }

  void removeAtIndexFromContacts(int index) {
    contacts.removeAt(index);
  }

  void updateContactsAtIndex(
    int index,
    ContactStruct Function(ContactStruct) updateFn,
  ) {
    contacts[index] = updateFn(_contacts[index]);
  }

  void insertAtIndexInContacts(int index, ContactStruct value) {
    contacts.insert(index, value);
  }

  bool _refresh = false;
  bool get refresh => _refresh;
  set refresh(bool value) {
    _refresh = value;
  }

  List<FinalContactStruct> _FinalContacts = [];
  List<FinalContactStruct> get FinalContacts => _FinalContacts;
  set FinalContacts(List<FinalContactStruct> value) {
    _FinalContacts = value;
  }

  void addToFinalContacts(FinalContactStruct value) {
    FinalContacts.add(value);
  }

  void removeFromFinalContacts(FinalContactStruct value) {
    FinalContacts.remove(value);
  }

  void removeAtIndexFromFinalContacts(int index) {
    FinalContacts.removeAt(index);
  }

  void updateFinalContactsAtIndex(
    int index,
    FinalContactStruct Function(FinalContactStruct) updateFn,
  ) {
    FinalContacts[index] = updateFn(_FinalContacts[index]);
  }

  void insertAtIndexInFinalContacts(int index, FinalContactStruct value) {
    FinalContacts.insert(index, value);
  }

  bool _isModeChanged = false;
  bool get isModeChanged => _isModeChanged;
  set isModeChanged(bool value) {
    _isModeChanged = value;
  }

  // Synchronized SOS state
  bool _currentSOSState = false;
  bool get currentSOSState => _currentSOSState;
  set currentSOSState(bool value) {
    _currentSOSState = value;
  }

  bool _isTorchEnabled = false;
  bool get isTorchEnabled => _isTorchEnabled;
  set isTorchEnabled(bool value) {
    _isTorchEnabled = value;
  }

  bool _isAudioEnabled = false;
  bool get isAudioEnabled => _isAudioEnabled;
  set isAudioEnabled(bool value) {
    _isAudioEnabled = value;
  }

  final _getEmergencyContactsManager =
      FutureRequestManager<List<SearchContactsRow>>();
  Future<List<SearchContactsRow>> getEmergencyContacts({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<SearchContactsRow>> Function() requestFn,
  }) =>
      _getEmergencyContactsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGetEmergencyContactsCache() => _getEmergencyContactsManager.clear();
  void clearGetEmergencyContactsCacheKey(String? uniqueKey) =>
      _getEmergencyContactsManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
