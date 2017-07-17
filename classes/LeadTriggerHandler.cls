public with sharing class LeadTriggerHandler {
	public static void handleBeforeInsert(List<Lead> leads) {
		for(Lead lead: leads){
			LeadTriggerHandler.routeLeadByDomain(lead);
		}
	}

	private static void routeLeadByDomain(Lead lead){
		if(lead.Email != null){
			List<String> emailChunks = lead.Email.split('@');
			if(emailChunks.size() == 2){
				String domain = emailChunks.get(1);
				Id newOwnerId = LeadRoutingRulesController.getUserToRedirect(domain);
				if(newOwnerId != null){
					lead.ownerId = newOwnerId;
				}
			}
		}
	}
}