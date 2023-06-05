import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/service_booking_summary.vm.dart';
import 'package:fuodz/view_models/service_details.vm.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/services.i18n.dart';

class ServiceDetailsBottomSheet extends StatelessWidget {
  const ServiceDetailsBottomSheet(this.vm, {Key key}) : super(key: key);
  final ServiceDetailsViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //hour selection
        Visibility(
          visible: vm.service.isPerHour,
          child: HStack(
            [
              //
              "Days".i18n.text.medium.xl.make().expand(),
              VxStepper(
                defaultValue: 1,
                min: 1,
                max: 24,
                actionButtonColor: AppColor.primaryColor,
                disableInput: true,
                onChange: (value) {
                  vm.service.selectedQty = value;
                  vm.notifyListeners();
                },
              ),
            ],
          ),
        ),

        Visibility(
          visible: vm.service.isPerHour,
          child: UiSpacer.verticalSpace(),
        ),

        //
        ViewModelBuilder<ServiceBookingSummaryViewModel>.reactive(
          viewModelBuilder: () =>
              ServiceBookingSummaryViewModel(context, vm.service),
          builder: (context, vm, child) {
            return CustomButton(
              title: "Submit your request".i18n,
              onPressed: vm.placeOrder,
            );
          },
        )
      ],
    )
        .p20()
        .box
        .shadowSm
        .color(context.backgroundColor)
        .topRounded(value: 20)
        .make();
  }
}
