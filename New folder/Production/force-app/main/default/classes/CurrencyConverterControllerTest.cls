@isTest
private class CurrencyConverterControllerTest {
    
    // // Mock class for HTTP Callouts
    // private class MockHttpResponse implements HttpCalloutMock {
    //     public HTTPResponse respond(HTTPRequest req) {
    //         HttpResponse res = new HttpResponse();
    //         res.setHeader('Content-Type', 'application/json');
    //         res.setStatusCode(200);
            
    //         if (req.getEndpoint().contains('/symbols')) {
    //             res.setBody('{"success": true, "symbols": {"USD": "United States Dollar", "EUR": "Euro", "GBP": "British Pound"}}');
    //         } else if (req.getEndpoint().contains('/latest')) {
    //             res.setBody('{"success": true, "rates": {"EUR": 0.85, "GBP": 0.75}}');
    //         } else {
    //             res.setStatusCode(400);
    //             res.setBody('{"error": "Invalid request"}');
    //         }
            
    //         return res;
    //     }
    // }
    
    // @isTest
    // static void testGetCurrencySymbols() {
    //     Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
        
    //     Test.startTest();
    //     List<String> symbols = CurrencyConverterController.getCurrencySymbols();
    //     Test.stopTest();
    // }

    // @isTest
    // static void testGetLatestRate() {
    //     Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
        
    //     Test.startTest();
    //     CurrencyConverterController.CurrencyConversionWrapper result = CurrencyConverterController.getLatestRate('USD', 'EUR', '100');
    //     Test.stopTest();
        
    //     System.assertNotEquals(null, result, 'Result should not be null');
    // }
    
    // @isTest
    // static void testInvalidAmount() {
    //     Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
        
    //     Test.startTest();
    //     CurrencyConverterController.CurrencyConversionWrapper result = CurrencyConverterController.getLatestRate('USD', 'GBP', '11.0');
    //     Test.stopTest();
        
       
    // }
}