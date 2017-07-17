@isTest
public class LeadTriggerTest {
	@testSetup static void createUsers(){
		Profile profile = [SELECT Id FROM Profile WHERE Name='Standard User']; 

		List<User> toInsert = new List<User>();

		toInsert.add(new User(Alias = 'standt2', Email='test1@gmail.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = profile.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='1l2kmkml213krmk1@gmail.com'));

		toInsert.add(new User(Alias = 'standt4', Email='test2@gmail.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = profile.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='2lkfr2rker@gmail.com'));

		insert toInsert;
	}

	static void createLeadRoitngRule(Id userId, String domain){
		LeadRoutingRule__c rule = new LeadRoutingRule__c(
			Name='test rule 1', 
			UserId__c = userId, 
			Domains__c = '88005553555.com\n' + domain + '\nshouldnotenterfierwithtestdata.com'
		);
        insert rule;
	}

	static Lead createLead(String email, Id OwnerId){
		Lead lead = new Lead(
			OwnerId=OwnerId, 
			Email=email, 
			LastName='a', 
			Company='a'
		);
		insert lead;
		return lead;
	}

	@isTest static void testRoutingSuccessful(){
		List<User> users = [SELECT Id FROM User LIMIT 2];
		User originalOwner = users.get(0);
		User newUser = users.get(1);

		LeadTriggerTest.createLeadRoitngRule(newUser.Id, 'apple.com');

		Test.startTest();

		Lead lead = LeadTriggerTest.createLead('test@apple.com', originalOwner.Id);

		lead = [Select id, OwnerId FROM Lead WHERE ID = :lead.Id];

		Test.stopTest();

		System.assertEquals(newUser.Id, lead.OwnerId);
	}

	@isTest static void testNoRoute(){
		List<User> users = [SELECT Id FROM User LIMIT 2];
		User originalOwner = users.get(0);
		User newUser = users.get(1);

		LeadTriggerTest.createLeadRoitngRule(newUser.Id, 'apple.com');

		Test.startTest();

		Lead lead = LeadTriggerTest.createLead('test@panasonic.com', originalOwner.Id);

		lead = [Select id, OwnerId FROM Lead WHERE ID = :lead.Id];

		Test.stopTest();

		System.assertEquals(originalOwner.Id, lead.OwnerId);
	}

	@isTest static void testEmptyEmail(){
		List<User> users = [SELECT Id FROM User LIMIT 2];
		User originalOwner = users.get(0);
		User newUser = users.get(1);

		LeadTriggerTest.createLeadRoitngRule(newUser.Id, 'apple.com');

		Test.startTest();

		Lead lead = LeadTriggerTest.createLead('', originalOwner.Id);

		lead = [Select id, OwnerId FROM Lead WHERE ID = :lead.Id];

		Test.stopTest();

		System.assertEquals(originalOwner.Id, lead.OwnerId);
	}
}