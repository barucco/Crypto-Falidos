public with sharing class MercadoTriggerHandler extends TriggerHandler {
    public MercadoTriggerHandler() {
    }

    protected override void afterUpdate() 
    {
        this.executaOrdem();
    }

    private void executaOrdem(){
        List<Ordem__c> listUpdate = new List<Ordem__c>();
        List<Ordem__c> listOrdem = [select id, preco__c, Mercado__c  
                                    from Ordem__c 
                                    where Mercado__c in :Trigger.newMap.keySet() and OrdemStatus__c = 'Aguardando'];
        for(Ordem__c ordem : listOrdem){
            decimal precoNovo = recuperaPrecoNovo(ordem.Mercado__c);
            decimal precoAntigo = recuperaPrecoAntigo(ordem.Mercado__c);      
            if((ordem.preco__c >= precoAntigo && ordem.preco__c <= precoNovo) || (ordem.preco__c <= precoAntigo && ordem.preco__c >= precoNovo)) 
            {
                listUpdate.add(new Ordem__c(id=ordem.id, OrdemStatus__c = 'Executada', preco__c = precoNovo));
            }
        }

        if(listUpdate.size()>0){
            update listUpdate;
        }
    }

    private decimal recuperaPrecoNovo(string id) {
        Mercado__c m = (Mercado__c)trigger.newMap.get(id);
        return m.CotacaoAtual__c;
    }

    private decimal recuperaPrecoAntigo(string id) {
        Mercado__c m = (Mercado__c)trigger.oldMap.get(id);
        return m.CotacaoAtual__c;
    }
}