
// When you click on a meal name the description and calorie count are displayed
// $(document).ready(listeners);
function listeners(){
  var meals = document.getElementsByClassName("descrip")

  for (i=0; i<meals.length; i++){
    meals[i].addEventListener("click", getDescription);
  }
}

function getDescription(e){
  url = $(this).attr("href")
  console.log(url)
  e.preventDefault();
  $.get(`${url}.json`, function(response){
    console.log(response)
    alert(response["description"] + "  Calorie Count: " + response["calorie_count"])
  })
}

listeners();




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
