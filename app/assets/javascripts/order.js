// plan: On the users show page, when "orders" is moused over or clicked the customers list of orders is rendered


function getuserOrders(){
    var response;
      $.get("/trips.json", function(response){
        var orderList;

        for (let i=0; i< response.length; i++){
          
          orderList+="Order No.  " + response[i]["id"] + " | " +
          "  Date:  " + response[i]["date"] + "<br>" +
            "Meals:  " +  response[i]["meals"].forEach(function(meal){

                 `Dish: ${meal["name"]}  Price: $${meal["price"]}`
            }) + "<br>"
                 // addmeal()
               }

               console.log(orderList)
               $("#orders").append(orderList);



          // function meals(){
          //   response[i]["meals"].forEach(function(meal){
          //
          //        `${meal["name"]}  $${meal["price"]}`
          //       console.log(`${meal["name"]}  $${meal["price"]}`);
          //      })
          //    }


          // function meals(){
          //    $.each(response[i]["meals"], function(index, meal){
          //      debugger
          //
          //       return `${meal["name"]}  $${meal["price"]}`
          //         console.log(`${meal["name"]}  $${meal["price"]}`);
          //       })
          //     }

          // var meals = response[i]["meals"]


         // console.log(response[i]["meals"])


         }
)}
