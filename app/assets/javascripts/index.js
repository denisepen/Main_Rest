

function getMeals(){
   $.get("/meals.json"), function(response){
      console.log("Name: " + response["name"], "Price: " + response["price"] )
  }
}
