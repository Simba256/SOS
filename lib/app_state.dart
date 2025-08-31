import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
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

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _Name = prefs.getString('ff_Name') ?? _Name;
    });
    _safeInit(() {
      _UserImage = prefs.getString('ff_UserImage') ?? _UserImage;
    });
  }

  void update(VoidCallback callback) {
    callback();
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
    prefs.setString('ff_Name', value);
  }

  /// User'sImage
  String _UserImage = '';
  String get UserImage => _UserImage;
  set UserImage(String value) {
    _UserImage = value;
    prefs.setString('ff_UserImage', value);
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
