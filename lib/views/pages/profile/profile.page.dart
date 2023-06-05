import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/profile.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/cards/profile.card.dart';
import 'package:fuodz/widgets/menu_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/profile.i18n.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return BasePage(
            body: VStack([
              Container(
                color: AppColor.primaryColor,
                width: 800,
                height: 80,
                child: "ACCOUNT & SETTINGS"
                    .i18n
                    .text
                    .xl2
                    .semiBold
                    .white
                    .make()
                    .centered(),
              ),
              VStack([
                //profile card
                ProfileCard(model).py(12),

                //menu
                VxBox(
                  child: VStack(
                    [
                      MenuItem(
                        title: "Version".i18n,
                        suffix: model.appVersionInfo.text.make(),
                        topDivider: false,
                        divider: false,
                        iconData: Icons.account_tree_outlined,
                      ),

                      //
                      MenuItem(
                        title: "Privacy Policy".i18n,
                        onPressed: model.openPrivacyPolicy,
                        topDivider: false,
                        divider: false,
                        iconData: Icons.privacy_tip_rounded,
                      ),
                      //
                      MenuItem(
                        title: "Terms & Conditions".i18n,
                        onPressed: model.openTerms,
                        topDivider: false,
                        divider: false,
                        iconData: Icons.privacy_tip,
                      ),
                      //
                      MenuItem(
                        title: "Contact Us".i18n,
                        onPressed: model.openContactUs,
                        topDivider: false,
                        divider: false,
                        iconData: Icons.message_rounded,
                      ),
                      model.isAuthenticated()
                          ? MenuItem(
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: model.logoutPressed,
                              divider: false,
                              iconData: Icons.logout,
                            )
                          : SizedBox(),
                      // "Settings".text.xl.make().pLTRB(20, 15, 0, 15),

                      //
                      // MenuItem(
                      //   title: "Notifications".i18n,
                      //   onPressed: model.openNotification,
                      //   topDivider: false,
                      //   divider: false,
                      //   iconData: Icons.notifications,
                      // ),
                      //
                      // //
                      // MenuItem(
                      //   title: "Rate & Review".i18n,
                      //   onPressed: model.openReviewApp,
                      //   topDivider: false,
                      //   divider: false,
                      //   iconData: Icons.star,
                      // ),

                      //
                    ],
                  ),
                )
                    .border(color: Theme.of(context).cardColor)
                    .color(Theme.of(context).cardColor)
                    // .shadow
                    .roundedSM
                    .make(),

                //
                // "Copyright ©%s %s all right reserved"
                //     .i18n
                //     .fill([
                //   "${DateTime.now().year}",
                //   AppStrings.companyName,
                // ])
                //     .text
                //     .center
                //     .sm
                //     .makeCentered()
                //     .py20(),
              ]).px8().scrollVertical(),
              SizedBox(
                height: 20,
              )
            ]).scrollVertical().backgroundColor(Colors.white),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
