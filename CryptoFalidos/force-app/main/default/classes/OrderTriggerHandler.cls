public with sharing class OrderTriggerHandler extends TriggerHandler {
    
    public OrderTriggerHandler() { }

    protected override void beforeInsert() {

        for(Ordem__c o : (List<Ordem__c>) trigger.new) {

            OrderDomain order = new OrderDomain(o);
            
            if(trigger.isInsert) {
                if(order.getTotal() == null) order.RecalculaTotal();
                else order.RecalculaQuantidade();
            }
        }    
    }
    protected override void beforeUpdate() {

        for(Ordem__c o : (List<Ordem__c>) trigger.new) {
            
            OrderDomain order = new OrderDomain(o);
            Ordem__c ordemAntiga = (Ordem__c) trigger.oldMap.get(o.id);

            if(order.IsFieldDifferent(Schema.Ordem__c.Total__c, ordemAntiga)) 
                o.adderror('O Total não pode ser alterado manualmente depois que a ordem foi criada');

            if(order.IsFieldDifferent(Schema.Ordem__c.Quantidade__c, ordemAntiga) || order.isFieldDifferent(Schema.Ordem__c.preco__c, ordemAntiga))
                order.RecalculaTotal();
        }
    }
}