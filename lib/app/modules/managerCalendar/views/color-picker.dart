/*
part of event_calendar;

class _ColorPicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ColorPickerState();
  }
}

class _ColorPickerState extends State<_ColorPicker> {
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
                leading: Icon(
                    index == managerCalendarController.selectedColorIndex
                        ? Icons.lens
                        : Icons.trip_origin,
                    color: managerCalendarController.colorCollection[index]),
                title: const Text(
                      ''
                    //managerCalendarController.colorNames![index],
                ),
                onTap: () {
                  setState(() {
                    managerCalendarController.selectedColorIndex = index;
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
