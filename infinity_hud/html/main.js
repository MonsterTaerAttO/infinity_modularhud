window.addEventListener("message", function (event) {
  switch (event.data.action) {

    case "intialization":
      var elemHealth = $('.mainHealth')[0];
      var elemArmor = $('.mainArmor')[0];
      var elemFuel = $('.hudCar')[0];
      elemHealth.style.left = event.data.healthleft + "%";
      elemHealth.style.bottom = event.data.healthbottom + "%";

      elemArmor.style.left = event.data.armorleft + "%";
      elemArmor.style.bottom = event.data.armorbottom + "%";

      elemFuel.style.left = event.data.fuelleft + "%";
      elemFuel.style.bottom = event.data.fuelbottom + "%";
      break;

    case "edithealth":
      var elem = $('.mainHealth')[0];
      elem.style.left = event.data.left + "%";
      elem.style.bottom = event.data.bottom + "%";
      break;

    case "editarmor":
      var elem = $('.mainArmor')[0];
      elem.style.left = event.data.left + "%";
      elem.style.bottom = event.data.bottom + "%";
      break;

    case "editfuel":
      var elem = $('.hudCar')[0];
      elem.style.left = event.data.left + "%";
      elem.style.bottom = event.data.bottom + "%";
      break;



    case "huddis":
      Progress(event.data.health, ".health");
      Progress(event.data.armor, ".armor");
      if (event.data.showhud == true) {
        $(".mainHealth").fadeIn();
        $(".mainArmor").fadeIn();
        Progress(event.data.health, ".health");
      } else {
        $(".mainHealth").fadeOut();
        $(".mainArmor").fadeOut();
      }
      break;

    case "car":
      if (event.data.showhud == true) {
        $(".hudCar").fadeIn();
        setProgressFuel(event.data.fuel, ".progress-fuel");
      } else {
        $(".hudCar").fadeOut();
      }
      break;
      
  }
});

function Progress(percent, element) {
  var circle = document.querySelector(element);
  var radius = circle.r.baseVal.value;
  var circumference = radius * 2 * Math.PI;
  var html = $(element).parent().parent().find("span");

  circle.style.strokeDasharray = `${circumference} ${circumference}`;
  circle.style.strokeDashoffset = `${circumference}`;

  const offset = circumference - ((-percent * 100) / 100 / 100) * circumference;
  circle.style.strokeDashoffset = -offset;

  html.text(Math.round(percent));
}

function setProgressFuel(percent, element) {
  var circle = document.querySelector(element);
  var radius = circle.r.baseVal.value;
  var circumference = radius * 2 * Math.PI;
  var html = $(element).parent().parent().find("span");

  circle.style.strokeDasharray = `${circumference} ${circumference}`;
  circle.style.strokeDashoffset = `${circumference}`;

  const offset = circumference - ((-percent * 73) / 100 / 100) * circumference;
  circle.style.strokeDashoffset = -offset;

  html.text(Math.round(percent));
}
