
var statisticalModule = function(){
		return{
		/*
		@title: Request keywords used by the authors.
		@goal: Request to the control layer the data from the number of times that the keywords were used by the authors.
		@context:
			localization: control layer.
			precondition: SHOW STATISTICAL DATA PAGE.
		@actors: system.
		@resources: type of query to be performed
		*/

		keywordsUsedByAuthor: function() {


		//@episode 1: CONTROL REQUEST STATISTICAL QUERY.
			$.getJSON("../controller/statistical_data.lp", {statistical_query: "keywordsUsedByAuthor"}, function (data){
		        	
		        $.each(data, function (key,val) {
		//@episode 2: For each result row, adds an row to the table to shows the data.
					$("#keywords_used_table").find("tbody:last").append("<tr><td>"+val.author+"</td><td>"+val.k+"</td><td>"+val.contador+"</td></tr>");
					
				});	

		        
		    });
		}
	}
}();	