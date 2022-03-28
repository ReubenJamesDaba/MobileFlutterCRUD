$(document).ready( function () {
    main();

	$('body').on('click','#testtrial',function(){
		var data = {
			app_id : "ee2acab7-1e98-48f4-9fde-0b457de23368",
			contents :{"en": "Test Push notif"},
				included_segments: ["All"],
				content_available: true,
				small_icon : "ic_notification_icon",
				data : {
					PushTitle: "Custom Notification",
	
				}
		}

		var headers = {
			"Content-Type" : "application/json; charset=utf-8",
			Authorization : "Basic " + "MmEzZDdhM2ItMTcxOS00ZGNmLTg3ZTgtZmEzMzQwYzkwMmUy",
			"Access-Control-Allow-Origin": "*"
		}
	
		var options = {
			host : "onesignal.com",
			port: 443,
			path :"/api/v1/notifications",
			method: "POST",
			headers: headers
		}; 
		$.ajax({
			method: "POST",
			options,
			data : data,
			port: 443,
		}).done(function(res){
			console.log("aaaaa");
		}).fail(function(){
			console.log("An error occurred, the files couldn't be sent!");
		});
	  
	});
 });
 function main(){
	url = 'admin/event/view';
	
		data = {
			
		}
	$.ajax({
		method: "POST",
		url : base_url+url,
		data : data
	}).done(function(res){
		var result =  jQuery.parseJSON(res);
		pressure(result[0].bloodpressure);
		temperature(result[0].temperature);
		
	}).fail(function(){
		console.log("An error occurred, the files couldn't be sent!");
	});
	// temperature(temp);

	url = 'admin/event/oxygen';

		data = {
			
		}
	$.ajax({
		method: "POST",
		url : base_url+url,
		data : data
	}).done(function(res){
		var result =  jQuery.parseJSON(res);
		
		var oxy = [];
		for(var i=0;i<result.length;i++){
			
			oxy.push(result[i].oxygen);
			
		}
		
		oxygen(oxy);
		
	}).fail(function(){
		console.log("An error occurred, the files couldn't be sent!");
	});

 }


	var updateChart = function (count) {
		var press = [];
		var temps = [];
		
		url = 'admin/event/view';
	
			data = {
				
			}
		$.ajax({
			method: "POST",
			url : base_url+url,
			data : data
		}).done(function(res){
			var result =  jQuery.parseJSON(res);
			
			$("#p1b").text(result[0].bloodpressure+" bpm");
			press.push(result[0].bloodpressure);
			// int stem =  result[0].bloodpressure //Number(result[0].temperature).toFixed(2);
			// console.log(stem);
			 sa = parseFloat(result[0].temperature);
			temps.push(sa.toFixed(2));
			
			chart_blood.updateSeries([{
				data: press
			  }])
			chart_temp.updateSeries([temps]);
				console.log(result[0].temperature);
				if(result[0].temperature <= 38){
					var text = 'gray';
					var text2 =  'success';
					var text3 = 'light';
					var text4 = 'success'
				}else{
					var text = 'red';
					var text2 =  'danger';
					var text3 = 'dark';
					var text4 = 'danger'
				}
			chart_blood.updateSeries({
			plotOptions: {
				radialBar: {
					borderRadius: 4,
					startAngle: -90,
					endAngle: 90,	
					hollow: {
						margin: 0,
						size: "70%"
					},
					dataLabels: {
						showOn: "always",
						name: {
							show: true,
							fontFamily: 'inherit',
							fontSize: "13px",
							fontWeight: 500,
							offsetY: -4,
							color: KTUtil.getCssVariableValue('--bs-'+text+'-400')
						},
						value: {
							color: KTUtil.getCssVariableValue('--bs-'+text2+''),
							fontFamily: 'inherit',
							fontSize: "30px",
							fontWeight: 700,
							offsetY: -40,
							show: true																			
						}
					},
					track: {
						background: KTUtil.getCssVariableValue('--bs-'+text3+'-info'),
						strokeWidth: '100%'
					}
				}
			},colors: [KTUtil.getCssVariableValue('--bs-'+text4+'')],
			});

		}).fail(function(){
			console.log("An error occurred, the files couldn't be sent!");
		});

	};

	var updateOxygen = function(){
		url = 'admin/event/oxygen';

		data = {
			
		}
		$.ajax({
			method: "POST",
			url : base_url+url,
			data : data
		}).done(function(res){
			var result =  jQuery.parseJSON(res);
			
			var oxy = [];
			for(var i=0;i<result.length;i++){
				
				oxy.push(result[i].oxygen);
				
			}
			
			
			$("#oxy-text").text(oxy[0]+"%");
			chart_oxy.updateSeries([{
				
				data: oxy.reverse()
			  }])
		}).fail(function(){
			console.log("An error occurred, the files couldn't be sent!");
		});
	} 




setInterval(function(){updateChart()}, 1000);
setInterval(function(){updateOxygen()}, 1000);

var chart_blood;
var chart_temp;
var chart_oxy;
function pressure(p1){
	
	$("#p1b").text(p1 +" bpm");
	var element = document.getElementById("kt_mixed_widget_2_chartjhunes");

	if (!element) {
		return;
	}

	var height = parseInt(KTUtil.css(element, 'height'));

	var options = {
		series: [{
			name: 'Heart Rate',
			data: [p1]
		}],
		chart: {
			fontFamily: 'inherit',
			height: height,
			type: 'bar',
			toolbar: {
				show: false
			}
		},
		grid: {
			show: false,
			padding: {
				top: 0,
				bottom: -5
			}
		},
		plotOptions: {
			bar: {
				borderRadius: 10,
				dataLabels: {
					position: 'top', // top, center, bottom
				},
			}
		},
		dataLabels: {
			enabled: false,
			formatter: function(val) {
				return val;
			},
			offsetY: -20,
			style: {
				fontSize: '12px',
				colors: ["#304758"]
			}
		},

		xaxis: {
			labels: {
				show: false,
			},
			categories: ["P1", "P2"],
			position: 'top',
			axisBorder: {
				show: false
			},
			axisTicks: {
				show: false
			},
			crosshairs: {
				show: false
			},
			tooltip: {
				enabled: false,
			}
		},
		yaxis: {
			show: false,
			 
			axisTicks: {
				show: false,
			},
			labels: {
				show: false,
				formatter: function(val) {
					return val + "%";
				}
			}

		},
		title: {
			text: 'Blood Pressure of the Patient',
			floating: true,
			offsetY: 330,
			align: 'center',
			style: {    
				color: '#444'
			}
		}
	};
	
	chart_blood = new ApexCharts(element, options);
	chart_blood.render();
}

function temperature(temp){
	// temp =  temp.toFixed(2);
	// sa = parseFloat(result[0].temperature);
	// temp = SA/
	// temps.push(sa.toFixed(2));
	var text = 'red';
	var text2 =  'danger';
	var text3 = 'dark';
	var text4 = 'danger'
	if(temp <= 38){
		var text = 'gray';
		var text2 =  'success';
		var text3 = 'light';
		var text4 = 'success'
	}
	var temp_array = [temp];
	var element = document.getElementById("kt_mixed_widget_1_chartjhunes");

		if (!element) {
			return;
		}

		var height = parseInt(element.getAttribute('data-kt-height'));

		var options = {
			series: temp_array,
			chart: {
				fontFamily: 'inherit',
				height: height,
				type: 'radialBar',
                toolbar: {
					show: false
				}
			},
			grid: {
				padding: {
            		//top: 0
          		}
			},
			plotOptions: {
				radialBar: {
					borderRadius: 4,
					startAngle: -90,
					endAngle: 90,	
					hollow: {
						margin: 0,
						size: "70%"
					},
					dataLabels: {
						showOn: "always",
						name: {
							show: true,
							fontFamily: 'inherit',
							fontSize: "13px",
							fontWeight: 500,
							offsetY: -4,
							color: KTUtil.getCssVariableValue('--bs-'+text+'-400')
						},
						value: {
							color: KTUtil.getCssVariableValue('--bs-'+text2+''),
							fontFamily: 'inherit',
							fontSize: "30px",
							fontWeight: 700,
							offsetY: -40,
							show: true																			
						}
					},
					track: {
						background: KTUtil.getCssVariableValue('--bs-'+text3+'-info'),
						strokeWidth: '100%'
					}
				}
			},
			colors: [KTUtil.getCssVariableValue('--bs-'+text4+'')],
			stroke: {
				lineCap: "round"				
			},			 
			labels: ["Body Temperature"],
			grid: {
				padding: {
					bottom: 0						  
				}
			}
		};

		chart_temp = new ApexCharts(element, options);
		chart_temp.render();
}

function oxygen(oxy){
	$("#oxy-text").text(oxy[0]+"%");
	oxy = oxy.reverse();
	

	var charts = document.querySelectorAll('.statistics-widget-1-chartjhunes');
	
	[].slice.call(charts).map(function(element) {
		var height = parseInt(KTUtil.css(element, 'height'));

		if (!element) {
			return;
		}
		if(oxy[4]>=90){
			
			color = 'danger';
		}else{
			var color = element.getAttribute('data-kt-chart-color');
		}
	

		var labelColor = KTUtil.getCssVariableValue('--bs-' + 'gray-800');
		var baseColor = KTUtil.getCssVariableValue('--bs-' + color);
		var lightColor = KTUtil.getCssVariableValue('--bs-light-' + color);

		var options = {
			series: [{
				name: 'Respiration Rate',
				data: oxy
			}],
			chart: {
				fontFamily: 'inherit',
				type: 'area',
				height: height,
				toolbar: {
					show: false
				},
				zoom: {
					enabled: false
				},
				sparkline: {
					enabled: true
				}
			},
			plotOptions: {},
			legend: {
				show: false
			},
			dataLabels: {
				enabled: false
			},
			fill: {
				type: 'solid',
				opacity: 0.3
			},
			stroke: {
				curve: 'smooth',
				show: true,
				width: 3,
				colors: [baseColor]
			},
			xaxis: {
				categories: ['5', '4', '3', '2', '1'],
				axisBorder: {
					show: false,
				},
				axisTicks: {
					show: false
				},
				labels: {
					show: false,
					style: {
						colors: labelColor,
						fontSize: '12px'
					}
				},
				crosshairs: {
					show: false,
					position: 'front',
					stroke: {
						color: '#f30100',
						width: 1,
						dashArray: 3
					}
				},
				tooltip: {
					enabled: true,
					formatter: undefined,
					offsetY: 0,
					style: {
						fontSize: '12px'
					}
				}
			},
			yaxis: {
				min: 0,
				max: 100,
				labels: {
					show: false,
					style: {
						colors: labelColor,
						fontSize: '12px'
					}
				}
			},
			states: {
				normal: {
					filter: {
						type: 'none',
						value: 0
					}
				},
				hover: {
					filter: {
						type: 'none',
						value: 0
					}
				},
				active: {
					allowMultipleDataPointsSelection: false,
					filter: {
						type: 'none',
						value: 0
					}
				}
			},
			tooltip: {
				style: {
					fontSize: '12px'
				},
				y: {
					formatter: function(val) {
						return val + " %"
					}
				}
			},
			colors: [baseColor],
			markers: {
				colors: [baseColor],
				strokeColor: [lightColor],
				strokeWidth: 3
			}
		};

		chart_oxy = new ApexCharts(element, options);
		chart_oxy.render();
	});
}


