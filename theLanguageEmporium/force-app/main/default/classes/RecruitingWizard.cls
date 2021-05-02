public class RecruitingWizard {
    public List<Position__c> positions{get; set;}
    public Position__c pickedPosition{get; set;}
    Id pickedPositionId{get; set;}
    public Job_Application__c candidateApplication{get; set;}
    public Candidate__c positionCandidate{get; set;}
    public ContentVersion resume{get; set;}
    public List<Candidate_Experience__c> experience{get; set;}
    public List<Candidate_Education__c> education{get; set;}
    private List<Position_Question__c> questions{get; set;}
    public List<Candidate_Answer__c> answers{get; set;}
    
    public RecruitingWizard(){
        positions = [SELECT Id, Name FROM Position__c WHERE Status__c = 'Open'];
        pickedPosition = null;
        candidateApplication = new Job_Application__c();
        positionCandidate = new Candidate__c();
        resume = new ContentVersion();
        experience = new List<Candidate_Experience__c>();

        for(Integer i = 0; i < 3; i++){
            Candidate_Experience__c newExperience = new Candidate_Experience__c();
            experience.add(newExperience);
        }

        education = new List<Candidate_Education__c>{new Candidate_Education__c()};
        questions = new List<Position_Question__c>();
        answers = new List<Candidate_Answer__c>();
    }
    
    public PageReference recruitingLanding(){
        pickedPosition = null;
        candidateApplication = null;
        positionCandidate = null;
        return Page.RecruitingLanding;
    }

    public PageReference positionPage() {
        PageReference cp = system.currentPageReference();
        pickedPositionId = cp.getParameters().get('position');
        system.debug(pickedPositionId);
        PageReference position = Page.PositionPage;
        
		pickedPosition = [SELECT Name, Description__c, Course_Dev_Team__c, Type__c from Position__c Where id = :pickedPositionId];
        
        return Page.PositionPage;
    }
    
    public PageReference candidatePage(){
        return Page.CandidatePage;
    }
    
    public PageReference experience(){

        return Page.Experience;
    }
    
    public PageReference addEd(){
        education.add(new Candidate_Education__c());
        return null;
    }
    
}