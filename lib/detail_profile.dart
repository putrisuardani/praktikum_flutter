import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailProfile extends StatefulWidget {
  DetailProfile({super.key});

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  var nama = 'Luh Gede Putri Suardani';
  var isChanged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: CircleAvatar(
                radius: 80,
                backgroundImage: Image.network(
                  'https://static.vecteezy.com/system/resources/thumbnails/050/393/628/small/cute-curious-gray-and-white-kitten-in-a-long-shot-photo.jpg',
                ).image,
              ),
            ),
            Text(
              nama,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '199404112022032022',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet.,',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                isChanged = !isChanged;
                if (isChanged) {
                  setState(() {
                    nama = 'Putri';
                  });
                } else {
                  setState(() {
                    nama = 'Luh Gede Putri Suardani';
                  });
                }
              },
              child: Text('Test Button'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isChanged = !isChanged;
                });
                if (isChanged) {
                  Fluttertoast.showToast(
                    msg: 'This is a Toast message',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('This is a SnackBar message')),
                  );
                }
              },
              child: Text('Another Button'),
            ),
          ],
        ),
      ),
    );
  }
}
