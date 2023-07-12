import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/buttons/custom_text_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/register.i18n.dart';

class AccountVerificationEntry extends StatefulWidget {
  const AccountVerificationEntry({
    this.onSubmit,
    this.onResendCode,
    this.vm,
    Key key,
    this.phone = "",
    this.password,
  }) : super(key: key);

  final Function(String, String) onSubmit;
  final Function onResendCode;
  final MyBaseViewModel vm;
  final String phone;
  final String password;

  @override
  _AccountVerificationEntryState createState() =>
      _AccountVerificationEntryState();
}

class _AccountVerificationEntryState extends State<AccountVerificationEntry> {
  TextEditingController pinTEC = new TextEditingController();
  String smsCode;
  int resendSecs = 5;
  int maxResendSeconds = 30;
  bool loading = false;
  String password;

  @override
  void initState() {
    super.initState();
    //
    startCountDown();
  }

  @override
  Widget build(BuildContext context) {
    //

    return BasePage(
      showAppBar: true,
      showLeadingAction: true,
      appBarColor: Colors.transparent,
      elevation: 0,
      leading: Icon(
        FlutterIcons.arrow_left_fea,
        color: AppColor.primaryColor,
      ).onInkTap(() {
        context.pop();
      }),
      body: VStack(
        [
          //
          Image.asset(
            AppImages.otpImage,
            width: 200,
            height: 200,
          ).centered(),
          //
          "Verify your phone number".i18n.text.bold.xl2.makeCentered(),
          "Enter otp sent to your provided phone number"
              .i18n
              .text
              .makeCentered(),
          "(${widget.phone})".text.lg.semiBold.makeCentered().py4(),
          //pin code
          PinCodeTextField(
            appContext: context,
            length: 6,
            obscureText: false,
            keyboardType: TextInputType.number,
            animationType: AnimationType.fade,
            textStyle: context.textTheme.bodyText1.copyWith(fontSize: 20),
            controller: pinTEC,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              fieldHeight: context.percentWidth * (100 / 8),
              fieldWidth: context.percentWidth * (100 / 8),
              activeFillColor: AppColor.primaryColor,
              selectedColor: AppColor.primaryColor,
              inactiveColor: AppColor.accentColor,
            ),
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: false,
            onCompleted: (pin) {
              print("Completed");
              print("Pin ==> $pin");
              smsCode = pin;
            },
            onChanged: (value) {
              smsCode = value;
            },
          ),
          "Provide your new password".i18n.text.bold.xl2.makeCentered(),
          "Enter your new password".i18n.text.makeCentered(),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.green),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.green),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.green),
              ),
              fillColor: Colors.green.withOpacity(0.1),
              filled: true,
            ),
            onChanged: (value) {
              password = value;
            },
          ),
          SizedBox(
            height: 20,
          ),

          //submit
          CustomButton(
            title: "Verify".i18n,
            loading: widget.vm.busy(widget.vm.firebaseVerificationId),
            onPressed: () {
              //
              if (smsCode == null || smsCode.length != 6 || password == null) {
                widget.vm.toastError("Please fill everything".i18n);
              } else {
                widget.onSubmit(smsCode, password);
              }
            },
          ),

          //
          Visibility(
            visible: widget.onResendCode != null,
            child: HStack(
              [
                "Didn't receive the code?".i18n.text.make(),
                Visibility(
                  visible: resendSecs > 0,
                  child: "($resendSecs)"
                      .text
                      .bold
                      .color(AppColor.primaryColorDark)
                      .make()
                      .px4(),
                ),
                Visibility(
                  visible: resendSecs == 0,
                  child: CustomTextButton(
                    loading: loading,
                    title: "Resend".i18n,
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await widget.onResendCode();
                      setState(() {
                        loading = false;
                        resendSecs = maxResendSeconds;
                      });
                      //
                      startCountDown();
                    },
                  ),
                ),
              ],
              crossAlignment: CrossAxisAlignment.center,
              alignment: MainAxisAlignment.center,
            ).py12(),
          ),
        ],
      ).p20().hFull(context),
    );
  }

  //
  void startCountDown() async {
    //
    if (resendSecs > 0) {
      setState(() {
        resendSecs -= 1;
      });

      //
      await Future.delayed(1.seconds);
      startCountDown();
    }
  }
}
