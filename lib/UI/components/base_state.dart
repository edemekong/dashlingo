import 'package:flutter/material.dart';

enum ActionState { initial, loading, disabled, loaded }

class BaseState extends ChangeNotifier {
  ActionState actionState = ActionState.disabled;

  bool _mounted = true;

  bool get isLoading => actionState == ActionState.loading;
  bool get isDisabled => [ActionState.loading, ActionState.disabled].contains(actionState);
  bool get loaded => [ActionState.initial, ActionState.loaded].contains(actionState);

  set state(ActionState value) {
    actionState = value;
    if (_mounted) notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  void setLoading() {
    state = ActionState.loading;
  }

  void unsetLoading([ActionState? to]) {
    state = to ?? ActionState.initial;
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}
