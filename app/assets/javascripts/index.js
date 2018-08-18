

 // $(document).ready(listeners);
// listeners();
//  window.onload = listeners();

// window.onload = function(){
//         getuserOrders;
//         listeners;
//
//  }
window.onload = start;

function start() {
  getuserOrders();
  listeners();
}

function nextMeal(){
  $(".js-next").on("click", setNext())
}

function setNext(){
  var nextId = parseInt($(".js-next").attr("data-id")) + 1;
  $.get("/meals/" + nextId + ".json", function(data){
    console.log(data["name"])
     $("#mealName").text(data["name"]);
     $("#mealDescription").text(data["description"]);
     $("#mealPrice").text(data["price"]);
     $("#mealCalories").text(data["calorie_count"]);
     $(".js-next").attr("data-id", data["id"]);
  })
}

// /////////////////////////////////////////////////////////////////////////
// Code to display meal description & calorie count to menu when meal name is clicked
function listeners(){
  var meals = document.getElementsByClassName("descrip");

  for (i=0; i<meals.length; i++){
    meals[i].addEventListener("click", getDescription);
  }
}

function getDescription(e){
  url = $(this).attr("href")
  console.log(url)
  e.preventDefault();
  $.get(`${url}.json`, function(response){
    $(`td.mealDescription-${response["id"]}`).empty();
    $(`td.mealDescription-${response["id"]}`).html(response["description"] + "<br>  Calorie Count: " + response["calorie_count"])
    // alert(response["description"] + "  Calorie Count: " + response["calorie_count"])
  })
}
//////////////////////////////////////////////////////////////////////////////////////////////////




// when the word "meal" is clicked the list of meals is rendred on the page
function getMeals(){
   $.get("/meals.json", function(response){
         // console.log("Response: ", response["0"])
         mealsContainer = document.getElementById("meals-list");
           for (var i=0; i<response.length; i++){
            // $("#meals-list ").after("<td>" + response[i]["name"] + "</td><td>" + response[i]["price"] + "</td><br>")
            var meals;
            meals += "<tr><td>" + response[i]["name"] + "</td><td>" + "$" + response[i]["price"] + "</td></tr>"
           }
           $("#meals-list").append(meals)
        });
      }

    
