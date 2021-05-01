public class learnerExtension {
    public Contact currentUser{get;set;}
    public learnerExtension(){
        currentUser = new Contact();
    }
   
    public String getFirstName(){
        return UserInfo.getFirstName();
    }


}