

function getMeals(){
   $.get("/meals.json", function(response){
         // console.log("Response: ", response["0"])
         mealsContainer = document.getElementById("meals-list");
        //
        // var mealsList;


           for (var i=0; i<response.length; i++){
            // $("#meals-list ").after("<td>" + response[i]["name"] + "</td><td>" + response[i]["price"] + "</td><br>")
            var meals;
              meals += "<tr><td>" + response[i]["name"] + "</td><td>" + "$" + response[i]["price"] + "</td></tr>"
           }
           $("#meals-list").after().append(meals)
        });
      }
