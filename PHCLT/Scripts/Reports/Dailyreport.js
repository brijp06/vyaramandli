$(document).ready(function () {
    //$("#example1").DataTable({
    //    "responsive": true, "lengthChange": false, "autoWidth": false,
    //    "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
    //}).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
    //$('#example2').DataTable({
    //    "paging": true,
    //    "lengthChange": false,
    //    "searching": false,
    //    "ordering": true,
    //    "info": true,
    //    "autoWidth": false,
    //    "responsive": true,
    //});
    var currentDate = new Date();

    // Set the date to the last day of the current month
    currentDate.setMonth(currentDate.getMonth() + 1, 0);

    // Format the date to YYYY-MM-DD (required by the input type="date" field)
    var formattedDate = currentDate.toISOString().split('T')[0];

    // Set the default value for the input field
    document.getElementById('todate').value = formattedDate;
});
$("#btnsave").click(function () {
    fetchDataAndPopulateTable();
});
function fetchDataAndPopulateTable() {
    var fdate = $("#fromdate").val();
    var tdate = $("#todate").val();



    $.ajax({
        url: 'GetdailyReportdata', // Replace with your actual API endpoint
        data: { fromdate: fdate, todate: tdate }, // Change this line
        method: 'GET',
        dataType: 'json',
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


