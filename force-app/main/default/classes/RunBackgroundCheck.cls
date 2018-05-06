public with sharing class RunBackgroundCheck {
    @Future(callout=true)
    public static void callOutToBlockchain(String id, String ssn) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        //id param needs to prepend with ns, such as 'resource:org.blockchain.mynetwork.Individual#123-45-6789'
        request.setEndpoint('http://50.23.5.251:31090/api/queries/selectRecords?govIdParam=resource%3Aorg.blockchain.mynetwork.Individual%23'+ssn);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
            
            Candidate__c candidate = [Select Id  from Candidate__c where Id=:id limit 1];
            if (results.size() > 0) {
                Map<String, Object> result = (Map<String, Object>) results.get(0);
                String description = (String) result.get('description');
                candidate.Description__c = description;
                candidate.Background_Checked__c = false;
            } else {
                candidate.Background_Checked__c = true;
            }
            update candidate;
        }
    }
}
