@isTest
global  class GetLatestCurrencyConvertMock implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest request) {

        String jsonBody = '{"success": true, "rates": {"INR": 94.88}}';
        HttpResponse response = new HttpResponse();
        response.setBody(jsonBody);
        response.setStatusCode(200);
        
        return response;
    }

}