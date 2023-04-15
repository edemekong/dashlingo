import 'package:dashlingo/UI/components/scaffold.dart';
import 'package:dashlingo/UI/screens/account_setup/account_setup_state.dart';
import 'package:dashlingo/UI/screens/account_setup/pages/select_interest.dart';
import 'package:dashlingo/UI/theme/spaces.dart';
import 'package:dashlingo/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AccountSetup extends StatelessWidget {
  const AccountSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AccountSetupState(context),
      child: AppScaffold(
        body: Builder(builder: (context) {
          return ResponsiveBuilder(
            builder: (context, info) {
              final state = context.read<AccountSetupState>();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpaces.elementSpacing * 0.5),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpaces.elementSpacing * 0.5),
                    child: CloseButton(
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: AppSpaces.elementSpacing),
                  Expanded(
                    child: PageView(
                      children: List.generate(
                        state.accountSetupPages.length,
                        (index) {
                          final AccountSetupPages page = state.accountSetupPages.keys.toList()[index];
                          final pageData = state.accountSetupPages[page]!;

                          return SelectUserInterest(
                            info: info,
                            pageData: pageData,
                            title: (() {
                              switch (page) {
                                case AccountSetupPages.purpose:
                                  return 'How can dashlingo help you?';
                                case AccountSetupPages.level:
                                  return 'What is your current level?';
                                case AccountSetupPages.language:
                                  return 'Language to spotlight on?';
                                default:
                                  return '';
                              }
                            })(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
