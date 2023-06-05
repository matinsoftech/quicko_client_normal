import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/view_models/vendor/popular_services.vm.dart';
import 'package:fuodz/widgets/buttons/custom_outline_button.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/custom_masonry_grid_view.dart';
import 'package:fuodz/widgets/list_items/grid_view_service.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/services.i18n.dart';

class PopularServicesView extends StatefulWidget {
  const PopularServicesView(this.vendorType, {Key key}) : super(key: key);

  final VendorType vendorType;

  @override
  _PopularServicesViewState createState() => _PopularServicesViewState();
}

class _PopularServicesViewState extends State<PopularServicesView> {
  bool showGrid = true;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PopularServicesViewModel>.reactive(
      viewModelBuilder: () => PopularServicesViewModel(
        context,
        widget.vendorType,
      ),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return VStack(
          [
            //
            HStack(
              [
                ("Popular".i18n + " ${widget.vendorType.name}")
                    .text
                    .xl
                    .semiBold
                    .make()
                    .expand(),
                Icon(
                  showGrid ? FlutterIcons.grid_fea : FlutterIcons.list_fea,
                ).p2().onInkTap(() {
                  setState(() {
                    showGrid = !showGrid;
                  });
                }),
              ],
            ).p12(),

            //
            !showGrid
                ? CustomMasonryGridView(
                    isLoading: vm.isBusy,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.1,
                    items: List.generate(
                      vm.services.length ?? 0,
                      (index) {
                        final service = vm.services[index];
                        return GridViewServiceListItem(
                          service: service,
                          onPressed: vm.serviceSelected,
                        );
                      },
                    ),
                  ).p12()
                : CustomListView(
                    noScrollPhysics: true,
                    isLoading: vm.isBusy,
                    dataSet: vm.services,
                    itemBuilder: (context, index) {
                      final service = vm.services[index];
                      return GridViewServiceListItem(
                        service: service,
                        onPressed: vm.serviceSelected,
                      );
                    },
                  ).p12(),

            //view more
            CustomOutlineButton(
              child: "View More"
                  .i18n
                  .text
                  .medium
                  .xl
                  .color(AppColor.primaryColor)
                  .makeCentered(),
              titleStyle: context.textTheme.bodyText1.copyWith(
                color: AppColor.primaryColor,
              ),
              onPressed: vm.openSearch,
            ).px20(),
          ],
        ).py12();
      },
    );
  }
}
