

window.onload = start;


  function start(){
// Creating meal constructor
    function Meal(id, name, description, calorie_count, price, category) {
      this.id = id;
      this.name = name;
      this.description = description;
      this.calorie_count = calorie_count;
      this.price = price;
      this.category = category;
    }

    Meal.prototype.summary = function() {
      return `<h4 style="font-size: 12px;" >` + this.description + "<br> <b>  Calories: </b>" + this.calorie_count + "<br> <b>Price: </b> $" + parseInt(this.price).toFixed(2) + "</h4>";
    };



    getuserOrders();
    listeners();
// plan: On the users show page, when "orders" is moused over or clicked the customers list of orders is rendered

function getuserOrders(){
    var response;
      $.get("/trips.json", function(response){
        var orderList;

        console.log(response)
        for (let i=0; i< response.length; i++){

          function Trip (id, date, meals){
            this.id = id ;
            this.date = date;
            this.meals = meals;
          };

          var newTrip = new Trip(response[i]["id"], new Date(response[i]["date"]).toLocaleDateString(), response[i]["meals"])

          // console.log(newTrip["date"])
          // console.log(response[i]["meals"])

          Trip.prototype.orderTotal = function(){
            return this.meals.reduce(function (acc, meal){
              if (!meal){ return parseFloat(0)} else {
              return acc + parseFloat(meal["price"])}}, 0)
          }

          // console.log(newTrip.orderTotal());

          Trip.prototype.mealList = function(){
            return this.meals.map(function(meal){
                return   `${meal["name"]}  $${meal["price"]} <br>`
              }) }

          // arr.reduce(function (acc, obj) { return acc + obj.x; }, 0);

          orderList+= "<b>Order No. <b>" + newTrip["id"] + " |" + " <b> Date: <b>" + newTrip["date"] + "<br>" +
          "Meals: <br>" + newTrip.mealList() + "<br>" + "<b>Order Total: <b>" + "$" + parseFloat(newTrip.orderTotal()).toFixed(2) + "<br><br> <hr><br>";

          }
               $("#orders").empty();
               $("#orders").html(orderList);
         }
)};
///////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////
// on meal show page - when the 'next' button is pressed, the next meal in the list is loaded
 function nextMeal(){
  $(".js-next").on("click", setNext())
}

function setNext(){
  var nextId = parseInt($(".js-next").attr("data-id")) + 1;
  $(".js-next").show();
   if(nextId){

  $.get("/meals/" + nextId + ".json", function(data){

    var newMeal= new Meal(data["id"], data["name"], data["description"], data["calorie_count"], data["price"], data["category"] );

    console.log(data["name"])
     $("#mealName").html(newMeal["name"]);
     $("#mealDescription").html(newMeal["description"]);
     $("#mealPrice").html("$" + parseInt(newMeal["price"]).toFixed(2));
     $("#mealCalories").html("Calories: " + newMeal["calorie_count"]);
     $(".js-next").attr("data-id", newMeal["id"]);
     $(".js-prev").attr("data-id", parseInt(newMeal["id"]) - 1 );
  })
} else {
  $(".js-next").hide();
}
}

function setPrevious(){
  var prevId = parseInt($(".js-prev").attr("data-id")) - 1;
   $(".js-prev").show();
    console.log($(".js-prev").attr("data-id"));
   if (prevId){

  $.get("/meals/" + prevId + ".json", function(data){
    console.log(data["name"])
     $("#mealName").html(data["name"]);
     $("#mealDescription").html(data["description"]);
     $("#mealPrice").html("$" + parseInt(data["price"]).toFixed(2));
     $("#mealCalories").html("Calories: " + data["calorie_count"]);
     $(".js-prev").attr("data-id", data["id"]);
     $(".js-next").attr("data-id", parseInt(data["id"]) + 1);
  })
} else {
  $(".js-prev").hide();
}
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
  // console.log(url)
  e.preventDefault();
  $.get(`${url}.json`, function(response){
    console.log(response)
//////////////////////////////////////////////////////////////
//  create Meal class => newMeal objects => set summary prototype on Meal class
  // function Meal(id, name, description, calorie_count, price, category) {
  //   this.id = id;
  //   this.name = name;
  //   this.description = description;
  //   this.calorie_count = calorie_count;
  //   this.price = price;
  //   this.category = category;
  // }

    var newMeal= new Meal(response["id"], response["name"], response["description"], response["calorie_count"], response["price"], response["category"] );




    // console.log(newMeal)
    // $(`td.mealDescription-${newMeal["id"]}`).empty();
    // $(`td.mealDescription-${meal["id"]}`).html(meal["description"] + "<br>  Calorie Count: " + meal["calorie_count"]).toggle();

    $(`td.mealDescription-${newMeal["id"]}`).html(newMeal.summary()).toggle();
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

}
