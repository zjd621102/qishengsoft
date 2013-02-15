function addRow() {
	var row_end = document.getElementById("IDEndRow");
	var row_copy = document.getElementById("IDCopyRow");
	var row_temp = row_copy.cloneNode(true);
	row_temp.style.display = "";
	row_end.insertAdjacentElement("beforeBegin", row_temp);
}

function delRow(){
	var row = event.srcElement.parentElement.parentElement.parentElement.parentElement;
	var table = row.parentElement;
	var i = row.rowIndex;
	table.deleteRow(i);
}