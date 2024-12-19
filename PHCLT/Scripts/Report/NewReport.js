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
    //var table = $('#example1').DataTable();

    // Custom sorting for dd/MM/yyyy format
    $.fn.dataTable.ext.type.order['date-dd-mm-yyyy-pre'] = function (d) {
        var parts = d.split('/');
        return new Date(parts[2], parts[1] - 1, parts[0]).getTime();
    };

    $(document).ready(function () {
        // Initialize DataTable for example1 with buttons and custom date sorting
        //var table1 = $('#example1').DataTable({
        //    "responsive": true,
        //    "lengthChange": false,
        //    "autoWidth": false,
        //    "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"],
        //    "columnDefs": [
        //        { "type": "date-dd-mm-yyyy", "targets": 0 } // Assuming the date column is at index 0
        //    ]
        //});
        //table1.buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

        //// Initialize DataTable for example2 with basic configuration
        //$('#example2').DataTable({
        //    "paging": true,
        //    "lengthChange": false,
        //    "searching": false,
        //    "ordering": true,
        //    "info": true,
        //    "autoWidth": false,
        //    "responsive": true,
        //    "columnDefs": [
        //        { "type": "date-dd-mm-yyyy", "targets": 0 } // Assuming the date column is at index 0
        //    ]
        //});
    });

});