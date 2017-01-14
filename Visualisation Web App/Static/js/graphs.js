d3.json("/data", function makeGraphs(error, projectsJson, publication) {
	
	//Clean projectsJson data
	var dailymailtest = projectsJson;
	//console.log(publication);
	var dateFormat = d3.time.format("%m %e %Y");
	dailymailtest.forEach(function(d) {
		d["date_time"] = Date.parse(d["date_time"]);
		//alert(d["date_time"])
	});

	//Create a Crossfilter instance
	var ndx = crossfilter(dailymailtest);

	//Define Dimensions
	var dateDim = ndx.dimension(function(d) { return d["date_time"]; }); // date dim
	var AuthorDim = ndx.dimension(function(d) { return d["author"]; });
	var headlinesDim = ndx.dimension(function(d) { return d["head_line"]; });
	var totalSentDim  = ndx.dimension(function(d) { return d["sent_val"]; });


	//set groups
	//AuthorDim.filterFunction(["Reuters"])

	//var test_array = []
	var headlinesPerDate = dateDim.group(); // date group
	var AuthorType = AuthorDim.group();
	var all = ndx.groupAll();
	var totalSent = ndx.groupAll().reduceSum(function(d) {return d["sent_val"];});
	//console.log(all)
	//var num = AuthorDim.group().reduceCount().value();
	//var numProjectsByAuthor = ndx.groupAll().reduceCount().value();
	//console.log(numProjectsByAuthor);
	
	//area for testing - check buttons for filtering
	/*----------------------------------------------------------

	  // BoE: add new day dimension
	  //var typeFilterDim = ndx.dimension(function(d) { return d["author"]; });

	  //var authorDim = typeFilterDim.group(function(d) { return d["author"]; });
  		
  		//var dayNumber = flight.dimension(function(d) { return d.date.getDay(); });

  		//var dayNumbers = dayNumber.group(function(d) { return d; });


  		  //var auth_var = { 
        //AP: { state: true, authNumber: 1, order: 0 },  
        //PA: { state: true, authNumber: 2, order: 1 }, 
        //Reuters: { state: true, authNumber: 3, order: 2 }, 
        //TDM: { state: true, authNumber: 4, order: 3 }, 
        //TG: { state: true, authNumber: 5, order: 4 },
        //TIT: { state: true, authNumber: 6, order: 5 },
        //TNT: { state: true, authNumber: 0, order: 6 }
      //}, authNumbers = (function() { var obj = {}; Object.keys(auth_var).forEach(function(d) { var key = auth_var[d].typeFilterDim; var value = d; obj[key] = value }); return obj; })()


	  d3.selectAll("input[type=checkbox][name=source]")
	    .property("checked", function(d, i, a) {
	      var elem = d3.select(this);
	      var day = elem.property("value");
	      //console.log("elem", elem, "day", day, auth_var[day])
	      //return auth_var[day].state;

	    })
	    .on("change", function() {
	      var elem = d3.select(this);
	      var checked = elem.property("checked");
	      var day = elem.property("value");
	      //auth_var[day].state = checked;
	      console.log("day", day)

	      var index = test_array.indexOf(day);

	      if (index > -1) {test_array.splice(index, 1);
	      	console.log(test_array)
	      	AuthorDim.filterRange(test_array)
	      	//if (test_array.length < 1) {
	      		//AuthorDim.filterAll();
	      		//console.log("filter all")
				}//}
	      else {test_array.push(day);
	      	console.log(test_array)
	      	AuthorDim.filterRange(test_array)

	      	//headlinesPerDate = AuthorDim.filterRange([test_array])
	      }
	      

	      //updateSourceSelection();
	      //console.log("elem", elem, "day", day, auth_var[day])
	      dc.renderAll();
	    })



	//----------------------------------------------------------*/


//console.log("Keeps going")
//After analysis I decided to hard code the start date
	var minDate = 1455500000000;
	var maxDate = dateDim.top(1)[0]["date_time"];
//console.log(minDate)
//console.log(maxDate)

	//Set the charts attributes & features
	var timeChart = dc.barChart("#time-chart");
	var numberProjectsND = dc.numberDisplay("#number-projects-nd");
	var numberauthorsND = dc.rowChart("#number-headlines-nd");
	var totalSentND = dc.numberDisplay("#total-sent-nd");


	timeChart
    .width(1550)
    .height(360)
    .margins({top: 10, right: 50, bottom: 30, left: 50})
    .dimension(dateDim)
    .group(headlinesPerDate)
    .transitionDuration(500)
    .x(d3.time.scale().domain([minDate, maxDate]))
    .elasticY(true)
    .xAxisLabel("Day")
    .yAxisLabel("Number of Articles")
    .yAxis().ticks(6);
    

	numberProjectsND
    .formatNumber(d3.format("d"))
    .valueAccessor(function(d){return d; })
    .group(all);

    totalSentND
    .formatNumber(d3.format(".4n"))
    .valueAccessor(function(d){return d; })
    .group(totalSent);
    //.formatNumber(d3.format(".3s"));
    

    numberauthorsND
    .width(1150)
	.height(350)
    .dimension(AuthorDim)
    .elasticX(true)
    .group(AuthorType)
    .xAxis().ticks(10);


	dc.renderAll();

});

/*
function load_button(publication) {
    return function load_it() {
        d3.json("/data", function(error, projectsJson) {
            dc.redrawAll();
        });
    };
}
var button1 = load_button("All"),
    button2 = load_button("Reuters"),
    button3 = load_button("AP");*/