import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_v2/controllers/main_screen_controller.dart';
import 'package:portfolio_v2/utils/Responsive/responsive.dart';
import 'package:portfolio_v2/views/desktop/desktop_game_page.dart';
import 'package:portfolio_v2/views/desktop/desktop_home_page.dart';
import 'package:portfolio_v2/views/desktop/desktop_work_page.dart';
import 'package:portfolio_v2/views/global/super_scaffold.dart';
import 'package:portfolio_v2/views/global/ui/AnimateBackground.dart';

class MainScreenPage extends StatelessWidget {

  const MainScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MainScreenController());
    return SuperScaffold(
      body: GetBuilder<MainScreenController>(
        builder:(controller)=> Stack(
          children:[
            const AnimateBackground(),
            ListView(
              controller: controller.scrollController,
            children: [
               Responsive(
                 desktop:const DesktopHomePage(),
                 mobileLarge:notAvailableWidget(),
                 mobile: notAvailableWidget(),
               ),
               const Responsive(desktop: DesktopWorkPage()),
               const Responsive(desktop: DesktopGamePage(),)
            ],
          ),
    ]
        ),
      )
    );
  }
  Widget notAvailableWidget(){
    return SizedBox(
      width: MediaQuery.of(Get.context!).size.width,
      height: MediaQuery.of(Get.context!).size.height,
      child: Center(
        child: Text('Only Available in desktop view\n\n:\'(',style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: Colors.white),textAlign:TextAlign.center ,),
      ),
    );
  }
}
