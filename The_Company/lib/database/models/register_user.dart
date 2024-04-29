class RegisterUser {
  final String userId;
  final String walletId;
  final UserData userData;
  final WalletData walletData;
  final WithDrawlData withDrawlData;
  final String inviteCode;

  RegisterUser(this.userId, this.walletId, this.userData, this.walletData,
      this.withDrawlData, this.inviteCode);
}

class UserData {
  final String phone;
  final String userId;
  final String password;

  UserData(this.phone, this.userId, this.password);

  Map<String, dynamic> toMap() {
    return {'phone': phone, 'userId': userId, 'password': password};
  }

  factory UserData.fromMap(Map<String, dynamic> data) =>
      UserData(data['phone'], data['userId'], data['password']);
}

class WalletData {
  IncomeData income;
  final int balance;

  final AccountData accountData;

  WalletData(this.accountData, this.income, this.balance);

  Map<String, dynamic> toMap() {
    return {
      'income': income.toMap(),
      'balance': balance,
      'accountData': accountData.toMap()
    };
  }
}

class IncomeData {
  final int amount;

  IncomeData(this.amount);

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
    };
  }
}

class AccountData {
  String? accNo;
  String? ifsc;

  String? name;

  String? phone;

  String? pin;

  AccountData(this.accNo, this.ifsc, this.name, this.phone, this.pin);

  Map<String, dynamic> toMap() {
    return {
      'accNo': accNo,
      'ifsc': ifsc,
      'name': name,
      'phone': phone,
      'pin': pin,
    };
  }
}

class WithDrawlData {
  final int? amount;

  WithDrawlData(this.amount);

  Map<String, dynamic> toMap() {
    return {'amount': amount};
  }
}
