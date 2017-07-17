trigger LeadTrigger on Lead (before insert) {
	if(Trigger.isBefore && Trigger.isInsert){
		LeadTriggerHandler.handleBeforeinsert(Trigger.new);
	}
}