/*
part of event_calendar;

class _ResourcePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ResourcePickerState();
  }
}

class _ResourcePickerState extends State<_ResourcePicker> {
  final managerCalendarController = Get.find<ManagerCalendarController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: managerCalendarController.colorCollection.length - 1,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(managerCalendarController.nameCollection![index]),
                onTap: () {
                  setState(() {
                    managerCalendarController.selectedResourceIndex = index;
                  });

                  // ignore: always_specify_types
                  Future.delayed(const Duration(milliseconds: 200), () {
                    // When task is over, close the dialog
                    Navigator.pop(context);
                  });
                },
              );
            },
          )),
    );
  }
}*/
