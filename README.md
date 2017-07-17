# Original task
### Help writing an Apex Trigger within our Salesforce that will route new Leads to specified salesperson

We would like to create a trigger in Salesforce that will route certain incoming leads that have pre-specified email domain convention(s) to the appropriate account owner (salesperson) of the corresponding company, which will assign them as a lead owner. 

For example, we have Lead A that has an email domain of @comcast.net (leadA@comcast.net), we know we want all leads that have @comcast.net to be assigned to Sales Person: Jon. So anytime a lead is created in Salesforce with an @comcast.net domain (it can be leadB or leadC) they will automatically be assigned to Salesperson Jon. 

We will provide the mapping email convention to sales leads, we need your help to write the java for the trigger within our Salesforce instances.


# Technical details
### Objects
- `LeadRoutingRule__c` - custom settings object
	- `Domains__c` (textarea) - Domains list, delimeted with `\n`
	- `UserId__c` (text) - User to route thses domains

### Classes
- `LeadRoutingRulesController` - helps to manage `LeadRoutingRule__c` objects from Lightning controllers
- `LeadTriggerHandler` - trigger, do main logic

APEX coverage 100%, tests include main corner-cases.

### Lightning components
- `LeadRoutingRules` - Settings component
- `LeadRoutingRulesForm` - Form for the settings component
- `LeadRoutingRuleUpdated` - An event to notify a main component about singe item changes
- `NameById` - Universal component to convert an id of something to name

### Settings demo
![Alt text](settingsDemo.gif?raw=true "Settings demo")