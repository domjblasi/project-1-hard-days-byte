@isTest
public class RecruitingWizardTest {
    @isTest
    public static void positionsArePopulated(){
        List<Position__c> positions = new List<Position__c>();
        Schema.DescribeFieldResult devTeams = Position__c.Course_Dev_Team__c.getDescribe();
        List<Schema.PicklistEntry> devTeamEntry = devTeams.getPicklistValues();
        
        for(Integer i = 0; i < 30; i++){
            Integer j = math.mod(i, devTeamEntry.size());
            Position__c testPosition = new Position__c(Name='Test'+i, Course_Dev_Team__c = devTeamEntry[j].value, status__c='Open');
        	positions.add(testPosition);
        }
        
        insert positions;
        
        RecruitingWizard controller = new RecruitingWizard();
        
        system.assertEquals(controller.positions.size(), positions.size());
        system.assert(controller.education.size() == 1);
        system.assert(controller.experience.size() == 3);
        system.assert(controller.pickedPosition == null);
      	system.assert(controller.AnswerWrappers.isEmpty());
    }
    
    @isTest
    public static void recruitingLandingClearsPickedPosition(){
        Position__c test = new Position__c(Name='ContentDev', Course_Dev_Team__c = 'Japanese');
    	
        insert test;
        
        RecruitingWizard controller = new RecruitingWizard();
        
        controller.pickedPosition = test;
        
        controller.recruitingLanding();
        
        system.assert(controller.pickedPosition == null);
    }
    
    @isTest
    public static void recruitingLandingReturnsPage(){
        PageReference pr = Page.PositionPage;
        Test.setCurrentPage(pr);
        
        RecruitingWizard controller = new RecruitingWizard();
        String nextPage = controller.recruitingLanding().getURL();
        
        System.assertEquals('/apex/recruitinglanding', nextPage);
        
    }
}