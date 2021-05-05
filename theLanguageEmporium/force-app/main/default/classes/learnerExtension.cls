public class learnerExtension {
    public User currentUser {get;set;}
    public Contact currentContact{get;set;}
    public ApexPages.StandardController standardController {get;set;}
    
    public learnerExtension(ApexPages.StandardController sc){
        standardController = sc;
        currentUser = [select Id, ContactId from User WHERE id=:userinfo.getuserid() LIMIT 1];
        currentContact=[select id, name from Contact WHERE id = :currentUser.ContactId LIMIT 1];
		
    }
    public PageReference getNewSession(){
   		//PageReference pr = new PageReference('/apex/Session');
   		return Page.Session;
	}
   
  


}