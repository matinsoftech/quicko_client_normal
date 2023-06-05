import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/login.view_model.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';

import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/login.i18n.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.required = false, Key key}) : super(key: key);

  final bool required;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            return !widget.required;
          },
          child: BasePage(
            showLeadingAction: !widget.required,
            showAppBar: !widget.required,
            appBarColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                FlutterIcons.arrow_left_fea,
                color: AppColor.primaryColor,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            elevation: 0,
            body: SafeArea(
              top: true,
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(bottom: context.mq.viewInsets.bottom),
                child: VStack(
                  [
                    Image.asset(
                      AppImages.logoOnly,
                    ).hOneForth(context).centered(),
                    //
                    VStack(
                      [
                        //
                        "Welcome".i18n.text.xl2.semiBold.make(),
                        "Login to continue".i18n.text.light.make(),

                        //otp form
                        Visibility(
                          visible: model.otpLogin,
                          child: Form(
                            key: model.formKey,
                            child: VStack(
                              [
                                //
                                HStack(
                                  [
                                    CustomTextFormField(
                                      prefixIcon: HStack(
                                        [
                                          //icon/flag
                                          Flag(
                                            model.selectedCountry.countryCode,
                                            width: 20,
                                            height: 20,
                                          ),
                                          UiSpacer.horizontalSpace(space: 5),
                                          //text
                                          ("+" +
                                                  model.selectedCountry
                                                      .phoneCode)
                                              .text
                                              .make(),
                                        ],
                                      ).px8().onInkTap(
                                          model.showCountryDialPicker),
                                      labelText: "Phone".i18n,
                                      hintText: "Phone".i18n,
                                      keyboardType: TextInputType.phone,
                                      textEditingController: model.phoneTEC,
                                      validator: FormValidator.validatePhone,
                                    ).expand(),
                                  ],
                                ).py12(),
                                //

                                CustomButton(
                                  title: "Login".i18n,
                                  loading: model.isBusy,
                                  onPressed: model.processOTPLogin,
                                ).centered().py12(),
                                //email login
                                "Login with Email"
                                    .i18n
                                    .text
                                    .semiBold
                                    .makeCentered()
                                    .py12()
                                    .onInkTap(model.toggleLoginType),
                                //register
                                "OR".i18n.text.light.makeCentered(),
                                "Create An Account"
                                    .i18n
                                    .text
                                    .semiBold
                                    .makeCentered()
                                    .py12()
                                    .onInkTap(model.openRegister),
                              ],
                              crossAlignment: CrossAxisAlignment.end,
                            ),
                          ).py20(),
                        ),

                        //email form
                        Visibility(
                          visible: !model.otpLogin,
                          child: Form(
                            key: model.formKey,
                            child: VStack(
                              [
                                //
                                CustomTextFormField(
                                  prefixIcon: HStack(
                                    [
                                      //icon/flag
                                      Flag(
                                        model.selectedCountry.countryCode,
                                        width: 20,
                                        height: 20,
                                      ),
                                      UiSpacer.horizontalSpace(space: 5),
                                      //text
                                      ("+" +
                                          model.selectedCountry
                                              .phoneCode)
                                          .text
                                          .make(),
                                    ],
                                  ).px8().onInkTap(
                                      model.showCountryDialPicker),
                                  labelText: "Phone".i18n,
                                  hintText: "Phone".i18n,
                                  keyboardType: TextInputType.phone,
                                  textEditingController: model.phoneTEC,
                                  validator: FormValidator.validatePhone,
                                ).py12(),

                                CustomTextFormField(
                                  prefixIcon: Icon(Icons.lock),

                                  labelText: "Password".i18n,
                                  hintText: "Password".i18n,
                                  obscureText: true,
                                  textEditingController: model.passwordTEC,
                                  validator: FormValidator.validatePassword,
                                ).py12(),

                                //

                                HStack(
                                  [
                                    "Forgot your password?"
                                        .i18n
                                        .text
                                        .make(),
                                        
                                    " Recover"
                                        .i18n
                                        .text
                                        .color(AppColor.primaryColor)
                                        .semiBold
                                        .make()
                                        .onInkTap(
                                      model.openForgotPassword,
                                    ),
                                  ]
                                ).centered().py20(),
                                //
                                CustomButton(
                                  title: "Login".i18n,
                                  loading: model.isBusy,
                                  onPressed: model.processLogin,
                                  shapeRadius: 32,
                                ).centered().py12(),
//otp login
//                                 "Login with Phone Number"
//                                     .i18n
//                                     .text
//                                     .semiBold
//                                     .makeCentered()
//                                     .py12()
//                                     .onInkTap(model.toggleLoginType),
//                                 //register
//                                 "OR".i18n.text.light.makeCentered(),
                                HStack(
                                    [
                                      "Don't have an account?"
                                          .i18n
                                          .text
                                          .make(),

                                      " Sign up"
                                          .i18n
                                          .text
                                          .color(AppColor.primaryColor)
                                          .semiBold
                                          .make()
                                          .onInkTap(model.openRegister),
                                    ]
                                ).centered().py20(),
                              ],
                              crossAlignment: CrossAxisAlignment.end,
                            ),
                          ).py20(),
                        ),
                      ],
                    ).wFull(context).p20(),
                    //
                  ],
                ).scrollVertical(),
              ),
            ),
          ),
        );
      },
    );
  }
}
