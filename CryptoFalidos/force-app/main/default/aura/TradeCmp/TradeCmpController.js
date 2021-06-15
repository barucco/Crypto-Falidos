({
    retrievePrice: function(component, event, helper) {
        var action = component.get("c.getPrice");
        action.setParams({
            "mercadoId": component.get("v.recordId")
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            //var cotacao = response.getReturnValue();
            if (state == "SUCCESS") {
                //alert('O preço atual é: ' + response.getReturnValue());
              var cotacao = response.getReturnValue();
              component.set("v.opCotacao", cotacao); 
                //alert('O preço atual é: ' + cotacao);
            } else {
                console.log("Erro: " + JSON.stringify(response.getError()));
            }
        });

        $A.enqueueAction(action);
    },

    handleChange: function(component, event, helper) {
        //console.log(event.getParam("checked"));
        component.set("v.opMercado", !event.getParam("checked"));
    },

    handleOrder: function(component, event, helper) {
        alert('Código de salvar a ordem');
    }

})