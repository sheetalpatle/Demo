public with sharing class CurrencyConverterController {
    @AuraEnabled(cacheable=true)
    public static List<String> getCurrencySymbols(){
        
        // string apikey = '7eb5fdd9e45a4d2dd7b69b4ee138b337';
        // string endPointUrl = 'https://data.fixer.io/api/symbols?access_key=' + apiKey;
        string endPointUrl = 'https://data.fixer.io/api/symbols?access_key=96367dd40d5e94a7bb7ffcf4dcd3c8f9';
        Http http = new Http();

        HttpRequest request = new HttpRequest();
        request.setEndpoint(endPointUrl);
        request.setMethod('GET');

        HttpResponse res = http.send(request);
        System.debug(res.getBody());

        list<String> currencySymbolList = new list<String>();
        
        if (res.getStatusCode() == 200) {
            // Parse the JSON response to extract symbols
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            if (result.containsKey('symbols')) {
                Map<String, Object> symbols = (Map<String, Object>) result.get('symbols');

                for (String cur : symbols.keySet()) {
                    System.debug('currency: ' + cur);
                    // string currencyName = (String)symbols.get(cur);
                    currencySymbolList.add(cur + '-' + symbols.get(cur));
                    
                }       
            }
        } else {
            System.debug('Error fetching symbols: ' + res.getBody());
        }

        return currencySymbolList;
    
    }    

    @AuraEnabled(cacheable=true)
    public static CurrencyConversionWrapper getLatestRate(String fromCurrency, String toCurrency,string amount ){
        Decimal amountConvert = Decimal.valueOf(amount);
        if(amountConvert == null || amountConvert <=0){
            amountConvert = 1.0;
        }
        String endPointUrl = 'https://data.fixer.io/api/latest?base=' + fromCurrency + '&symbols=' + toCurrency + '&access_key=96367dd40d5e94a7bb7ffcf4dcd3c8f9';

        Http http = new Http();

        HttpRequest request = new HttpRequest();
        request.setEndpoint(endPointUrl);
        request.setMethod('GET');

        HttpResponse res = http.send(request);
        System.debug(res.getBody());
        
        // list<CurrencyConversionWrapper> wrapper = new list<CurrencyConversionWrapper>();
        if (res.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            system.debug(results);
            if (results.containsKey('success') && results.containsKey('rates')) {
                System.debug('success: ' + results.get('success'));
                Map<String, Object> rates = (Map<String, Object>) results.get('rates');
                System.debug('rate: ' + rates.get(toCurrency));
                Decimal conversionRate = (Decimal)rates.get(toCurrency);

                // Decimal baseAmountRate = (Decimal)rates.get(fromCurrency);
                
                // Decimal baseAmount = baseAmountRate.setScale(2);
                Decimal convertedAmount = conversionRate.setScale(2);

                // Decimal convertedbaseAmount = baseAmount * amountConvert;
                String baseAmountString = String.valueof(convertedAmount);

                Decimal convertedValue = convertedAmount * amountConvert;
                String formattedRate =  String.valueOf(convertedValue);
                System.debug('Formatted rate: ' + formattedRate);
                String currencySymbol = toCurrency; 
            
                // Return the result with currency symbol and rate
                String converteAmount = formattedRate + ' ' + currencySymbol;
                String baseAmountWithSymbol = baseAmountString + ' ' + currencySymbol;

                return (new CurrencyConversionWrapper(converteAmount, baseAmountWithSymbol));
            }   
        } else {
            System.debug('Error fetching rates: ' + res.getBody());
        }

        return null;
    }
    public class CurrencyConversionWrapper {
        @AuraEnabled public String convertedAmount;
        @AuraEnabled public String baseAmount;

        public CurrencyConversionWrapper(String convertedAmount, String baseAmount) {
            this.convertedAmount = convertedAmount;
            this.baseAmount = baseAmount;
        }
    }
}