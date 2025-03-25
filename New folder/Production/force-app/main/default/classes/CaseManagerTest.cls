@IsTest
public with sharing class CaseManagerTest {
    @TestSetup
    static void createCaseRecord(){
	Case caseTest = new Case(
        Subject = 'Test Record',
        Status = 'New',
        Origin = 'Phoe',
        Priority = 'Hight');
        insert caseTest;       
    }
    @IsTest static void testGetCaseById(){
        Case testCase = [select Id,Status,Subject,Origin,Priority From Case];

        RestRequest request = new RestRequest();
        request.requestURI = 'https://yourInstance.my.salesforce.com/services/apexrest/Case/' + testCase.Id;
        // request.requestURL ='https://yourInstance.my.salesforce.com/services/apexrest/Cases/'
            // + recordId;
        request.httpMethod = 'GET';
        restContext.request = request;
        Test.startTest();
        Case testCaseResult = CaseManager.getCaseById();
        Test.stopTest();

        system.Assert.areEqual('Test Record', testCaseResult.subject);
    }
    @IsTest static void testCreateCase(){
        Id caseId = CaseManager.createCase('new subject','New','Phone','High');

        system.Assert.isTrue(caseId != null);
        Case testCase = [SELECT Id,Status, Subject FROM Case WHERE Id =:caseId];

        system.Assert.areEqual('new subject', testCase.Subject);
    }
    @IsTest static void testDeleteCase(){

        Case testCase = [select Id,Status,Subject,Origin,Priority From Case LIMIT 1];
        
        RestRequest request = new RestRequest();
        request.requestURI = 'https://yourInstance.my.salesforce.com/services/apexrest/Case/'+ testCase.Id;
        request.httpMethod = 'DELETE';
        RestContext.request = request;

        Test.startTest();
        CaseManager.deleteCase();
        Test.stopTest();
        
        list<Case> cases = [select Id,Status,Subject,Origin,Priority 
                            from Case Where Id =: testCase.Id];
        system.Assert.areEqual('0',cases.size());
    }
}