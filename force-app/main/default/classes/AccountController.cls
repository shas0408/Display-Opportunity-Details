public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static String getOpportunityDetails (String accountId) {
        Integer count = [SELECT COUNT() FROM Opportunity WHERE AccountId =: accountId];
        Decimal amountUsingAggregateResult = (Decimal) [SELECT SUM(Amount) sum FROM Opportunity WHERE AccountId =: accountId][0].get('sum');
        Decimal amountUsingLoop = 0;

        for(Opportunity opportunityObj : [SELECT Id, Amount FROM Opportunity WHERE AccountId =: accountId]) {
            amountUsingLoop = amountUsingLoop + opportunityObj.Amount;
        }

        return String.valueOf(count) + ',' + UserInfo.getDefaultCurrency() + ' ' + String.valueOf(amountUsingAggregateResult);
    }
}