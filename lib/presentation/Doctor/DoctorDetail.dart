import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/Design/styles/styles.dart';

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({Key? key}) : super(key: key);

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  String? _selectedTime;
  String? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 210, 233, 252),
            Color.fromARGB(255, 248, 244, 246),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
         appBar: AppBar(
            title: Text(
                'Doctor detail',
                textAlign: TextAlign.start,
                style: kTitleStyle,
                
              ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color.fromARGB(255, 210, 233, 252),
                    const Color.fromARGB(255, 248, 244, 246),
                  ],
                ),
              ),
            ),
          ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Details
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      // Doctor's Image
                      ClipOval(
                        child: Image.asset(
                          'assets/doctor02.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 40,),
                      // Doctor's Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Doctor's Name
                            Text(
                              'Dr. Ahmed Salah',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Doctor's Specialization
                            const SizedBox(height: 8),
                            Text(
                              'Cardiologist',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            // Doctor's Rating
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Icon(Icons.star, color: Colors.amber),
                                Icon(Icons.star, color: Colors.amber),
                                Icon(Icons.star, color: Colors.amber),
                                Icon(Icons.star, color: Colors.amber),
                                Icon(Icons.star_half, color: Colors.amber),
                                SizedBox(width: 8),
                                Text('4.7'),
                              ],
                            ),
                            // Doctor's Location
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Icon(Icons.location_on, color: Colors.grey),
                                SizedBox(width: 8),
                                Text('800m away'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // About Doctor
                const SizedBox(height: 25),
                const Text(
                  'About',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 25),
                // Calendar
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _CalendarDay(
                        day: 'Mon',
                        number: '21',
                        isAvailable: _selectedDay == 'Mon',
                        onTap: () {
                          setState(() {
                            _selectedDay = 'Mon';
                          });
                        },
                      ),
                      _CalendarDay(
                        day: 'Tue',
                        number: '22',
                        isAvailable: _selectedDay == 'Tue',
                        onTap: () {
                          setState(() {
                            _selectedDay = 'Tue';
                          });
                        },
                      ),
                      _CalendarDay(
                        day: 'Wed',
                        number: '23',
                        isAvailable: _selectedDay == 'Wed',
                        onTap: () {
                          setState(() {
                            _selectedDay = 'Wed';
                          });
                        },
                      ),
                      _CalendarDay(
                        day: 'Thu',
                        number: '24',
                        isAvailable: _selectedDay == 'Thu',
                        onTap: () {
                          setState(() {
                            _selectedDay = 'Thu';
                          });
                        },
                      ),
                      _CalendarDay(
                        day: 'Fri',
                        number: '25',
                        isAvailable: _selectedDay == 'Fri',
                        onTap: () {
                          setState(() {
                            _selectedDay = 'Fri';
                          });
                        },
                      ),
                      _CalendarDay(
                        day: 'Sat',
                        number: '26',
                        isAvailable: _selectedDay == 'Sat',
                        onTap: () {
                          setState(() {
                            _selectedDay = 'Sat';
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Time Slot Row
                Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _TimeSlot(
                        time: '09:00 AM',
                        isSelected: _selectedTime == '09:00 AM',
                        onTap: () {
                          setState(() {
                            _selectedTime = '09:00 AM';
                          });
                        },
                      ),
                      _TimeSlot(
                        time: '10:00 AM',
                        isSelected: _selectedTime == '10:00 AM',
                        onTap: () {
                          setState(() {
                            _selectedTime = '10:00 AM';
                          });
                        },
                      ),
                       _TimeSlot(
                        time: '10:00 AM',
                        isSelected: _selectedTime == '10:00 AM',
                        onTap: () {
                          setState(() {
                            _selectedTime = '10:00 AM';
                          });
                        },
                      ),
                       _TimeSlot(
                        time: '10:00 AM',
                        isSelected: _selectedTime == '10:00 AM',
                        onTap: () {
                          setState(() {
                            _selectedTime = '10:00 AM';
                          });
                        },
                      ),
                      _TimeSlot(
                        time: '11:00 AM',
                        isSelected: _selectedTime == '11:00 AM',
                        onTap: () {
                          setState(() {
                            _selectedTime = '11:00 AM';
                          });
                        },
                      ),
                      _TimeSlot(
                        time: '01:00 PM',
                        isSelected: _selectedTime == '01:00 PM',
                        onTap: () {
                          setState(() {
                            _selectedTime = '01:00 PM';
                          });
                        },
                      ),
                      _TimeSlot(
                        time: '02:00 PM',
                        isSelected: _selectedTime == '02:00 PM',
                        isAvailable: true,
                        onTap: () {
                          setState(() {
                            _selectedTime = '02:00 PM';
                          });
                        },
                      ),
                      _TimeSlot(
                        time: '03:00 PM',
                        isSelected: _selectedTime == '03:00 PM',
                        onTap: () {
                          setState(() {
                            _selectedTime = '03:00 PM';
                          });
                        },
                      ),
                      _TimeSlot(
                        time: '04:00 PM',
                        isSelected: _selectedTime == '04:00 PM',
                        onTap: () {
                          setState(() {
                            _selectedTime = '04:00 PM';
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Book Appointment Button
                Center(
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 118, 183, 221),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Book Appointment'),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Calendar Day Widget
class _CalendarDay extends StatelessWidget {
  final String day;
  final String number;
  final bool isAvailable;
  final VoidCallback onTap;

  const _CalendarDay({
    Key? key,
    required this.day,
    required this.number,
    required this.isAvailable,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        margin: const EdgeInsets.only(right: 8.0),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 12.0,
        ),
        decoration: BoxDecoration(
          color: isAvailable ? const Color.fromARGB(255, 157, 196, 228) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isAvailable ? Colors.white : const Color.fromARGB(255, 182, 193, 232),
          ),
        ),
        child: Column(
          children: [
            Text(
              day,
              style: TextStyle(
                color: isAvailable ? Colors.white : Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              number,
              style: TextStyle(
                color: isAvailable ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Time Slot Widget
class _TimeSlot extends StatelessWidget {
  final String time;
  final bool isAvailable;
  final bool isSelected;
  final VoidCallback onTap;

  const _TimeSlot({
    Key? key,
    required this.time,
    this.isAvailable = false,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 18.0,
        ),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color: isAvailable ? const Color.fromARGB(255, 157, 196, 228) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isAvailable ? Colors.white : const Color.fromARGB(255, 182, 193, 232),
          ),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(
                color: isAvailable ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
