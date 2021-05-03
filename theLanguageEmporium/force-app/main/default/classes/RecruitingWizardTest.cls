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
    
    @isTest
    public static void positionPageReturnsCorrectPage(){
        Position__c pickedPosition = new Position__c(Name='ContentDev', Course_Dev_Team__c = 'Japanese');
        insert pickedPosition;
        
        PageReference pr = Page.RecruitingLanding;
        
        Test.setCurrentPage(pr);
        
        pr.getParameters().put('position', pickedPosition.id);        
        
        RecruitingWizard controller = new RecruitingWizard();
       	
        String nextPage = controller.positionPage().getURL();
        
        System.assertEquals('/apex/positionpage', nextPage);
        System.assertEquals(controller.pickedPosition.id, pickedPosition.id);
        
    }
    
    @isTest
    public static void returnCandidatePage(){
        PageReference pr = Page.PositionPage;
        Test.setCurrentPage(pr);
        
        RecruitingWizard controller = new RecruitingWizard();
        String nextPage = controller.candidatePage().getURL();
        
        System.assertEquals('/apex/candidatepage', nextPage);
        
    }
    
    @isTest
    public static void returnExperience(){
        PageReference pr = Page.candidatePage;
        Test.setCurrentPage(pr);
        
        RecruitingWizard controller = new RecruitingWizard();
        String nextPage = controller.experience().getURL();
        
        System.assertEquals('/apex/experience', nextPage);
    }
    
    @isTest
    public static void returnCandidateQuestions(){
        Position__c pickedPosition = new Position__c(Name='ContentDev', Course_Dev_Team__c = 'Japanese');
        insert pickedPosition;
        
        List<Position_Question__C>questions = new List<Position_Question__c>();
        
        for(Integer i = 0; i < 3; i++){
            Position_Question__c newQuestion = new Position_Question__c(Position__C=pickedPosition.id, question__c='test');
        }
        
        insert questions;
        
        pickedPosition = [SELECT Name, Description__c, Course_Dev_Team__c, Type__c, (SELECT Question__c FROM Position_Questions__r) from Position__c Where id = :pickedPosition.Id];
        PageReference pr = Page.experience;
        Test.setCurrentPage(pr);
       
        RecruitingWizard controller = new RecruitingWizard();
        String nextPage = controller.candidateQuestions().getURL();
        
        System.assertEquals('/apex/candidatequestions', nextPage);
        System.assertEquals(3, controller.answers.size());
        System.assertEquals(3, controller.answerWrappers.size());
    }
    
    
}