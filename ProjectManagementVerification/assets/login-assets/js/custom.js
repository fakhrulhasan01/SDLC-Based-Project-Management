		$(".settings").click(function(){
			//alert("Hi");
			//$(this).css("right","200px");
			var content = $(this);
			var contentRight = parseInt(content.css("right"));
				if(contentRight == 0){
					content.css("right","200px");
				}else{
					content.css("right","0px");
				}
			$(".expand-settings-content").toggle(function(){
				//if(content.cs=="")
				
			});
		});
		
		$(".red").click(function(){
			$(".panel-body").css("background-color","red");
		});
		$(".green").click(function(){
			$(".panel-body").css("background-color","green");
		});
		$(".blue").click(function(){
			$(".panel-body").css("background-color","blue");
		});
		$(".common").click(function(){
			$(".panel-body").css("background-color","#ffffff");
		});
		
		setInterval(function(){
			
			var width = $("body").width();
			//alert(width);
			var width = parseInt(width);
			if(width>=1100){
				//alert("Hi");
				$("#size").css("width","36%");
				$(".input-header-container").css("margin-left","4%");				
			}else if(width<1100 && width>1000){
				$("#size").css("width","40%");
				$(".input-header-container").css("margin-left","4%");				
			}else if(width<1000 && width>900){
				$("#size").css("width","46%");
				$(".input-header-container").css("margin-left","4%");				
			}else if(width<900 && width>800){
				$("#size").css("width","50%");
				$(".input-header-container").css("margin-left","4%");				
			}else if(width<800 && width>700){
				$("#size").css("width","58%");
				$(".input-header-container").css("margin-left","4%");				
			}else if(width<700 && width>600){
				$("#size").css("width","64%");
				$(".input-header-container").css("margin-left","3%");				
			}else if(width<600 && width>500){
				$("#size").css("width","72%");
				$(".input-header-container").css("margin-left","3%");
			}else if(width<500 && width>400){
				$("#size").css("width","80%");
				$(".input-header-container").css("margin-left","2%");				
			}else if(width<400){
				$("#size").css("width","88%");
				$(".input-header-container").css("margin-left","2%");				
			}
		}, 200);