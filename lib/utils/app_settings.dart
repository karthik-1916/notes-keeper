import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  SharedPreferences prefs;
  final String sortByAscKey = 'sort';
  final String showAsGridKey = 'grid';
  final String showListByKey = 'showListBy';
  bool _sortByAsc;
  bool _showAsGridView;
  int _showListBy;

  AppSettings() {
    _sortByAsc = false;
    _showAsGridView = false;
    _showListBy = 0;
    _getSortByAsc();
    _getShowAsGrid();
    _getShowListBy();
  }

  //----------------------Getters for app settings-------------------------------//

  /// returns sortByAsc Value used in sorting notes by ascendig or descendind order.
  ///
  /// if true sort the  note by Ascending.
  ///
  /// if false sort the note by descending.
  bool get sortByAsc => _sortByAsc;

  /// returns showAsGridValue value used to show notes as Staggered Grid view.
  ///
  /// if true Staggered Grid View.
  ///
  /// if false Normal List View.
  bool get showAsGridView => _showAsGridView;

  ///Returns showListBy Value used in showing list by title, created date or last edited.
  ///
  //////default value will be 1.
  ///
  ///Value => 0 Shows List by Title.
  ///
  ///Value => 1 Shows List by Created Date.
  ///
  ///Value => 2 Show List by Last Edited.
  int get showListByValue => _showListBy;

  ///Initializes the preference if its equal to null.
  ///
  _initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  ///toggles the sortByAsc true and false and set it to preference.
  ///
  toggleSortByAsc() {
    _sortByAsc = !_sortByAsc;
    _setSortByAsc();
  }

  ///gets the sortByAsc value from preference.
  ///
  _getSortByAsc() async {
    await _initPrefs();
    _sortByAsc = prefs.getBool(sortByAscKey) ?? false;
  }

  ///sets the sortByAsc value to preference.
  ///
  _setSortByAsc() async {
    await _initPrefs();
    prefs.setBool(sortByAscKey, _sortByAsc);
  }

  ///toggles the showAsGrid true and false and set it to preference.
  ///
  toggleShowAsGrid() {
    _showAsGridView = !_showAsGridView;
    _setShowAsGrid();
  }

  ///gets the showAsGrid value from preference.
  ///
  _getShowAsGrid() async {
    await _initPrefs();
    _showAsGridView = prefs.getBool(showAsGridKey) ?? false;
  }

  ///sets the showAsGrid value to preference.
  ///
  _setShowAsGrid() async {
    await _initPrefs();
    prefs.setBool(showAsGridKey, _showAsGridView);
  }

  ///Changes showListByValue.
  ///
  ///The [value] argument is required
  changeShowListByValue(int value) {
    _showListBy = value;
    _setShowListBy();
  }

  ///gets showListByValue from preference.
  ///

  _getShowListBy() async {
    await _initPrefs();
    _showListBy = prefs.getInt(showListByKey) ?? 1;
  }

  ///set showListBy value to preference.
  ///
  _setShowListBy() async {
    await _initPrefs();
    prefs.setInt(showListByKey, _showListBy);
  }
}
