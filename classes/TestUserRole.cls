public class TestUserRole {
@AuraEnabled

public static String getListAccountStage() {
list<User> listUser = [SELECT UserRole.name FROM User Where Id =: UserInfo.getUserId()];
return 'hello';

}

}