@isTest
public class learnerUtilityClass {
	public static Integer lessonNumber =1;
     /**New Course**/
    public static Course__c getCourse(){
        Course__c newCourse = new Course__c();
        newCourse.Name = 'English I';
        newCourse.Status__c = 'Completed';
        insert newCourse;
        system.debug('Course' + newCourse); 
        return newCourse;
    }
    /**New Tutor**/
    public static Tutor__c getTutor(){
        Tutor__c newTutor = new Tutor__c();
        newTutor.Email__c='tutor@gmail.com';
        newTutor.Language__c='English';
        newTutor.Qualifications__c ='School';
        //insert newTutor;
        return newTutor;
    }
    /** New Lesson**/
    public static Lesson__c getLesson(){
        Course__c c = getCourse();
        Lesson__c newLesson = new Lesson__c();
        newLesson.Course__c=c.id;
        newLesson.Lesson_Number__c = lessonNumber;
        lessonNumber +=1;
        newLesson.Language_s__c ='English';
        newLesson.Completion_Status__c ='Completed';
        insert newLesson;
        return newLesson;
    }
    
    /** New Session, SET LEARNER AND INSERT AFTER**/
    public static Session__c getSession(){
        Tutor__c t = getTutor();
        Session__c newSession = new Session__c();
        newSession.Tutor__c = t.id;
        newSession.Duration__c=1;
        newSession.Language__c='Spanish';
        newSession.Date__c = System.today();
        return newSession;
        
    }
    

}