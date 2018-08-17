// plan: On the users show page, when "orders" is moused over or clicked the customers list of orders is rendered
// $("document").ready(getuserOrders());
window.onload = getuserOrders;

function getuserOrders(){
    var response;
      $.get("/trips.json", function(response){
        var orderList;
        console.log(response)
        for (let i=0; i< response.length; i++){
          var meals = response[i]["meals"];
          var date = new Date(response[i]["date"])
          // console.log("Date: " + date.toLocaleDateString())
          var orderTotal = meals.reduce(function (acc, meal){
            if (!meal){ return parseFloat(0)} else {
            return acc + parseFloat(meal["price"])}}, 0);

          // arr.reduce(function (acc, obj) { return acc + obj.x; }, 0);

          orderList+="Order No.  " + response[i]["id"] + " | " +
          "  Date:  " + date + "<br>" +

            "Meals:  <br>" +  meals.map(function(meal){

              return   `${meal["name"]}  $${meal["price"]} <br>`
              })  + "<b>Order Total: </b>" + "$" + orderTotal.toFixed(2) +"<br><br>"

               }

               // console.log(orderList)
               $("#orders").empty();
               $("#orders").html(orderList);



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
