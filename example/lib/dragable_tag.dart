import 'package:dragablegridview_flutter/dragablegridview_flutter.dart';
import 'package:dragablegridview_flutter/dragablegridviewbin.dart';
import 'package:example/color_tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBin extends DragAbleGridViewBin {
  String data;
  ItemBin(this.data);
}

class DragableTag extends StatefulWidget {
  DragableTag({Key? key}) : super(key: key);

  @override
  State<DragableTag> createState() => _DragableTagState();
}

class _DragableTagState extends State<DragableTag> {
  List<ItemBin> itemBins = [];
  List<ItemBin> deleteItemBins = [];

  String actionTxtEdit = "编辑";
  String actionTxtComplete = "完成";
  String? actionTxt;
  var editSwitchController = EditSwitchController();
  final List<String> heroes = [
    "鲁班",
    "虞姬",
    "甄姬",
    "黄盖黄盖",
    "张飞",
    "关羽",
    "刘备",
    "曹操",
    "赵云",
    "孙策",
    "庄周",
    "廉颇",
    "后裔",
    "妲己",
    "荆轲",
  ];

  @override
  void initState() {
    super.initState();
    actionTxt = actionTxtEdit;
    heroes.forEach((heroName) {
      itemBins.add(ItemBin(heroName));
    });
  }

  void changeActionState() {
    if (actionTxt == actionTxtEdit) {
      setState(() {
        actionTxt = actionTxtComplete;
      });
    } else {
      setState(() {
        actionTxt = actionTxtEdit;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("可拖拽GridView"),
      ),
      body: SingleTouchRecognizerWidget(
        child: Column(
          children: [
            topEdit(),
            DragAbleGridView(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2,
              crossAxisCount: 4,
              fixedNum: 3,
              sideMargin: 20,
              itemBins: itemBins,
              editSwitchController: editSwitchController,
              isOpenDragAble: true,
              animationDuration: 300, //milliseconds
              longPressDuration: 400, //milliseconds
              deleteIcon: deleteIcon(Icons.remove),
              deleteIconClickListener: (e) {
                deleteItemBins.add(ItemBin(itemBins[e].data));
                setState(() {});
              },
              unActivateClick: (e) {
                print("点击跳转");
                print(itemBins[e].data);
              },
              child: (int position) {
                return Container(
                  alignment: Alignment.center,
                  width: 75,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(192, 211, 209, 209),
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                  child: Text(
                    itemBins[position].data,
                    style: TextStyle(fontSize: 15.0, color: Colors.black54),
                  ),
                );
              },
              editChangeListener: () {
                changeActionState();
              },
            ),
            moreItem(),
            DragAbleGridView(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2,
              crossAxisCount: 4,
              sideMargin: 20,
              itemBins: deleteItemBins,
              isHideDeleteIcon: false,
              isOpenDragAble: false,
              animationDuration: 300, //milliseconds
              longPressDuration: 400, //milliseconds
              deleteIcon: deleteIcon(Icons.add),
              deleteIconClickListener: (e) {
                itemBins.add(ItemBin(deleteItemBins[e].data));
                setState(() {});
              },
              child: (int position) {
                return Container(
                  alignment: Alignment.center,
                  width: 75,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(192, 211, 209, 209),
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                  child: Text(
                    deleteItemBins[position].data,
                    style: TextStyle(fontSize: 15.0, color: Colors.black54),
                  ),
                );
              },
              editChangeListener: () {
                changeActionState();
              },
            ),
          ],
        ),
      ),
    );
  }

  //顶部编辑
  Widget topEdit() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 25),
      height: 50,
      child: Row(
        children: [
          Text(
            "我的频道",
            style: TextStyle(fontSize: 15),
          ),
          Spacer(),
          GestureDetector(
            child: Text(
              actionTxt!,
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
              ),
            ),
            onTap: () {
              changeActionState();
              editSwitchController.editStateChanged();
            },
          )
        ],
      ),
    );
  }

  Widget deleteIcon(icon) {
    return Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(
          color: HexColor.fromHex("#BEBEBE"),
          borderRadius: BorderRadius.circular(50)),
      child: Center(
        child: Icon(
          icon,
          size: 15,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget moreItem() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      height: 50,
      child: Row(
        children: [
          Text(
            "更多频道",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
