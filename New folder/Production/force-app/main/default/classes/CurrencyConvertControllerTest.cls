@isTest
public  class CurrencyConvertControllerTest {

    @isTest
    public static void getCurrencySymbolTest(){

        Test.setMock(HttpCalloutMock.Class,new CurrencyConvertControllerMockClass());

        Test.startTest();
        list<string> currencySymbole = CurrencyConverterController.getCurrencySymbols();

        Test.stopTest();
        system.Assert.isTrue(currencySymbole!=null);
        system.Assert.areEqual('EUR-Euro', currencySymbole[1]);
        system.Assert.areEqual('INR-Indian Rupee', currencySymbole[0]);
    }
    @isTest 
    public static void getLatestRateTest(){

        Test.setMock(HttpCalloutMock.Class,new GetLatestCurrencyConvertMock());

        Test.startTest();
            CurrencyConverterController.CurrencyConversionWrapper result = CurrencyConverterController.getLatestRate('EUR','INR', '100');
        Test.stopTest();
        
        System.Assert.areNotEqual(null,result);
        
    }
}