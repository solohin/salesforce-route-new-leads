public class LeadRoutingRulesController {
    @AuraEnabled
    public static List<User> getAllSalesPersons() {
        return [SELECT Id, Username, Name FROM User WHERE IsActive = TRUE];
    }
    
    @AuraEnabled
    public static LeadRoutingRule__c updateRule(LeadRoutingRule__c rule) {
        if (rule.Name == null) {
            rule.Name = 'autogenerated' + LeadRoutingRulesController.getSeed();
        }
        upsert rule;
        return rule;
    }
    
    private static String getSeed() {
        return '' + DateTime.now().getTime() + Math.round(Math.random() * 1000);
    }
    
    @AuraEnabled
    public static List<LeadRoutingRule__c> getRulesList() {
        return [SELECT Id, UserId__c, Domains__c FROM LeadRoutingRule__c];
    }
    
    @AuraEnabled
    public static void ruleRemove(Id ruleId) { 
        System.debug('LeadRoutingRulesController.ruleRemove called with ruleId = ' + ruleId);       
        LeadRoutingRule__c rule = [SELECT Id FROM LeadRoutingRule__c WHERE Id = :ruleId];
        delete rule;
    }

    public static String getUserToRedirect(String domain){
        String query = '%'+domain+'%';
        List<LeadRoutingRule__c> rules = [SELECT Id, Domains__c, Userid__c FROM LeadRoutingRule__c WHERE Domains__c LIKE :query ];

        for(LeadRoutingRule__c rule: rules){
            List<String> lines = rule.Domains__c.split('\n');
            for(String line: lines){
                if(line == domain){
                    return rule.Userid__c;
                }
            }
        }

        return null;
    }
}