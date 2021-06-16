trigger HistoricoPrecoTrigger on HistoricoPreco__c (before insert) {
    (new HistoricoPrecoTriggerHandler()).run();

}