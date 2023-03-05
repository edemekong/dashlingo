import 'package:dashlingo/components/base_state.dart';
import 'package:dashlingo/screens/account_setup/components/contents.dart';
import 'package:flutter/material.dart';

enum AccountSetupPages { purpose, language, level }

class AccountSetupState extends BaseState {
  Map<AccountSetupPages, List<UserInterest>> accountSetupPages = {
    AccountSetupPages.purpose: purposes,
    AccountSetupPages.language: languages,
    AccountSetupPages.level: levels,
  };

  AccountSetupState(BuildContext context);
}
