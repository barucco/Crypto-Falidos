public with sharing class HistoricoPrecoTriggerHandler extends TriggerHandler {
    public HistoricoPrecoTriggerHandler() {

    }
    protected override void afterInsert() {    
        this.AtualizaPrecoMercado();

    }
    private void AtualizaPrecoMercado() {
        //Proibido acesso a banco de dados dentro do FOR (SELECT, UPDATE, DELETE, INSERT)
        Map<id, Mercado__c> MapPrecosMercado = new Map<id,Mercado__c>();
        for(HistoricoPreco__c hp : (List<HistoricoPreco__c>) trigger.new) {
            MapPrecosMercado.put(hp.Mercado__c, new Mercado__c(id = hp.Mercado__c, CotacaoAtual__c = hp.preco__c));
        }
        update MapPrecosMercado.values();
    }
}
