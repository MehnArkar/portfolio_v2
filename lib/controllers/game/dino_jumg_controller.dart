import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum GameState{start,stop,gameOver}

class DinoJumpController extends GetxController with GetTickerProviderStateMixin{
  late AnimationController dinoController;
  late AnimationController treeController;
  late Animation<double> treeAnimation;
  final dinoKey = GlobalKey();
  final treeKey = GlobalKey();
  GameState currentGameState = GameState.stop;
  double treeWidth = MediaQuery.of(Get.context!).size.width*0.11;
  int score = 0;
  late Timer timer;
  Duration treeSpeed = const Duration(milliseconds: 2500);
  Duration dinoSpeed = const Duration(milliseconds: 700);
  int incressSpeedPerSecond = 200;
  
  @override
  void onInit() {
    super.onInit();
    //Dino animation controller
    dinoController = AnimationController(vsync: this,duration: dinoSpeed);
    dinoController.addListener(() {
      if(dinoController.status == AnimationStatus.completed){
        dinoController.reverse();
      }
    });

    //Tree animation controller
    treeController = AnimationController(vsync: this,duration:  treeSpeed);
    treeAnimation = Tween<double>(begin: -treeWidth,end: MediaQuery.of(Get.context!).size.width+treeWidth).animate(treeController);

  }

  onGameStart(){
    currentGameState = GameState.start;
    onIncressSpeed();
    onReset();
    onRunTree();
    update();
  }

  onIncressSpeed(){
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if(treeSpeed.inMilliseconds>=1800) {
        treeSpeed = Duration(
            milliseconds: treeSpeed.inMilliseconds - incressSpeedPerSecond);
        treeController.duration = treeSpeed;
      }
    });
  }


  onReset(){
    treeSpeed =const Duration(milliseconds: 2500);
    score=0;
    dinoController.reset();
    treeController.reset();
  }


  onJumb(){
    if(!dinoController.isAnimating && currentGameState==GameState.start) {
      dinoController.forward();
    }
  }

  onRunTree(){
      treeController.forward();
      treeController.addListener(() {
        if(treeController.isCompleted){
          treeController.reset();
          treeController.forward();
          score+=1;
          update();
        }
        if(isCollide()){
          gameOver();
        }
      });
  }

  gameOver(){
    currentGameState=GameState.gameOver;
    dinoController.stop();
    treeController.stop();
    timer.cancel();
    treeSpeed =const Duration(milliseconds: 2500);
    update();
  }


  bool isCollide() {
    bool collide=false;
    RenderBox box1 = dinoKey.currentContext?.findRenderObject() as RenderBox;
    RenderBox box2 = treeKey.currentContext?.findRenderObject() as RenderBox;

    final size1 =box1.size;
    final size2 =box2.size;

    final Offset position1 = box1.localToGlobal(Offset.zero);
    final Offset position2 = box2.localToGlobal(Offset.zero);

    collide = (position1.dx < position2.dx + size2.width &&
        position1.dx + size1.width > position2.dx &&
        position1.dy < position2.dy + size2.height &&
        position1.dy + size1.height > position2.dy);
    return collide;
  }




}