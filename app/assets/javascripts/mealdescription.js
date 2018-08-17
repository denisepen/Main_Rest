// $(document).ready(listeners);
///////////////////////////////////////////////////////////////////////////////////
// moved to index.js
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
    alert(response["description"] + "Calorie Count: " + response["calorie_count"])
  })
}
/////////////////////////////////////////////////////////////////////////////////////
