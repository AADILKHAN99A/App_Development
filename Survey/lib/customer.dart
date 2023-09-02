import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/info.dart';
import 'package:email_validator/email_validator.dart';

class Customer extends StatefulWidget {
  const Customer({super.key});

  @override
  State<Customer> createState() => CustomerState();
}

class CustomerState extends State<Customer>
    with AutomaticKeepAliveClientMixin<Customer> {
  @override
  bool get wantKeepAlive => true;

  //................................Customer Page...............................
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 34, left: 20),
            child: Text(
              "Name",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Stack(children: [
            Container(
              margin: const EdgeInsets.only(top: 3, left: 20, right: 20),
              height: 50,
              decoration: ShapeDecoration(
                  color: Colors.black.withOpacity(0.05000000074505806),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 3, right: 40),
              child: TextFormField(
                key: const ValueKey('name'),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Required';
                  } else if (value.toString().length < 2) {
                    return 'Name is too small';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  InfoState.name = value.toString();
                },
                decoration: InputDecoration(
                  errorStyle: GoogleFonts.poppins(),
                  hintText: "Enter name",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.6000000238418579),
                      fontWeight: FontWeight.w400),
                  contentPadding: const EdgeInsets.only(left: 22),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.name,
              ),
            ),
          ]),
          Container(
            // color: Colors.brown,
            margin: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "Address",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Stack(children: [
            Container(
              margin: const EdgeInsets.only(top: 3, left: 20, right: 20),
              height: 50,
              decoration: ShapeDecoration(
                  color: Colors.black.withOpacity(0.05000000074505806),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 3, right: 40),
              child: TextFormField(
                key: const ValueKey('address'),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Required';
                  } else if (value.toString().length < 20) {
                    return 'Min Characters 20';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  InfoState.address = value.toString();
                },
                decoration: InputDecoration(
                  errorStyle: GoogleFonts.poppins(),
                  hintText: "Enter address",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.6000000238418579),
                      fontWeight: FontWeight.w400),
                  contentPadding: const EdgeInsets.only(left: 22),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.streetAddress,
              ),
            ),
          ]),
          Container(
            // color: Colors.brown,
            margin: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "Email",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Stack(children: [
            Container(
                margin: const EdgeInsets.only(top: 3, left: 20, right: 20),
                height: 50,
                decoration: ShapeDecoration(
                    color: Colors.black.withOpacity(0.05000000074505806),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 3, right: 40),
              child: TextFormField(
                key: const ValueKey('email'),
                validator: (value) {
                  if (EmailValidator.validate(value!)) {
                    return null;
                  } else if (value.toString().isEmpty) {
                    return 'Required';
                  } else {
                    return 'Enter Valid Email';
                  }
                },
                onSaved: (value) {
                  InfoState.email = value.toString();
                },
                decoration: InputDecoration(
                  errorStyle: GoogleFonts.poppins(),
                  hintText: "Enter email",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.6000000238418579),
                      fontWeight: FontWeight.w400),
                  contentPadding: const EdgeInsets.only(left: 22),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ]),
          Container(
            // color: Colors.brown,
            margin: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "Phone Number",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Stack(children: [
            Container(
                margin: const EdgeInsets.only(top: 3, left: 20, right: 20),
                height: 50,
                decoration: ShapeDecoration(
                    color: Colors.black.withOpacity(0.05000000074505806),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
            Padding(
              padding: const EdgeInsets.only(
                  top: 3, left: 20, right: 40, bottom: 30),
              child: TextFormField(
                key: const ValueKey('number'),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Required';
                  } else if (!RegExp(
                          r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                      .hasMatch(value!)) {
                    return "Enter Valid Mobile Number";
                  }
                },
                onSaved: (value) {
                  InfoState.number = value.toString();
                },
                decoration: InputDecoration(
                  errorStyle: GoogleFonts.poppins(),
                  hintText: "Enter Phone number",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.6000000238418579),
                      fontWeight: FontWeight.w400),
                  contentPadding: const EdgeInsets.only(left: 22),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
