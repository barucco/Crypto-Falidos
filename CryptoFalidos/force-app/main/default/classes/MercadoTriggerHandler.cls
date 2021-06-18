public with sharing class MercadoTriggerHandler extends TriggerHandler {

    public MercadoTriggerHandler() {
    }     
    public override void afterUpdate() {
        List<Mercado__c> mercados = trigger.new;
        List<Ordem__c> ordensToUpdate = new List<Ordem__c>();
        List<Mercado__c> mercadoTriggerList = [SELECT Id, CotacaoAtual__c, (SELECT Id, preco__c
                                                                            FROM Ordem__c
                                                                            WHERE Status__c = 'Aguardando')
                                                FROM Mercado__c
                                                WHERE Id in :Trigger.newMap.keySet()];
        for(Mercado__c mercado : mercadoTriggerList) {
            for(Ordem__c ordem : mercado.Ordem__c) {
                if(ordem.Mercado__c == mercado.Id) {
                    double precoAntigo = trigger.oldMap.get(mercado.Id).preco__c;
                    double precoOrdem = ordem.preco__c;
                    double precoNovo = mercado.preco__c;
                    if((precoOrdem >= precoAntigo && precoOrdem <= precoNovo) || (precoOrdem <= precoAntigo && precoOrdem >= precoNovo)) {
                        ordensToUpdate.add(new Ordem__c(Id = ordem.Id, Status__c = 'Executada'));
                    }
                 }
            }
        }
        update ordensToUpdate;
    }
}