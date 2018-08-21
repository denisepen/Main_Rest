

window.onload = start;


function start(){

  // getuserOrders();
  listeners();
  custOrders();
  form();

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
      return `<h4 style="font-size: 12px;" >` + this.description + "<br> <b>  Calories: </b>" + this.calorie_count + "<br> <b>Price: </b> $" + parseInt(this.price).toFixed(2) + add+ "</h4>";
      };

    var add = `<a href="/orders/new" style = "color: red; font-size: 13px"> ADD </a>`
///////////////////////////////////////////////////////////////////////////////////////

//   create Trip constructor
          function Trip (id, date, meals){
            this.id = id ;
            this.date = date;
            this.meals = meals;
          };

 // calculate the newTrip's order total
          Trip.prototype.orderTotal = function(){
            if (this.meals){
            return this.meals.reduce(function (acc, meal){
              if (!meal){ return parseFloat(0)} else {
              return acc + parseFloat(meal["price"])}}, 0)
          }
        }

        // arr.reduce(function (acc, obj) { return acc + obj.x; }, 0); //

//  create the list of meals for each trip
          Trip.prototype.mealList = function(){
            if (this.meals){
            return this.meals.map(function(meal){
                return   `${meal["name"]}  $${meal["price"]} <br>`
              })
            }
          }

// create the list of meals for each trip on the admin page for each customer order
          Trip.prototype.mealList2 = function(){
            if (this.meals){
            return this.meals.map(function(meal){
                return   `<p style="font-size: 11px;">${meal["name"]}  $${parseFloat(meal["price"]).toFixed(2)}</p> <br>`
              }) }
            }
////////////////////////////////////////////////////////////////////////////////////

// plan: On the users show page, when 'orders' is clicked the customers list of orders is displayed
  $("#userOrders").click(getuserOrders);

function getuserOrders(){

      $.get("/trips.json", function(response){
        var orderList="";

        // console.log(response)
        // console.log(response[i]["user"]["id"]);
        for (let i=0; i< response.length; i++){
          // debugger

//    create newTrip objects
          var newTrip = new Trip(response[i]["id"], new Date(response[i]["date"]).toLocaleDateString(), response[i]["meals"])

          orderList+= "<b>Order No. <b>" + newTrip["id"] + " |" + " <b> Date: <b>" + newTrip["date"] + "<br>" +
          "Meals: <br>" + newTrip.mealList() + "<br>" + "<b>Order Total: <b>" + "$" + parseFloat(newTrip.orderTotal()).toFixed(2) + "<br><br> <hr><br>";
      }
               // $("#orders").empty();
          $("#orders").html(orderList).toggle();
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
  if ($(".js-prev").attr("style").includes("display: none")){
    $(".js-prev").show();
  }
}
// else {
//   $(".js-next").hide();
// }
}

function setPrevious(){
  var prevId = parseInt($(".js-prev").attr("data-id")) - 1;
   $(".js-prev").show();
    // console.log($(".js-prev").attr("data-id"));
   if (prevId){

    $.get("/meals/" + prevId + ".json", function(data){

      var newMeal= new Meal(data["id"], data["name"], data["description"], data["calorie_count"], data["price"], data["category"] );
      // console.log(data["name"])
       $("#mealName").html(newMeal["name"]);
       $("#mealDescription").html(newMeal["description"]);
       $("#mealPrice").html("$" + parseInt(newMeal["price"]).toFixed(2));
       $("#mealCalories").html("Calories: " + newMeal["calorie_count"]);
       $(".js-prev").attr("data-id", newMeal["id"]);
       $(".js-next").attr("data-id", parseInt(newMeal["id"]) + 1);
  })
}
else {
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
  var  url = $(this).attr("href")
  // console.log(url)
  e.preventDefault();
  $.get(`${url}.json`, function(response){
    // console.log(response)

    var newMeal= new Meal(response["id"], response["name"], response["description"], response["calorie_count"], response["price"], response["category"] );


    $(`td.mealDescription-${newMeal["id"]}`).html(newMeal.summary()).toggle();
  })
}
//////////////////////////////////////////////////////////////////////////////////////////////////

// on the trips page for the admin (Customer Orders) when you click on a user's order the list of meals and their price is displayed underneath it.

function custOrders(){
  var meals = document.getElementsByClassName("userMeals");
  for (i=0; i<meals.length; i++){
    meals[i].addEventListener("click", getMeals);
  }
}

function getMeals(e){
  e.preventDefault();
  // alert("clicked")
  dataId = $(this).data("id")
  // console.log(dataId);
  $.get(`/trips/${dataId}.json`, function(response){
    // console.log(response);
    var list = ""

//    create tripMeal objects
      var tripMeal = new Trip(response["id"], new Date(response["date"]).toLocaleDateString(), response["meals"]);

      // console.log("Hello!" + response["id"])
    list = tripMeal.mealList2()
    // console.log(list)
  // }
  $(`td#mealDescription-${tripMeal["id"]}`).html(tripMeal.mealList2()).toggle();
  // console.log($(`td#mealDescription-${tripMeal["id"]}`));
// })


})
}
//////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// Review form - when submitted append the data to the review form page

function form(){
  $('form.form-review').submit(function(e) {
    e.preventDefault();
    var values = $(this).serialize();

     var reviewPosting = $.post('/reviews', values);
    // console.log(values);

    reviewPosting.done(function(data) {
      // var review = data;

      function Review(id, title, comment, datePosted, userEmail) {
        this.title = title;
        this.comment = comment;
        this.datePosted = datePosted;
        this.userEmail = userEmail;
      }

    var review = new Review(data["id"], data["title"], data["comment"], new Date(data["date_posted"]).toLocaleDateString(), data["user"]["email"])

        console.log(review);
        // console.log(review["comment"]);
        $("#reviewTitle").text(review["title"]);
        $("#reviewComment").text(review["comment"]);
        $("#reviewDate").text("Date: " + review["datePosted"]);
        $("#reviewUser").text("User: " + review["userEmail"]);

        $('form.form-review')[0].reset

        return false;



      });
    })
  }
}
