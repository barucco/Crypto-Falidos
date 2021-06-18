trigger MercadoTrigger on Mercado__c (after insert) {
    (new MercadoTriggerHandler()).run();

}