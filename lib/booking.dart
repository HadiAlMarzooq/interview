class Booking {
  String name;
  DateTime time;
  bool isBooked;
  Booking({required this.name, required this.time, this.isBooked = false});


  void book(){
    isBooked = true;
  }

}
