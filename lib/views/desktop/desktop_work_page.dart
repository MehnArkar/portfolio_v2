import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:portfolio_v2/controllers/desktop/desktop_work_controller.dart';
import 'package:portfolio_v2/utils/constants/app_colors.dart';

class DesktopWorkPage extends StatelessWidget {
  const DesktopWorkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DesktopWorkController());
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.08,vertical: MediaQuery.of(context).size.height*0.05),
      decoration:const BoxDecoration(
        color: AppColors.colorSecondary
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titlePanel(context),
          Expanded(child: projectPanel())

        ],
      ),
    );
  }

  Widget titlePanel(BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Divider
            Container(
              width:MediaQuery.of(context).size.width*0.05,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.colorAccent,
                borderRadius: BorderRadius.circular(3)
              ),
            ),
            const SizedBox(width: 30,),
            Text('Recent Work',style: Theme.of(context).textTheme.bodyMedium,)
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.05,),
        Text('Hand-picked projects\nfor you to see.',style: Theme.of(context).textTheme.titleMedium,),
      ],
    );
  }

  Widget projectPanel(){
    return Row(
      children: [
        Flexible(
            flex: 1,
            child: aboutProjectPanel()),
        Flexible(
            flex: 1,
            child: projectPrototypePanel())
      ],
    );
  }

  Widget aboutProjectPanel(){
    return GetBuilder<DesktopWorkController>(
      builder:(controller)=> Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Next panel
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                 padding:const EdgeInsets.all(12),
                  alignment: Alignment.center,
                  color:AppColors.colorComponent,
                  child:const Icon(Icons.arrow_back_ios_rounded,size:15,color: Colors.white,),
                ),
                const SizedBox(width: 15,),
                Text('0${controller.currentIndex+1} / 0${controller.projectList.length}',style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Colors.white,fontWeight: FontWeight.w700),),
                const SizedBox(width: 15,),
                Container(
                  padding:const EdgeInsets.all(12),
                  alignment: Alignment.center,
                  color:AppColors.colorComponent,
                  child:const RotatedBox(quarterTurns: 2, child:  Icon(Icons.arrow_back_ios_rounded,size: 15,color: Colors.white,)),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(Get.context!).size.height*0.05,),
            Text(controller.currentProject.name,style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: Colors.white),),
            SizedBox(height: MediaQuery.of(Get.context!).size.height*0.05,),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width:MediaQuery.of(Get.context!).size.width*0.025,
                  height: 3,
                  decoration: BoxDecoration(
                      color: AppColors.colorAccent,
                      borderRadius: BorderRadius.circular(3)
                  ),
                ),
                const SizedBox(width: 15,),
                Text('About this project',style: Theme.of(Get.context!).textTheme.bodyMedium,),

                
              ],
            ),
            SizedBox(height: MediaQuery.of(Get.context!).size.height*0.025,),
            SizedBox(
              height: MediaQuery.of(Get.context!).size.height*0.15,
              child: Text(controller.currentProject.description,style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(height: 1.8),),
            ),
            SizedBox(height: MediaQuery.of(Get.context!).size.height*0.05,),
            downloadButtonPanel()



          ],
        ),
      ),
    );
  }

  downloadButtonPanel(){
    Rx<bool> isHoverAppStore = false.obs;
    Rx<bool> isHoverPlayStore = false.obs;
   return Row(
     mainAxisSize: MainAxisSize.min,
     mainAxisAlignment: MainAxisAlignment.start,
     children: [
       Obx(
                ()=> MouseRegion(
              onHover: (_){
                isHoverAppStore.value= true;
              },
              onExit: (_){
                isHoverAppStore.value= false;
              },
              child: Container(
                padding:const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                decoration: BoxDecoration(
                    color: isHoverAppStore.value?AppColors.colorAccent:Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: AppColors.colorAccent,width: 2
                    )
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset('assets/icons/ios.svg',width: 15,color: isHoverAppStore.value?Colors.white:AppColors.colorAccent,),
                    const SizedBox(width: 15,),
                    Text('Download',style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:isHoverAppStore.value? Colors.white:AppColors.colorAccent,fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
            )
        ),
       const SizedBox(width: 30,),
       Obx(
               ()=> MouseRegion(
             onHover: (_){
               isHoverPlayStore.value= true;
             },
             onExit: (_){
               isHoverPlayStore.value= false;
             },
             child: Container(
               padding:const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
               decoration: BoxDecoration(
                   color: isHoverPlayStore.value?AppColors.colorAccent:Colors.transparent,
                   borderRadius: BorderRadius.circular(5),
                   border: Border.all(
                       color: AppColors.colorAccent,width: 2
                   )
               ),
               child: Row(
                 mainAxisSize: MainAxisSize.min,
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   SvgPicture.asset('assets/icons/android.svg',width: 15,color: isHoverPlayStore.value?Colors.white:AppColors.colorAccent,),
                   const SizedBox(width: 15,),
                   Text('Download',style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:isHoverPlayStore.value? Colors.white:AppColors.colorAccent,fontWeight: FontWeight.w500),),
                 ],
               ),
             ),
           )
       ),
     ],
   );
  }

  Widget projectPrototypePanel(){
    return Container();
  }

}
