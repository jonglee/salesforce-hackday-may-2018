public with sharing class RunBackgroundCheck {
    @Future(callout=true)
    public static void callOutToBlockchain(String id, String ssn) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //fixme: invoke the right query
        request.setEndpoint('http://50.23.5.251:31090/api/CourtRecord');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            System.debug(response.getBody());

            //todo: 
            /*
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
           
            */
        }
    }
}
