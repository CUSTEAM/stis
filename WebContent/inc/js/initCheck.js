$.ajax({
	url: "initCheck?type=both",
	type: "GET",
	dataType: "json",
	success: function(data) {
		//剩餘題目多於0
		if(data.coansw>0){
			$.blockUI({
		        //message: '<Iframe class="border-radius:15px;" src="Coansw"; width="100%" height="100%" scrolling="yes " frameborder="0"></iframe>', 
				message: '<Iframe style="border-radius:15px;" id="coansw" src="Coansw"; width="100%" height="100%" frameborder="0"></iframe>', 
				css: {
		            	width: '90%', 
		                height:'80%',
		                top: '10%', 
		                left: '5%', 
		                right: '5%', 
		                border: 'none',
		                'border-radius':'15px',
	  					'box-shadow': '10px 10px 20px #000'
		        }
		    });		
			return;
		}
		//有問卷
		if(data.questMap!=null){
			//沒做
			if(data.questMap.reply==null)
			$.blockUI({
		        message: '<Iframe style="border-radius:15px;" id="QuestONE" src="QuestONE"; width="100%" height="100%" frameborder="0"></iframe>', 
				css: {
		            	width: '90%', 
		                height:'80%',
		                top: '10%', 
		                left: '5%', 
		                right: '5%', 
		                border: 'none',
		                'border-radius':'15px',
	  					'box-shadow': '10px 10px 20px #000'
		        }
		    });
			
		}
		
	}, error: function() {alert("ERROR!!!");}
});