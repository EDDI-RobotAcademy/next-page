class SignInRequest {
  String email;
  String password;

  SignInRequest(this.email, this.password);
}

class SignUpRequest {
  String email;
  String password;
  String nickName;

  SignUpRequest(this.email, this.password, this.nickName);
}

class MemberPointRequest {
  int memberId;

  MemberPointRequest(this.memberId);
}

class NicknameModifyRequest {
  int memberId;
  String newNickname;

  NicknameModifyRequest(this.memberId, this.newNickname);
}

class PasswordModifyRequest {
  int memberId;
  String newPassword;

  PasswordModifyRequest(this.memberId, this.newPassword);
}