$(document).ready(function () {
        $("#example1").DataTable({
            "responsive": true, "lengthChange": false, "autoWidth": false,
            "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

        var table = $('#example1').DataTable();

    const urlParams = new URLSearchParams(window.location.search);

    // Get the value of the 'param' parameter
    const paramValue = urlParams.get('param');

});

function deleteSubCenterById() {
    
        $("#loader").show();
        $.ajax({
            url: `/PHCdetail/DeleteSubCenterDetails?SubCenterDetailsId=${$('#hdnSubCenterId').val()}`,
            type: 'GET',
            success: function (result) {
                $("#loader").hide();
                Swal.fire({
                    title: "Deleted!",
                    text: "Sub Center Deleted Successfully.",
                    icon: "error"
                });
                location.reload();
            },
            error: function (error) {
                console.error('Error:', error.responseJSON.error);
                $("#loader").hide();
            }
        });


}

function deleteSubCenter(subCenterId) {
    $('#hdnSubCenterId').val(subCenterId);
    Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!"
    }).then((result) => {
        if (result.isConfirmed) {
            deleteSubCenterById();
        }
    });
}
function editSubCenter(subCenterId) {
    if (subCenterId && subCenterId > 0) {
        const url = `/PHCdetail/SubCenter?subCenterId=${subCenterId}`;
        window.location.href = url;
    }
}


