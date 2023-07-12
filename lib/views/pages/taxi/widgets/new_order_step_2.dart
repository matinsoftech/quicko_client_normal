import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/taxi.vm.dart';
import 'package:fuodz/views/pages/service/widgets/service_discount_section.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/buttons/custom_text_button.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/vehicle_type.list_item.dart';
import 'package:measure_size/measure_size.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/taxi.i18n.dart';

class NewTaxiOrderStep2 extends StatelessWidget {
  NewTaxiOrderStep2(this.vm, {Key key}) : super(key: key);
  final TaxiViewModel vm;
  final TextEditingController _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _priceController.text = vm.total.toString();
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: MeasureSize(
        onChange: (size) {
          vm.updateGoogleMapPadding(height: size.height);
        },
        child: VStack(
          [
            //
            HStack(
              [
                //previous
                CustomTextButton(
                  padding: EdgeInsets.zero,
                  title: "Back".i18n,
                  onPressed: () => vm.closeOrderSummary(clear: false),
                ),
                UiSpacer.expandedSpace(),
                //cancel book
                CustomTextButton(
                  padding: EdgeInsets.zero,
                  title: "Cancel".i18n,
                  titleColor: Colors.red,
                  onPressed: vm.closeOrderSummary,
                ),
              ],
            ),
            //
            "Vehicle Type".i18n.text.semiBold.xl.make(),
            UiSpacer.verticalSpace(),
            //vehicle types
            CustomListView(
              scrollDirection: Axis.horizontal,
              dataSet: vm.vehicleTypes,
              isLoading: vm.busy(vm.vehicleTypes),
              itemBuilder: (context, index) {
                //
                final vehicleType = vm.vehicleTypes[index];
                //
                return VehicleTypeListItem(vm, vehicleType);
              },
            ).h(80),
            UiSpacer.verticalSpace(),
            //selected payment method
            "Payment".i18n.text.semiBold.xl.make(),
            UiSpacer.verticalSpace(space: 5),
            vm.busy(vm.paymentMethods)
                ? BusyIndicator().centered()
                : FormBuilderDropdown(
                    name: 'payment_method_id',
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    initialValue: vm.selectedPaymentMethod != null
                        ? vm.selectedPaymentMethod
                        : vm.paymentMethods?.first,
                    icon: vm.selectedPaymentMethod != null
                        ? CustomImage(
                            imageUrl: vm.selectedPaymentMethod.photo,
                            width: 20,
                            height: 20,
                          )
                        : Icon(
                            FlutterIcons.credit_card_fea,
                          ),
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)],
                    ),
                    items: vm.paymentMethods
                        .map(
                          (paymentMethod) => DropdownMenuItem(
                            value: paymentMethod,
                            child: Text('${paymentMethod.name}'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => vm.changeSelectedPaymentMethod(
                      value,
                      callTotal: false,
                    ),
                  ).px12().box.roundedSM.border().make(),
            UiSpacer.verticalSpace(),
            //discount section
            ServiceDiscountSection(vm, toggle: true),
            UiSpacer.verticalSpace(),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)              ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Your Offer Price",
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  UiSpacer.formVerticalSpace(space: 10),
                  // SizedBox(
                  //   height: 45,
                  //   child: TextFormField(
                  //     controller: _priceController,
                  //     keyboardType: TextInputType.number,
                  //     decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           width: 2,
                  //           color: Theme.of(context).primaryColor,
                  //         )
                  //       )
                  //     ),
                  //     onFieldSubmitted: (value) {
                  //       vm.calculateTotalAmount(double.parse(value));
                  //     },
                  //   ),
                  // )
                ],
              ),
            ),
            UiSpacer.verticalSpace(),
            SafeArea(
              top: false,
              child: CustomButton(
                loading: vm.isBusy,
                child: HStack(
                  [
                    "Order Now".i18n.text.make(),
                    "  ${AppStrings.currencySymbol}${vm.total.numCurrency}"
                        .text
                        .semiBold
                        .xl
                        .make(),
                  ],
                ),
                onPressed:
                    vm.selectedVehicleType != null && _priceController.text != "0.0" ? vm.processNewOrder : null,
              ).wFull(context),
            ),
          ],
        )
            .p20()
            .scrollVertical()
            .box
            .color(context.backgroundColor)
            .topRounded(value: 30)
            .shadow5xl
            .make(),
      ),
    );
  }
}
