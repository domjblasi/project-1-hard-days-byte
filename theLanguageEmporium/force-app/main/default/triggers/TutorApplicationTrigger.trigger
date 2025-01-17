////////////////////////////////////////////////////
//
// Name: CourseTrigger
// Author: David J. Sellinger, Revature Associate
// Created: 04/08/2021
// Updated: 04/08/2021
// Description: After a new tutor application is
//		created, flag the new application for review
//		by the recruiting team (queue).
//
////////////////////////////////////////////////////

trigger TutorApplicationTrigger on Tutor_Application__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on trigger.operationType {
        when BEFORE_INSERT{
            
        }
        when BEFORE_UPDATE{
            
        }
        when BEFORE_DELETE{
            
        }
        when AFTER_UPDATE {
            
        }
        when AFTER_DELETE {
            
        }
        when AFTER_UNDELETE {
            
        }
        when AFTER_INSERT {
            TutorApplicationTriggerHandler.FlagAppReview(trigger.new);
        }
    }
}