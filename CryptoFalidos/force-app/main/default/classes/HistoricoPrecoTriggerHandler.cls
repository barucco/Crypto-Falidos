public with sharing class HistoricoPrecoTriggerHandler extends TriggerHandler {
    public historicoPrecoTriggerHandler(){

    }
    protected override void afterInsert(){    
        this.atualizaPrecoMercado();

    }
    private void atualizaPrecoMercado() {
        //Proibido acesso a banco de dados dentro do FOR (SELECT, UPDATE, DELETE, INSERT)
        Map<id, Mercado__c> mapPrecosMercado = new Map<id,Mercado__c>();
        for(HistoricoPreco__c hp : (List<HistoricoPreco__c>) trigger.new) {
            mapPrecosMercado.put(hp.Mercado__c, new Mercado__c(id = hp.Mercado__c, CotacaoAtual__c = hp.Preco__c));
        }
        update mapPrecosMercado.values();
    }
}