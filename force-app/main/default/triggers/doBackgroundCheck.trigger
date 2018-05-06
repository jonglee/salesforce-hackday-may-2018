trigger doBackgroundCheck on Candidate__c (after insert) {
    for (Candidate__c candidate : Trigger.new) {
        RunBackgroundCheck.callOutToBlockchain(candidate.Id, candidate.Government_ID__c);
    }
}