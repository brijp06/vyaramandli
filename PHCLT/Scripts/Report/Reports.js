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
    //var productTable = new DataTable('#productTable');
    //productTable.column(0).visible(false);
    //productTable.clear().draw();
    //var currentDate = new Date();

    //// Set the date to the last day of the current month
    //currentDate.setMonth(currentDate.getMonth() + 1, 0);

    //// Format the date to YYYY-MM-DD (required by the input type="date" field)
    //var formattedDate = currentDate.toISOString().split('T')[0];

    //// Set the default value for the input field
    //document.getElementById('todate').value = formattedDate;
    //fetchDataAndPopulateTable();

    $("#btnsave").click(function () {
        //fetchDataAndPopulateTable();
    });
    function fetchDataAndPopulateTable() {
        var fdate = $("#fromdate").val();
        var tdate = $("#todate").val();
        var acid = $("#hdnlid").val();


        $.ajax({
            url: '/Reports/getReportData', // Replace with your actual API endpoint
            data: { fromdate: fdate, todate: tdate, acid: acid }, // Change this line
            method: 'GET',
            dataType: 'json',
            success: function (result) {

                // productTable.row.add([0, result.membname, result.membrel, '', result.dethdate, 0, '<button type="button" class="btn btn-info editProduct">Edit</button> <button type="button" class="btn btn-danger deleteProduct">Delete</button>']).draw(false);
                productTable.clear().draw();

                // Loop through the result array and add each item to the table
                result.forEach(function (item) {
                    // Format the date string to a Date object, if needed
                    var formattedDate = item.Transdate; // Assuming item.Transdate is in 'dd/MM/yyyy' format

                    productTable.row.add([
                        item.Tranno,
                        formattedDate, // Display as is if already in 'dd/MM/yyyy' format
                        item.Remarks,
                        item.Receiptamt,
                        item.Paymentamt,
                        item.Balanceamt
                    ]).draw(false);
                });
            },
            error: function (error) {
                // Handle the error response
                console.log(error);
            }
        });
    }
});



