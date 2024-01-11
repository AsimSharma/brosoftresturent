
// Future getTimeFromUser({required bool isStartTime}) async {
//     var pickedTime = await getTimePicker(context);

//     // ignore: use_build_context_synchronously
//     String formateTime = pickedTime.format(context);

//     if (pickedTime == null) {
//       log("Time Cancled");
//     } else if (isStartTime == true) {
//       setState(() {
//         startTime = formateTime;
//         log(startTime);
//       });
//     }
//   }

//   getTimePicker(BuildContext context) {
//     return showTimePicker(
//         initialEntryMode: TimePickerEntryMode.input,
//         context: context,
//         // initialTime: selectedTime
//         initialTime: TimeOfDay(
//             hour: int.parse(startTime.split(':')[0]),
//             minute: int.parse(startTime.split(':')[1].split(" ")[0])));
//   }
