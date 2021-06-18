public with sharing class OrderDomain {

    private Ordem__c order;
    public double getTotal(){

        return order.Total__c;
    }
    public OrderDomain(Ordem__c order) {

        this.order = order;      
    }
    public void recalculaTotal() {

        if(order.preco__c != null && order.Quantidade__c != null ) {

            order.Total__c = order.Quantidade__c * order.preco__c;
        }else {

            order.adderror('Os valores de Quantidade e ou Preço não foram preenchidos.');
        }
    }
    public void recalculaQuantidade() {

        if(order.preco__c != null && order.Total__c != null ) {
            order.Quantidade__c = order.Total__c * order.preco__c;
        }else {
            order.adderror('Os valores de Total e ou Preço não foram preenchidos.');
        }        
    }
    public Boolean isFieldDifferent(sObjectField field, Ordem__c compareOrder) {

        return order.get(field) != compareOrder.get(field);
    }
}