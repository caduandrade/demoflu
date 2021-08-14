typedef OnButtonClick = void Function(int buttonIndex);

class ExampleMenuNotifier {
  OnButtonClick? _onButtonClick;

  void registerButtonClick(OnButtonClick onClick) {
    _onButtonClick = onClick;
  }

  void unregisterAll() {
    _onButtonClick = null;
  }

  void notifyButtonClick(int id) {
    if (_onButtonClick != null) {
      _onButtonClick!(id);
    }
  }
}
