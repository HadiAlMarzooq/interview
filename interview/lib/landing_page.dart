import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:interview/booking.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  List<Booking> bookings = <Booking>[
    Booking(name: 'Hadi', time: DateTime.utc(2022, 11, 9)),
    Booking(name: 'Hassan', time: DateTime.utc(2022, 8, 2)),
    Booking(name: 'Nawaf', time: DateTime.utc(2022, 6, 3))
  ];
  late DateTime dropdownValue;
  @override
  void initState() {
    // TODO: implement initState
    dropdownValue = bookings.first.time;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 20, 0, 20),
          child: Column(
            children: [
              Text('Select your preferred time: '),
              dropDown(context),
              ElevatedButton(onPressed: () => {showAlertDialog(context)}, child: const Text('Add book'))
            ],
          ),
        )));
  }

  Widget dropDown(BuildContext context) {
    return DropdownButton<DateTime>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (DateTime? value) {
          print(bookings
              .firstWhere(((element) => element.time == value))
              .isBooked);
          bookings.firstWhere(((element) => element.time == value)).book();
          print(bookings
              .firstWhere(((element) => element.time == value))
              .isBooked);

          setState(() {
            dropdownValue = value!;
          });
        },
        items: bookings
            .map((booking) => DropdownMenuItem<DateTime>(
                  value: booking.time,
                  child: booking.isBooked == false
                      ? Text(
                          '${booking.name} is there at ${booking.time.toString()}')
                      : Text(
                          '${booking.name} is there at ${booking.time.toString()}',
                          style: TextStyle(color: Colors.grey)),
                ))
            .toList());
  }
  showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {Navigator.of(context).pop();},
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed:  () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Column(
      children: [
        Text("Enter your name"),
        // Textfield 
      ],
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
}
