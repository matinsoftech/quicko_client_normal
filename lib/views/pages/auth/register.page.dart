import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/register.view_model.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/register.i18n.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return BasePage(
          showLeadingAction: true,
          showAppBar: true,
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
                      "Join Us".i18n.text.xl2.semiBold.make(),
                      "Create an account now".i18n.text.light.make(),

                      //form
                      Form(
                        key: model.formKey,
                        child: VStack(
                          [
                            //
                            CustomTextFormField(
                              prefixIcon: Icon(Icons.text_fields),
                              labelText: "Name".i18n,
                              hintText: "Name".i18n,
                              textEditingController: model.nameTEC,
                              validator: FormValidator.validateName,
                            ).py12(),
                            //
                            // CustomTextFormField(
                            //   prefixIcon: Icon(Icons.email),

                            //   labelText: "Email",
                            //   hintText: "Email",

                            //   keyboardType: TextInputType.emailAddress,
                            //   textEditingController: model.emailTEC,
                            //   validator: FormValidator.validateEmail,
                            // ).py12(),
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
                                      ("+" + model.selectedCountry.phoneCode)
                                          .text
                                          .make(),
                                    ],
                                  ).px8().onInkTap(model.showCountryDialPicker),
                                  labelText: "Phone".i18n,
                                  hintText: "Phone".i18n,
                                  keyboardType: TextInputType.phone,
                                  textEditingController: model.phoneTEC,
                                  validator: FormValidator.validatePhone,
                                ).expand(),
                              ],
                            ).py12(),
                            //
                            CustomTextFormField(
                              prefixIcon: Icon(Icons.lock),
                              labelText: "Password".i18n,
                              hintText: "Password".i18n,
                              obscureText: true,
                              textEditingController: model.passwordTEC,
                              validator: FormValidator.validatePassword,
                            ).py12(),

                            CustomTextFormField(
                              prefixIcon: Icon(Icons.lock),
                              labelText: "Confirm Password".i18n,
                              hintText: "Confirm Password".i18n,
                              obscureText: true,
                              textEditingController: model.confirmPasswordTEC,
                              validator: FormValidator.validateConfirmPassword,
                            ).py12(),
                            //
                            AppStrings.enableReferSystem
                                ? CustomTextFormField(
                                    labelText: "Referral Code(optional)".i18n,
                                    hintText: "Referral Code(optional)".i18n,
                                    textEditingController:
                                        model.referralCodeTEC,
                                  ).py12()
                                : UiSpacer.emptySpace(),

                            //terms
                            HStack(
                              [
                                Checkbox(
                                  value: model.agreed,
                                  onChanged: (value) {
                                    model.agreed = value;
                                    model.notifyListeners();
                                  },
                                ),
                                //
                                "I agree with".i18n.text.make(),
                                UiSpacer.horizontalSpace(space: 2),
                                "Terms & Conditions"
                                    .i18n
                                    .text
                                    .color(AppColor.primaryColor)
                                    .bold
                                    .underline
                                    .make()
                                    .onInkTap(model.openTerms)
                                    .expand(),
                              ],
                            ),

                            //
                            CustomButton(
                              title: "Create Account".i18n,
                              loading: model.isBusy,
                              onPressed: model.processRegister,
                              shapeRadius: 32,
                            ).centered().py12(),

                            //register
                            "OR".i18n.text.light.makeCentered(),
                            "Already have an Account"
                                .i18n
                                .text
                                .semiBold
                                .makeCentered()
                                .py12()
                                .onInkTap(model.openLogin),
                          ],
                          crossAlignment: CrossAxisAlignment.end,
                        ),
                      ).py20(),
                    ],
                  ).wFull(context).p16(),

                  //
                ],
              ).scrollVertical(),
            ),
          ),
        );
      },
    );
  }
}
