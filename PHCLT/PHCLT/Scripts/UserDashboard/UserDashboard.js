$(document).ready(function () {
  
    var currentDate = new Date();

    currentDate.setMonth(currentDate.getMonth() + 1, 0);
    
    var formattedDate = currentDate.toISOString().split('T')[0];

    document.getElementById('todate').value = formattedDate;
});
$("#btnsave").click(function () {
    fetchDataAndPopulateTable();
});
function fetchDataAndPopulateTable() {
    var fdate = $("#fromdate").val();
    var tdate = $("#todate").val();
    var customerId = $("#hdnUserId").val();

    $.ajax({
        url: `/Reports/GetDailyReportDataById?fromdate=${fdate}&&todate=${tdate}&&customerId=${customerId}`,         
        method: 'GET',        
        success: function (data) {
            // Call a function to populate the table with the retrieved data
            var dataArray = JSON.parse(data);
            populateTable(dataArray);
        },
        error: function (error) {
            console.error(error);
            // Handle the error
        }
    });
}

function populateTable(data) {
    if ($.fn.DataTable.isDataTable('#example1')) {
        $('#example1').DataTable().destroy();
    }
    var tbody = $('#example1 tbody');
    tbody.empty(); // Clear existing rows

    console.log("Data:", data);
    console.log("Type of data:", typeof data);
    
    if (Array.isArray(data)) {
        // Data is an array, loop through it
        $.each(data, function (index, item) {
            var row = $('<tr>');
            $.each(item, function (key, value) {
                row.append($('<td>').text(value));
            });
            tbody.append(row);
        });
    } else if (typeof data === 'object') {
        // Data is a single object, create a row for it
        var row = $('<tr>');
        $.each(data, function (key, value) {
            row.append($('<td>').text(value));
        });
        tbody.append(row);
    }
    
    $("#example1").DataTable({
        "responsive": true, "lengthChange": false, "autoWidth": false,
        "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
    }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
    $('#example2').DataTable({
        "paging": true,
        "lengthChange": false,
        "searching": false,
        "ordering": true,
        "info": true,
        "autoWidth": false,
        "responsive": true,
    });
}


