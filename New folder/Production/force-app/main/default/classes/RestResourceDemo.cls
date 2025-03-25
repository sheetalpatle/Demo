@RestResource(urlMapping='/Account')
global with sharing class RestResourceDemo {
    
    @HttpGet
    global static Account getAccount() {

        return [SELECT Id,Name,Phone FROM Account Limit 1];
    }
}