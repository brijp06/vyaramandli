$(document).ready(function () {
        $("#example1").DataTable({
            "responsive": true, "lengthChange": false, "autoWidth": false,
            "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

        var table = $('#example1').DataTable();

    const urlParams = new URLSearchParams(window.location.search);

    // Get the value of the 'param' parameter
    const subCenterId = urlParams.get('subCenterId');

    if (subCenterId && Number(subCenterId) > 0) {
        $('#hdnSubCenterId').val(subCenterId);
        $('#isEdit').val('true');
        showEditButton();
        $('#txtSubCenterDetailsId').val(subCenterId);
        getSubCenterById();
    }

    function validateForm(){
        if ($('#cmbrPHCCenter').val() == undefined || $('#cmbrPHCCenter').val() == '' || $('#cmbrPHCCenter').val() == '0') {
            alert('Please Select a PHC Center');
            return false;
        }
        else if ($('#txtSubCenterDetailsName').val() == undefined || $('#txtSubCenterDetailsName').val() == '') {
            alert('Please Enter Sub Center Name');
            return false;
        }

        return true;
    }

    $('#saveSubCenter').on('click', function () {
        insertSubCenterDetails();
    });
    
    function insertSubCenterDetails() {
        if (validateForm()) {
            $("#loader").show();
            var request = {
                PHCId: $('#cmbrPHCCenter').val(),
                UserId: $('#hdnUserId').val(),
                SubCenterName: $('#txtSubCenterDetailsName').val(),
                villageid: $('#cmbvillagename').val()
            };

            $.ajax({
                url: '/PHCdetail/InsertSubCenterDetails',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(request),
                success: function (result) {
                    $("#loader").hide();
                    Toast.fire({
                        icon: 'success',
                        title: 'Sub Center Added Successfully.'
                    })
                    $('#txtSubCenterDetailsName').val('');
                },
                error: function (error) {
                    console.error('Error:', error.responseJSON.error);
                    $("#loader").hide();
                }
            });
        }
       
    }

    $('#updateSubCenter').on('click', function () {
        updateSubCenterDetails();
    });

    function updateSubCenterDetails() {
        if (validateForm()) {
            $("#loader").show();
            var request = {
                PHCId: $('#cmbrPHCCenter').val(),
                UserId: $('#hdnUserId').val(),
                SubCenterName: $('#txtSubCenterDetailsName').val(),
                SubCenterDetailsId: $('#hdnSubCenterId').val(),
                villageid:$('#cmbvillagename').val()
            };

            $.ajax({
                url: '/PHCdetail/UpdateSubCenterDetails',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(request),
                success: function (result) {
                    $("#loader").hide();
                    Toast.fire({
                        icon: 'info',
                        title: 'Sub Center Updated Successfully.'
                    })
                    $('#txtSubCenterDetailsName').val('');
                },
                error: function (error) {
                    console.error('Error:', error.responseJSON.error);
                    $("#loader").hide();
                }
            });
        }

    }

    $('#resetSubCenter').on('click', function () {
        const url = `/PHCdetail/SubCenterList`;
        window.location.href = url;
    });

    function getSubCenterById() {
        $("#loader").show();
        $.ajax({
            url: `/PHCdetail/GetSubCenterById?SubCenterDetailsId=${$('#hdnSubCenterId').val()}`,
            type: 'GET',
            contentType: 'application/json',
            success: function (result) {
                if (result && result.length > 0) {
                    $('#cmbrPHCCenter').val(result[0].PHCId);
                    $('#hdnvillageId').val(result[0].villageid);
                    $('#cmbrPHCCenter').trigger('change');
                    $('#txtSubCenterDetailsName').val(result[0].SubCenterName);
                
                }
                $("#loader").hide();

            },
            error: function (error) {
                console.error('Error:', error.responseJSON.error);
                $("#loader").hide();
            }
        });
    }

    function showEditButton() {
        $('#updateSubCenter').show();
        $('#saveSubCenter').hide();
        $('#resetSubCenter').show();
    }
    var Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000
    });


});



