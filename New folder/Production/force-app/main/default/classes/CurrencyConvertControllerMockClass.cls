@isTest
global class CurrencyConvertControllerMockClass implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest request) {
        String jsonResponse = '{"symbols": {"INR": "Indian Rupee", "EUR": "Euro"}}';
        
        HttpResponse response = new HttpResponse();
        response.setBody(jsonResponse);
        response.setStatusCode(200);
        
        return response;
    }
}