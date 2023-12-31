//                                    **-Data Models-**
//
//
//  ...................................User.................................
const usersTable = "Users";

class UsersFields {
  static const columnID = "_id";
  static const columnUserId = "userid";
  static const columnEmail = "email";
}

class UsersModel {
  final int? id;
  final int? userid;
  final int? email;

  UsersModel({
    this.id,
    this.userid,
    this.email
  });

}

//  ...................................Customer.................................
const customerTable = "Customer";

class CustomerFields {
  static const columnID = "_id";
  static const columnName = "name";
  static const columnAddress = "address";
  static const columnEmail = "email";
  static const columnPhone = "phone";
  static const columnDateTime = "dateTime";
}

class CustomerModel {
  final int? id;
  final String name;
  final String address;
  final String email;
  final int phone;

  CustomerModel(
      {this.id,
      required this.name,
      required this.address,
      required this.email,
      required this.phone});

  factory CustomerModel.fromMap(json) => CustomerModel(
      name: json["name"],
      address: json["address"],
      email: json["email"],
      phone: json["phone"]);

  Map<String, dynamic> toJson() => {
        CustomerFields.columnID: id,
        CustomerFields.columnName: name,
        CustomerFields.columnAddress: address,
        CustomerFields.columnEmail: email,
        CustomerFields.columnPhone: phone,
      };
}

//  ...................................Sight....................................
const sightTable = "Sight";

class SightFields {
  static const columnSightID = "_sightId";
  static const columnSightLabel = "label";
  static const columnSightName = "name";
  static const columnSightAddress = "address";
  static const columnSightEmail = "email";
  static const columnSightPhone = "phone";
  static const columnSightChecked = "checked";
}

class SightModel {
  final int? sightId;
  final String label;
  final String name;
  final String address;
  final String email;
  final String phone;
  final bool check;

  SightModel(
      {this.sightId,
      required this.label,
      required this.name,
      required this.address,
      required this.email,
      required this.phone,
      required this.check});
}

//  ...................................Devices..................................
const deviceTable = "Devices";

class DeviceFields {
  static const columnDeviceID = "_deviceId";
  static const columnDeviceSight = "sight";
  static const columnDeviceLabel = "label";
  static const columnDeviceType = "type";
  static const columnDeviceImage = "image";
  static const columnDeviceInformation = "information";
  static const columnDeviceChecked = "checked";
}

class DeviceModel {
  final int? deviceId;
  final String sight;
  final String label;
  final String type;
  final String image;
  final String information;
  final bool checked;

  DeviceModel(
      {this.deviceId,
      required this.sight,
      required this.label,
      required this.type,
      required this.image,
      required this.information,
      required this.checked});
}
