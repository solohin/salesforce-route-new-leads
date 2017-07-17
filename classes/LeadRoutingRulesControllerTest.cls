@IsTest
public class LeadRoutingRulesControllerTest {
    @IsTest static void testGetSalesPersons(){
        List<User> users = LeadRoutingRulesController.getAllSalesPersons();
        System.assert(users.size() > 0);
    }
    
    @IsTest static void testInsertRule(){
        LeadRoutingRule__c rule = new LeadRoutingRule__c(Name='test rule 1', UserId__c = 'someId');
        LeadRoutingRulesController.updateRule(rule);
        
        List<LeadRoutingRule__c> rules = [SELECT Id, Name FROM LeadRoutingRule__c];
        System.assertEquals(rules.size(), 1);
        System.assertEquals(rules[0].Name, 'test rule 1');
    }
    
    @IsTest static void testUpdateRule(){
        LeadRoutingRule__c rule = new LeadRoutingRule__c(Name='test rule 1', UserId__c = 'someId');
        insert rule;
        
        rule.Name = 'overrided';
        LeadRoutingRulesController.updateRule(rule);
        
        List<LeadRoutingRule__c> rules = [SELECT Id, Name FROM LeadRoutingRule__c];
        System.assertEquals(rules.size(), 1);
        System.assertEquals(rules[0].Name, 'overrided');
    }
    
    @IsTest static void testInsertWithoutName(){
        LeadRoutingRule__c rule1 = new LeadRoutingRule__c(UserId__c = 'someId');
        LeadRoutingRule__c rule2 = new LeadRoutingRule__c(UserId__c = 'someId');
        rule1 = LeadRoutingRulesController.updateRule(rule1);
        rule2 = LeadRoutingRulesController.updateRule(rule2);
        rule2 = LeadRoutingRulesController.updateRule(rule2);
        
        List<LeadRoutingRule__c> rules = [SELECT Id, Name FROM LeadRoutingRule__c];
        System.assertEquals(2, rules.size());
        System.assertNotEquals(rule1.name, rule2.name);
    }

    @IsTest static void testGetRulesList(){
        LeadRoutingRule__c rule1 = new LeadRoutingRule__c(UserId__c = 'someId');
        LeadRoutingRule__c rule2 = new LeadRoutingRule__c(UserId__c = 'someId');
        rule1 = LeadRoutingRulesController.updateRule(rule1);
        rule2 = LeadRoutingRulesController.updateRule(rule2);
        
        List<LeadRoutingRule__c> result = LeadRoutingRulesController.getRulesList();
        System.assertEquals(2, result.size());
    }
    
    @IsTest static void testremoveRule(){
        LeadRoutingRule__c rule1 = new LeadRoutingRule__c(UserId__c = 'someId');
        LeadRoutingRule__c rule2 = new LeadRoutingRule__c(UserId__c = 'someId');
        rule1 = LeadRoutingRulesController.updateRule(rule1);
        rule2 = LeadRoutingRulesController.updateRule(rule2);
        
        System.assertEquals(2, [SELECT COUNT() FROM LeadRoutingRule__c]);
        
        LeadRoutingRulesController.ruleRemove(rule1.id);
        
        System.assertEquals(1, [SELECT COUNT() FROM LeadRoutingRule__c]);
    }

    @IsTest static void testGetUserToRedirect(){
        LeadRoutingRule__c rule1 = new LeadRoutingRule__c(UserId__c = 'firstId', Domains__c = 'panasonic.com\nmarvel.com');
        LeadRoutingRule__c rule2 = new LeadRoutingRule__c(UserId__c = 'secondId', Domains__c = 'apple.com');
        LeadRoutingRulesController.updateRule(rule1);
        LeadRoutingRulesController.updateRule(rule2);
        
        System.assertEquals('firstId', LeadRoutingRulesController.getUserToRedirect('panasonic.com'));
        System.assertEquals('firstId', LeadRoutingRulesController.getUserToRedirect('marvel.com'));
        System.assertEquals('secondId', LeadRoutingRulesController.getUserToRedirect('apple.com'));

        System.assertEquals(null, LeadRoutingRulesController.getUserToRedirect(''));
        System.assertEquals(null, LeadRoutingRulesController.getUserToRedirect('somerandomDomain.com'));
    }
}