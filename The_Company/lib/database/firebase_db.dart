import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:the_company/database/models/invite_data.dart';
import 'package:the_company/database/tableConstants.dart';
import 'package:the_company/database/models/register_user.dart';

class DatabaseHelper {
  static Future fetchWallet({required String userId}) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("wallet/$userId");
      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        print(snapshotValue);
        return snapshotValue;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future fetchInvite({required String userId}) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("invite/$userId");
      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        print(snapshotValue);
        return snapshotValue;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  // method for check that user is already available in database or not
  static Future<bool> checkUser({required String userId}) async {
    try {
      final userDataRef =
          FirebaseFirestore.instance.collection(usersTable).doc(userId);

      final snapshot = await userDataRef.get();
      if (snapshot.exists) {
        if (kDebugMode) {
          print("Already exist");
        }
        return true;
      } else {
        if (kDebugMode) {
          print('Nothing found');
        }

        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Method for Register new User
  static Future<bool> registerUser({required RegisterUser registerUser}) async {
    try {
      // Create Reference for each table
      final userDataRef = FirebaseFirestore.instance
          .collection(usersTable)
          .doc(registerUser.userId);
      final walletDataRef = FirebaseFirestore.instance
          .collection(walletTable)
          .doc(registerUser.walletId);
      final inviteDataRef = FirebaseFirestore.instance
          .collection(inviteTable)
          .doc(registerUser.walletId);

      // Write Data of User and Wallet Table
      await userDataRef.set(registerUser.userData.toMap());

      await walletDataRef.set(registerUser.walletData.toMap());

      // if user registered with referral
      if (registerUser.inviteCode.isNotEmpty) {
        final id =
            await referralAdd(registerUser.inviteCode, registerUser.walletId);

        await inviteDataRef.set(InviteData(0, id).toMap());
      }

      // if user registered without a referral
      else {
        await inviteDataRef.set(InviteData(0, registerUser.walletId).toMap());
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Method for add referral
  static Future<String> referralAdd(String inviteCode, String walletId) async {
    // Create reference of inviter user inviteTable data
    final inviteDataRef =
        FirebaseFirestore.instance.collection(inviteTable).doc(inviteCode);

    // Get the data
    final inviteSnapshots = await inviteDataRef.get();

    // if user available
    if (inviteSnapshots.exists) {
      InviteData inviteSnapshotData =
          InviteData.fromMap(inviteSnapshots.data()!);

      inviteSnapshotData.increment();

      inviteDataRef.update(inviteSnapshotData.toMap());

      return inviteCode;
    } else {
      return walletId;
    }
  }

  // method for read user data at login screen
  static Future<UserData?> readUserData({required String userId}) async {
    try {
      final userDatabaseReference =
          FirebaseFirestore.instance.collection(usersTable).doc(userId);

      final snapshot = await userDatabaseReference.get();

      // if user exist
      if (snapshot.exists) {
        UserData userData = UserData.fromMap(snapshot.data()!);
        return userData;
      }
      // is user not exist
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static void rentWrite(
      {required String userId,
      required int amount,
      required int dailyincome,
      required String walletId,
      required DateTime datetime,
      required String transid,
      required int totalincome}) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("users/$userId/rent");

      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        print(snapshotValue);

        await databaseReference
            .child('transaction${snapshotValue.length + 1}')
            .update({
          'amount': amount,
          'dailyincome': dailyincome,
          'totalincome': totalincome,
          'time': datetime.toString(),
          'transid': transid
        });
        firstBalanceWrite(walletId: walletId, dailyincome: dailyincome);
        commisionWrite(userId: walletId, price: amount);
      } else {
        print('Nothing found');
      }
    } catch (e) {
      rethrow;
    }
  }

  static void firstBalanceWrite(
      {required String walletId, required int dailyincome}) async {
    try {
      DatabaseReference databaseWalletReference =
          FirebaseDatabase.instance.ref("wallet/$walletId");
      final walletsnapshot = await databaseWalletReference.get();

      if (walletsnapshot.exists) {
        Map<String, dynamic> walletdata =
            Map<String, dynamic>.from(walletsnapshot.value as Map);

        final int updatedValue = walletdata["balance"] + dailyincome;
        databaseWalletReference.update({'balance': updatedValue});
      }
    } catch (e) {
      rethrow;
    }
  }

  static void commisionWrite({
    required String userId,
    required int price,
  }) async {
    try {
      DatabaseReference databaseInviteReference =
          FirebaseDatabase.instance.ref("invite/$userId");

      final invitesnapshot = await databaseInviteReference.get();

      if (invitesnapshot.exists) {
        Map<String, dynamic> invitedata =
            Map<String, dynamic>.from(invitesnapshot.value as Map);

        var code = invitedata["code"];
        if (code != userId) {
          fetchWallet(userId: code).then((value) {
            DatabaseReference databaseWalletReference =
                FirebaseDatabase.instance.ref("wallet/$code");

            var commision = price == 535
                ? 50
                : price == 1230
                    ? 150
                    : price == 3000
                        ? 250
                        : price == 5000
                            ? 400
                            : price == 16000
                                ? 500
                                : price == 48000
                                    ? 1000
                                    : 0;

            final updatedvalue = value["income"]["amount"] + commision;

            databaseWalletReference
                .child('income')
                .update({'amount': updatedvalue});

            walletWrite(
                walletId: code,
                writeField: "balance",
                amount: price,
                dailyincome: commision);
          });
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  static void walletWrite(
      {required String walletId,
      required String writeField,
      required int amount,
      required int dailyincome}) async {
    try {
      fetchWallet(userId: walletId).then((value) {
        if (value != false) {
          if (writeField == "balance") {
            DatabaseReference databaseWalletReference =
                FirebaseDatabase.instance.ref("wallet/$walletId");
            final updatedvalue = value["balance"] + dailyincome;
            databaseWalletReference.update({'balance': updatedvalue});
          } else if (writeField == "income") {
          } else if (writeField == "withdrawl") {}
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  static void bankAccountWrite({
    required String userId,
    required String name,
    required String phone,
    required String bankaccount,
    required String ifsc,
  }) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("wallet/$userId/details");

      databaseReference.update(
          {'accno': bankaccount, 'ifsc': ifsc, 'name': name, 'phone': phone});
    } catch (e) {
      rethrow;
    }
  }

  static void bankAccountPinWrite({
    required String userId,
    required String pin,
  }) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("wallet/$userId/details");

      databaseReference.update({'pin': pin});
    } catch (e) {
      rethrow;
    }
  }

  static void requestWrite(
      {required String userId,
      required String name,
      required String phone,
      required String bankaccount,
      required String ifsc,
      required int amount}) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("request/$userId");
      final snapshot = await databaseReference.get();

      var time = DateTime.now();
      if (snapshot.exists) {
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        print(snapshotValue);

        withdrawl(walletId: userId);
        await databaseReference
            .child('request${snapshotValue.length + 1}')
            .update({
          'amount': amount,
          'name': name,
          'phone': phone,
          'bankaccount': bankaccount,
          'ifsc': ifsc,
          'complete': false,
          'time': time.toString()
        });
      } else {
        withdrawl(walletId: userId);
        DatabaseReference databaseInitReference =
            FirebaseDatabase.instance.ref("request/$userId/request1");
        databaseInitReference.set({
          'amount': amount,
          'name': name,
          'phone': phone,
          'bankaccount': bankaccount,
          'ifsc': ifsc,
          'complete': false,
          'time': time.toString()
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  static void withdrawl({required String walletId}) async {
    try {
      DatabaseReference databaseWalletReference =
          FirebaseDatabase.instance.ref("wallet/$walletId");
      final walletsnapshot = await databaseWalletReference.get();

      if (walletsnapshot.exists) {
        Map<String, dynamic> walletdata =
            Map<String, dynamic>.from(walletsnapshot.value as Map);
        int temp = walletdata["balance"];
        final int updatedValue = walletdata["balance"] - walletdata["balance"];
        databaseWalletReference.update({'balance': updatedValue});
        DatabaseReference databaseReference =
            FirebaseDatabase.instance.ref("wallet/$walletId/withdrawl");

        final snapshot = await databaseReference.get();
        if (snapshot.exists) {
          Map<String, dynamic> snapshotValue =
              Map<String, dynamic>.from(snapshot.value as Map);
          print(snapshotValue);
          await databaseReference
              .update({'amount${snapshotValue.length + 1}': temp});
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updateDailyIncome() async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("users");
      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        Iterable<String> keys = snapshotValue.keys;
        for (final key in keys) {
          String userid = snapshotValue[key]["userid"];

          UserData? data;
          var walletData;
          var total;
          var todayIncome;
          var totalIncome;
          var totalwithdrawl;
          data = await readUserData(userId: key);
          walletData = await fetchWallet(userId: userid);
          total = 0;
          todayIncome = 0;
          totalIncome = 0;
          totalwithdrawl = 0;

          // for (int i = 1; i <= data["rent"].length; i++) {
          //   total = total + data["rent"]["transaction$i"]["amount"];
          //   todayIncome =
          //       todayIncome + data["rent"]["transaction$i"]["dailyincome"];
          //   totalIncome =
          //       totalIncome + data["rent"]["transaction$i"]["totalincome"];
          // }
          for (int i = 1; i <= walletData["withdrawl"].length; i++) {
            totalwithdrawl =
                totalwithdrawl + walletData["withdrawl"]["amount$i"];
          }

          if (walletData["balance"] + totalwithdrawl <
              totalIncome + walletData["income"]["amount"]) {
            print("wallet updated successfully");
            walletWrite(
                walletId: userid,
                writeField: "balance",
                amount: 1,
                dailyincome: todayIncome ?? 0);
          } else {
            print("Plan is expired");
          }
        }
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  static fetchRequest({required String userId}) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("request/$userId");
      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        return snapshotValue;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static fetchAllRequest() async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("request");
      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        return snapshotValue;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future fetchUsers() async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("users");
      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        print(snapshotValue);
        return snapshotValue;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static fetchTeam({required String userid}) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("request");
      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        return snapshotValue;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future walletRentWrite(
      {required String walletid,
      required String transid,
      required int amount,
      required String phone,
      required String date,
      required int totalincome,
      required int dailyincome}) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("wallet/$walletid/rent");
      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);

        for (int i = 1; i <= snapshotValue.length; i++) {
          if (transid == snapshotValue["rent$i"]["transid"]) {
            return false;
          }
        }
        await databaseReference.update({
          'rent${snapshotValue.length + 1}': {
            'userid': walletid,
            'amount': amount,
            'transid': transid,
            'useractivate': false,
            'date': date,
            'totalincome': totalincome,
            'dailyincome': dailyincome,
          }
        });
        return true;
      } else {
        await databaseReference.set({
          'rent1': {
            'userid': walletid,
            'amount': amount,
            'transid': transid,
            'useractivate': false,
            'date': date,
            'totalincome': totalincome,
            'dailyincome': dailyincome,
          }
        });
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  static void requestPackage({
    required String phone,
    required String walletId,
    required String transid,
    required int amount,
    required int totalincome,
    required int dailyincome,
  }) async {
    try {
      DateTime now = DateTime.now();
      var formattedDate = DateFormat('dd-MM-yyyy').format(now);

      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("package/$formattedDate");

      final snapshot = await databaseReference.get();
      walletRentWrite(
              walletid: walletId,
              transid: transid,
              amount: amount,
              phone: phone,
              date: formattedDate,
              totalincome: totalincome,
              dailyincome: dailyincome)
          .then((value) async {
        if (value == true) {
          if (snapshot.exists) {
            Map<String, dynamic> snapshotValue =
                Map<String, dynamic>.from(snapshot.value as Map);

            await databaseReference.update({
              'buy${snapshotValue.length + 1}': {
                'phone': phone,
                'userid': walletId,
                'amount': amount,
                'transid': transid,
                'activate': false,
                'time': DateFormat.jm().format(now).toString()
              }
            });
          } else {
            await databaseReference.set({
              'buy1': {
                'phone': phone,
                'userid': walletId,
                'amount': amount,
                'transid': transid,
                'activate': false,
                'time': DateFormat.jm().format(now).toString()
              }
            });
          }
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  static Future fetchPackageActivationDetails(
      {required String walletId,
      required String transid,
      required int amount,
      required String date}) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("package/$date");

      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);

        for (int i = 1; i <= snapshotValue.length; i++) {
          if (snapshotValue["buy$i"]["transid"] == transid &&
              snapshotValue["buy$i"]["userid"] == walletId &&
              snapshotValue["buy$i"]["amount"] == amount &&
              snapshotValue["buy$i"]["activate"] == true) {
            return await updateWalletRent(walletId: walletId, transid: transid);
          }
        }
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future updateWalletRent(
      {required String walletId, required String transid}) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("wallet/$walletId/rent");

      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);

        for (int i = 1; i <= snapshotValue.length; i++) {
          if (snapshotValue["rent$i"]["transid"] == transid &&
              snapshotValue["rent$i"]["useractivate"] == false) {
            await databaseReference
                .child('rent$i')
                .update({'useractivate': true});
            return true;
          } else {}
        }
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future fetchInvited({required String userid}) async {
    try {
      print("running");
      DatabaseReference databaseInviteReference =
          FirebaseDatabase.instance.ref("invite");

      final snapshot = await databaseInviteReference.get();
      if (snapshot.exists) {
        print("invite get");
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);

        Iterable<String> keys = snapshotValue.keys;
        DatabaseReference databaseReference =
            FirebaseDatabase.instance.ref("users");
        final snapshotUsers = await databaseReference.get();

        if (snapshotUsers.exists) {
          print("Users get");
          Map<String, dynamic> snapshotUsersValue =
              Map<String, dynamic>.from(snapshotUsers.value as Map);

          Iterable<String> userKeys = snapshotUsersValue.keys;

          var tempData = [];
          for (final key in keys) {
            if (snapshotValue[key]["code"] == userid) {
              // print(key);
              for (final key1 in userKeys) {
                if (snapshotUsersValue[key1]["userid"] == key.toString()) {
                  tempData.add(key1);
                }
              }
            }
          }
          return tempData;
        }
      } else {
        return;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future fetchAllPackageRequest() async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("package");
      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        print(snapshotValue);
        return snapshotValue;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future fetchPackageRequest({required String date}) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("package/$date");
      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        print(snapshotValue);
        return snapshotValue;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future packageActivation(
      {required String transid,
      required String date,
      required int buynum,
      required bool activate}) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("package/$date/buy$buynum");

      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        databaseReference.update({'activate': activate});
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
