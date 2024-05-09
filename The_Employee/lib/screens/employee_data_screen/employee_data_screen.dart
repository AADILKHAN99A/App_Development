import 'package:flutter/Material.dart';
import 'package:intl/intl.dart';
import 'package:the_employee/utils/color_constants.dart';

class EmployeeDataScreen extends StatefulWidget {
  final Map args;

  const EmployeeDataScreen({super.key, required this.args});

  @override
  State<EmployeeDataScreen> createState() => _EmployeeDataScreenState();
}

class _EmployeeDataScreenState extends State<EmployeeDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.args['data'].toMap());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_imageView(), _detailsView(), _personalDetailsView()],
      ),
    ));
  }

  Widget _detailsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.args['data'].fullName.toString(),
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        widget.args['data'].isActive == true
            ? const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Active",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.verified_user,
                    color: Colors.green,
                  )
                ],
              )
            : const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not Active",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.verified_user_outlined,
                    color: Colors.red,
                  )
                ],
              ),
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.args['data'].workDetails.toString(),
          style: const TextStyle(color: Colors.grey),
        ),
        Container(
          margin: const EdgeInsets.only(top: 40),
          width: 120,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Join Date",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(widget.args['data'].joinDate),
                style: const TextStyle(color: Color(darkBlue)),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _personalDetailsView() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade300),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Contact Details",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const Text(
                  "Email: ",
                  style: TextStyle(color: Color(darkBlue)),
                ),
                Text(widget.args['data'].email),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Phone: ",
                  style: TextStyle(color: Color(darkBlue)),
                ),
                Text(widget.args['data'].phone),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget _imageView() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 200,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.asset(
                'assets/bg.jpg',
                height: 150,
                fit: BoxFit.fill,
                width: 500,
              )),
        ),
        Center(
          child: CircleAvatar(
            backgroundColor: const Color(darkBlue),
            radius: 50,
            child: Image.asset('assets/user_logo.jpg'),
          ),
        )
      ],
    );
  }
}
