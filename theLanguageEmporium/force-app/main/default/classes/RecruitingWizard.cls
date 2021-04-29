public class RecruitingWizard {
    transient public List<Position__c> positions{get; set;}
    public Position__c pickedPosition{get; set;}
    public AppWrapper application{get; set;}
    public ContentVersion resume{get; set;}
    
    public RecruitingWizard(){
        positions = new List<Position__c>();
        pickedPosition = null;
        application = new AppWrapper();
        resume = new ContentVersion();
    }
    
    public class AppWrapper {
        public Job_Application__c candidateApplication{get; set;}
        public Candidate__c positionCandidate{get; set;}

        public AppWrapper(){
            candidateApplication = new Job_Application__c();
            positionCandidate = new Candidate__c();
        }
    }
    
    public void upload(){
        
        
    }
    public PageReference recruitingLanding(){
        pickedPosition = null;
        application = new AppWrapper();
        return Page.RecruitingLanding;
    }
    public PageReference positionPage() {
        return Page.PositionPage;
    }
    
    public PageReference candidatePage(){
        return Page.CandidatePage;
    }
    
    public PageReference candidateDetails(){
        return Page.CandidateDetails;
    }
    
    public PageReference experience(){
        return Page.Experience;
    }
    
}