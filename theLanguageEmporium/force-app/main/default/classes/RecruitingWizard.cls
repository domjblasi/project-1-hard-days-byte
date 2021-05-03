public class RecruitingWizard {
    public List<Position__c> positions{get; set;}
    public Position__c pickedPosition{get; set;}
    Id pickedPositionId{get; set;}
    public Job_Application__c candidateApplication{get; set;}
    public Candidate__c positionCandidate{get; set;}
    public List<Candidate_Experience__c> experience{get; set;}
    public List<Candidate_Education__c> education{get; set;}
    private List<Candidate_Answer__c> answers{get; set;}
    public List<AnswerWrapper> AnswerWrappers{get; set;}
    public Position_Demographic__c positionDem{get; set;}
    
    public RecruitingWizard(){
        positions = [SELECT Id, Name FROM Position__c WHERE Status__c = 'Open'];
        pickedPosition = null;
        candidateApplication = new Job_Application__c();
        positionCandidate = new Candidate__c();
        experience = new List<Candidate_Experience__c>();

        for(Integer i = 0; i < 3; i++){
            Candidate_Experience__c newExperience = new Candidate_Experience__c();
            experience.add(newExperience);
        }

        education = new List<Candidate_Education__c>{new Candidate_Education__c()};
        answers = new List<Candidate_Answer__c>();
        answerWrappers = new List<AnswerWrapper>();
        positionDem = new Position_Demographic__c();
    }
    public PageReference recruitingLanding(){
        pickedPosition = null;
        candidateApplication = null;
        positionCandidate = null;
        return Page.RecruitingLanding;
    }

    public PageReference positionPage() {
        if(pickedPosition == null){
        PageReference cp = system.currentPageReference();
        pickedPositionId = cp.getParameters().get('position');
        system.debug(pickedPositionId);
        PageReference position = Page.PositionPage;
        
		pickedPosition = [SELECT Name, Description__c, Course_Dev_Team__c, Type__c, (SELECT Question__c FROM Position_Questions__r) from Position__c Where id = :pickedPositionId];
        }
        return Page.PositionPage;
    }
    
    public PageReference candidatePage(){
        return Page.CandidatePage;
    }
    
    public PageReference experience(){
        return Page.Experience;
    }
    
    public PageReference candidateQuestions(){
        if(answerWrappers.size() == 0){
        for(Position_Question__c question:pickedPosition.Position_Questions__r){
            Candidate_Answer__c newAnswer = new Candidate_Answer__c(Position_Question__c = question.id);
            AnswerWrapper newWrapper = new AnswerWrapper(question, newAnswer);
           	answers.add(newAnswer);
            answerWrappers.add(newWrapper);
        }
        }
        return Page.CandidateQuestions;
    }
    
    public PageReference demographic(){
        return Page.Demographic;
    }
    
    public PageReference review(){
        return Page.ResumeReview;
    }
    
    public PageReference addEd(){
        
        if(education.size() < 3){
        	education.add(new Candidate_Education__c());    
        }else{
            // add error message
        }

        return null;
    }
    
    public PageReference remEd(){
        if(education.size() != 1){
            education.remove(education.size()-1);
        }else{
            //add error message
        }
        
        return null;
    }
    public PageReference addExp(){
        
        if(experience.size() < 5){
            
        	experience.add(new Candidate_Experience__c());    
        
        }else{
            // add error message
        }

        return null;
    }
    
    public PageReference remExp(){
        
        if(experience.size() != 1){
            experience.remove(experience.size()-1);
        }else{
            //add error message
        }
        
        return null;
    }
    
    public class AnswerWrapper{
        public Candidate_Answer__c answer{get; set;}
        public Position_Question__c question{get; set;}
        
        public answerWrapper(Position_Question__c newQuestion, Candidate_Answer__c newAnswer){
            answer = newAnswer;
            question = newQuestion;
        }
    }
    
    public PageReference submit(){
        SavePoint sp = Database.setSavePoint();
        try{
            insert positionCandidate;
            candidateApplication.Position__c = pickedPositionId;
            candidateApplication.Candidate__c = positionCandidate.id;
            
            insert candidateApplication;
            
            for(Candidate_Experience__c exp:experience){
                exp.Job_Application__c = candidateApplication.id;
                exp.Candidate__c = positionCandidate.id;
            }
            insert experience;
            
            for(Candidate_Education__c ed:education){
                ed.Candidate__c = positionCandidate.id;
                ed.Job_Application__c = candidateApplication.id;
            }
            insert education;
            
            for(Candidate_Answer__c answer:answers){
                answer.Job_Application__c = candidateApplication.id;
            }
            insert answers;

            positionDem.position__c = pickedPositionId;
            insert positionDem;
            
            return Page.CandidateSuccess;
            
        }catch(Exception e){
            Database.rollback(sp);
            return Page.CandidateFailure;
       	}
        
    }
}