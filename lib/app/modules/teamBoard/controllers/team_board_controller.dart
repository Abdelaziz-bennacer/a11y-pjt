import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/team_board/teamboard_item_model/team_board_item_model.dart';
import '../../../data/models/team_board/teamboard_list_model/team_board_list_model.dart';

class TeamBoardController extends GetxController {
  final scrollController = ScrollController();
  //final verticalScrollController = ScrollController();

  final List<TeamBoardList> allBoardLists = [
    TeamBoardList(
      title: 'Nouveau',
      items: [
          TeamBoardItem(title: 'Item 1', urlImage: 'Daniel'),
          TeamBoardItem(title: 'Item 2', urlImage: 'Jean'),
          TeamBoardItem(title: 'Item 2', urlImage: 'Abdel'),
        ],
    ),
    TeamBoardList(
      title: 'En Cours',
      items: [
          TeamBoardItem(title: 'Item X', urlImage: 'Mathieu'),
        ],
    ),
    TeamBoardList(title: 'Terminé', items: [
      TeamBoardItem(title: 'Item 4', urlImage: 'Daniel2'),
      TeamBoardItem(title: 'Item 5', urlImage: 'Jean2'),
      TeamBoardItem(title: 'Item 6', urlImage: 'Abdel2'),
    ]),
    TeamBoardList(title: 'Annulé', items: [
      TeamBoardItem(title: 'Item 7', urlImage: 'Daniel3'),
      TeamBoardItem(title: 'Item 8', urlImage: 'Jean3'),
      TeamBoardItem(title: 'Item 9', urlImage: 'Abdel3'),
    ]),
  ];
  DragAndDropList buildList(TeamBoardList list) => DragAndDropList(
    header: Column(
      children: [
        Container(
          height: 30,
        ),
        Container(
          color: const Color(0xff082D6D),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  list.title,
                  style: GoogleFonts.acme(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline, color: Colors.white,),
                )
              ],
            ),
          ),
        ),
      ],
    ),
    children: list.items
        .map((item) => DragAndDropItem(
          child: Card(
            child: Container(
              //width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                      leading: Text(item.title),
                  ),
                  ListTile(
                    leading: Text(item.urlImage),
                  ),
                  //Text(item.urlImage),
                  //Text(item.title),
                ],
              ),
            ),
          ),
      /*ListTile(
            leading: Text(item.urlImage),
            title:
          ),*/
        ))
        .toList(),
  );

  late List<DragAndDropList> lists;

  void onReorderListItem(
      int oldItemIndex,
      int oldListIndex,
      int newItemIndex,
      int newListIndex
      ) {
    final oldListItems = lists[oldListIndex].children;
    //update();
    final newListItems = lists[newListIndex].children;
    //update();
    final movedItem = oldListItems.removeAt(oldItemIndex);
    update();
    newListItems.insert(newItemIndex, movedItem);
    update();
  }
  void onReorderList(
      int oldListIndex,
      int newListIndex
      ) {
    final movedList = lists.removeAt(oldListIndex);
    lists.insert(newListIndex, movedList);
    update();
  }

  buildDragHandle({bool isList = false}) {
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.top;
    final color = isList ? Colors.blueGrey : Colors.black26;

    return DragHandle(
      verticalAlignment: verticalAlignment,
        child: isList
            ? Padding(
              padding: const EdgeInsets.only(top: 5.0, right: 5.0),
              child: Icon(Icons.menu, color: color),
            )
            : Padding(
              padding: const EdgeInsets.only(top: 5.0, right: 5.0),
              child: Icon(Icons.menu, color: color),
            ),
    );
  }

  buildScrollList(BuildContext context, Axis axis) {
    return GetBuilder<TeamBoardController>(builder: (logic) {
      return Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          interactive: true,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: DragAndDropLists(
              horizontalAlignment: MainAxisAlignment.spaceAround,
              children: logic.lists,
              scrollController: scrollController,
              itemDragHandle: logic.buildDragHandle(),
              listDragHandle: logic.buildDragHandle(isList: true),
              onItemReorder: logic.onReorderListItem,
              onListReorder: logic.onReorderList,
              axis: axis,
              listWidth: 300,
              //listDraggingWidth: 300,
              listInnerDecoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .canvasColor,
              ),
              listDecoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black45,
                    spreadRadius: 3.0,
                    blurRadius: 6.0,
                    offset: Offset(2, 3),
                  ),
                ],
              ),
              listPadding: const EdgeInsets.all(30.0),
              listSizeAnimationDurationMilliseconds: 1,
              itemSizeAnimationDurationMilliseconds: 1,
            ),
          )
      );
    });
  }
  @override
  void onInit() {
    lists = allBoardLists.map((list) => buildList(list)).toList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
