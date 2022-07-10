# DragableGridviewPlus


该插件基于DragableGridview 扩展, 支持空安全，添加了一些动画和一些功能，使用更自然,目的是适用于我自己的项目，如果不符合自己的项目的话，拉到本地自己进行定制化修改


DragableGridview[https://github.com/baoolong/DragableGridview](https://github.com/baoolong/DragableGridview)



<img width="38%" height="38%" src="https://raw.githubusercontent.com/OpenFlutter/PullToRefresh/master/demonstrationgif/20180821_094948.gif"/>

## Usage

Add this to your package's pubspec.yaml file:

	dependencies:
	  
    dragablegridview_flutter:
    git:
      url: 
      ref: master
	  
Add it to your dart file:

    import 'package:dragablegridview_flutter/dragablegridview_flutter.dart';
    
And GridView dataBin must extends DragAbleGridViewBin ,Add it to your dataBin file 
    
    import 'package:dragablegridview_flutter/dragablegridviewbin.dart';
    
## Example

#### DataBin example (must extends DragAbleGridViewBin)

    import 'package:dragablegridview_flutter/dragablegridviewbin.dart';
    
    class ItemBin extends DragAbleGridViewBin{
    
      ItemBin( this.data);
    
      String data;
    
      @override
      String toString() {
        return 'ItemBin{data: $data, dragPointX: $dragPointX, dragPointY: $dragPointY, lastTimePositionX: $lastTimePositionX, lastTimePositionY: $lastTimePositionY, containerKey: $containerKey, containerKeyChild: $containerKeyChild, isLongPress: $isLongPress, dragAble: $dragAble}';
      }
    
    }

#### Widget Usage Example

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


## Properties

| properties         | type             | defaults             | description                       |
| ----               | ----             | ----                 | ----                              |
| child | typedef | @required | gridview's child at each position
| itemBins | List<T> | @required | the data to be show by gridview's children
| crossAxisCount | int | 4 | how many children to be show in a row ; 一行显示几个child
| crossAxisSpacing | double | 1.0 | cross axis spacing ; 和滑动方向垂直的那个方向上 child之间的空隙
| mainAxisSpacing | double | 0.0 | main axis spacing ; 滑动方向child之间的空隙
| childAspectRatio | double | 0.0 | child aspect ratio ; child的纵横比
| editSwitchController | class | null | the switch controller that to trigger editing by clicking the button ; 编辑开关控制器，可通过点击按钮触发编辑
| editChangeListener | typedef | null | when you long press to trigger the edit state, you can listener this state to change the state of the edit button ;	长按触发编辑状态，可监听状态来改变编辑按钮（编辑开关 ，通过按钮触发编辑）的状态
| isOpenDragAble | bool | false | whether to enable the dragable function;是否启用拖动功能
| animationDuration | int | 300 | animation duration;动画持续的时长
| longPressDuration | int | 800 | long press duration;长按触发拖动的时长
| deleteIcon | Image | null | Delete button icon,Do not set this property if you do not use the delete function;删除按钮的图标，如果不使用删除功能，不要设置此属性

## LICENSE
    MIT License

	Copyright (c) 2018
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
