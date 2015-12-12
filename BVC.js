<!-- //
function TogglePanel( panelName, controllerName ) {

	var panel = document.getElementById(panelName);
	var c = document.getElementById(controllerName);
	
	if (panel.style.display=="block")
	{
		panel.style.display="none";
		c.src='../images/CarrotClosed.gif';
	}
	else
	{
		panel.style.display="block";
		c.src='../images/CarrotOpen.gif';
	}	
	
	return false;
}

function ToggleByCheckbox( panelName, controllerName ) {

	var panel = document.getElementById(panelName);
	var c = document.getElementById(controllerName);
	
	if (c.checked==true)
	{
		panel.style.display="block";
	}
	else
	{
		panel.style.display="none";
	}	
		
	return false;
}

function toggle(id)
		{					
		  var c = document.getElementById(id);
		  if (c.style.display == "") {
     		c.style.display = "none";				
		  }
		  else {				
			c.style.display = "";				
		  }
		}		

			function textCounter(field, countfield, maxlimit) {
				if (field.value.length > maxlimit) // if too long...trim it!
				field.value = field.value.substring(0, maxlimit);
				// otherwise, update 'characters left' counter
			else 
				countfield.value = maxlimit - field.value.length;
			}
			
function doPrint() { 
	if (window.print) { 
	window.print(); 
	} else { 
	alert('Please choose the print button from your browser.  Usually in the menu dropdowns at File: Print'); 
	} 
} 
						
function ToggleAllCheckBoxes(checkBoxName, isChecked)
{            
    var checkBoxes = document.documentElement.getElementsByTagName("input");
    for (var i = 0; i < checkBoxes.length; i++){
        if (checkBoxes[i].id.search(checkBoxName) > -1){
            checkBoxes[i].checked = isChecked;
        }                
    }
    return false;
}
         
function ListBoxValue(l) {
	var list = document.getElementById(l);
	var v = list[list.selectedIndex].value;	
	return v;
}

var count = 0;
function Anthem_PreCallBack() { 
    count++;
    setTimeout("CallBackStarted()", 500); 
}
function Anthem_PostCallBack() { CallBackFinished(); }

function CallBackStarted() {
  if (count > 0){  
    var item = document.getElementById('wait');
    if ((!window.XMLHttpRequest) && (document.documentElement)){
      item.style.position = 'absolute';
      //code to make ie6 behave
      if (document.documentElement.scrollTop){
        item.style.top = document.documentElement.scrollTop + 15;
      }
      else{ item.style.top = 15; }      
      item.style.right = 15;
    }
    item.style.display = 'block';    
  }
}
 
function CallBackFinished(){
  count--;
  if (count == 0){
    var item = document.getElementById('wait');
    if (item != null){
        item.style.display = 'none';
    }
  }
}

// End -->
	