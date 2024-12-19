$(document).ready(function () {
        $("#example1").DataTable({
            "responsive": true, "lengthChange": false, "autoWidth": false,
            "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

        var table = $('#example1').DataTable();

    $('#saveSubCenterEmp').on('click', function () {
        if ($('#hdnSubCenterEmployeeId').val()) {
            updateSubCenterEmployee();
        }
        else {
            insertSubCenterEmployee();
        }
    });

    $('#btnReset').on('click', function () {
        location.reload();
    });

    function validateForm() {
        
        var phcCenter = $('#cmbrPHCCenter').val();
        if (phcCenter == undefined || phcCenter == '0') {
            alert('Please select a PHC Center.');
            return false;
        }

        var villageName = $('#cmbvillagename').val();
        if (villageName == undefined || villageName == '0') {
            alert('Please select a Sub Center Village Name.');
            return false;
        }

        var subCenter = $('#cmbSubCenter').val();
        if (subCenter == undefined || subCenter == '0') {
            alert('Please select a Sub Center.');
            return false;
        }

        var designation = $('#cmbrDesignation').val();
        if (designation == undefined || designation == '0') {
            alert('Please select a Designation.');
            return false;
        }

        var employeeName = $('#txtEmployeeName').val();
        if (employeeName.trim() == '') {
            alert('Please enter Employee Name.');
            return false;
        }
        return true;
    }

    function insertSubCenterEmployee() {

        if (validateForm()) {
            $("#loader").show();
            var PHCId = $('#cmbrPHCCenter').val();
            var VillageId = $('#cmbvillagename').val();
            var SubCenterDetailsId = $('#cmbSubCenter').val();
            var EmployeeName = $('#txtEmployeeName').val();
            var DesgnationId = $('#cmbrDesignation').val();

            $.ajax({
                url: '/SubCenterEmp/InsertSubCenterEmployee',
                type: 'POST',
                data: {
                    PHCId: PHCId,
                    VillageId: VillageId,
                    SubCenterDetailsId: SubCenterDetailsId,
                    EmployeeName: EmployeeName,
                    DesgnationId: DesgnationId
                },
                success: function (result) {
                    $("#loader").hide();
                    Swal.fire({
                        title: "Success",
                        text: "Employee has been added",
                        icon: "success"
                    }).then((result) => {
                        location.reload();
                    });
                },
                error: function (error) {
                    $("#loader").hide();
                    console.error('Error:', error.responseText);
                }
            });
        }

    }

    // Update SubCenterEmployee
    function updateSubCenterEmployee() {

        if (validateForm()) {
            $("#loader").show();

            var SubCenterEmployeeId = $('#hdnSubCenterEmployeeId').val();
            var PHCId = $('#cmbrPHCCenter').val();
            var VillageId = $('#cmbvillagename').val();
            var SubCenterDetailsId = $('#cmbSubCenter').val();
            var EmployeeName = $('#txtEmployeeName').val();
            var DesgnationId = $('#cmbrDesignation').val();


            $.ajax({
                url: '/SubCenterEmp/UpdateSubCenterEmployee',
                type: 'POST',
                data: {
                    SubCenterEmployeeId: SubCenterEmployeeId,
                    PHCId: PHCId,
                    VillageId: VillageId,
                    SubCenterDetailsId: SubCenterDetailsId,
                    EmployeeName: EmployeeName,
                    DesgnationId: DesgnationId
                },
                success: function (result) {
                    $("#loader").hide();
                    Swal.fire({
                        title: "Success",
                        text: "Employee has been Updated",
                        icon: "success"
                    }).then((result) => {
                        location.reload();   
                    });                    
                },
                error: function (error) {
                    $("#loader").hide();
                    console.error('Error:', error.responseText);
                }
            });
        }
        
    }


});

function getVillage(Phcid) {
    $("#loader").show();
    $.ajax({
        url: '/SubCenterEmp/GetVillageList?Phcid=' + Phcid,
        type: 'GET',
        contentType: 'application/json',
        success: function (result) {
            if (result && result.length > 0) {
                $('#cmbvillagename').empty();
                
                if (result && result.length > 0) {
                    $('#cmbvillagename').append('<option value="0">Please Select a Village</option>');
                    result.forEach(function (villmast) {
                        $('#cmbvillagename').append('<option value="' + villmast.VillageMasterId + '">' + villmast.VillageName + '</option>');
                    });
                } else {
                    cmbTaluka.append('<option value="0">No Village found</option>');
                }

                $('#cmbvillagename').val(result.length > 0 ? result[0].VillageMasterId : '');

                if ($('#hdnvillageId').val()) {
                    $('#cmbvillagename').val($('#hdnvillageId').val());
                }

                $('#cmbvillagename').trigger('change');
                $("#loader").hide();
            } else {
                console.log('No Village found.');
                $("#loader").hide();
            }
        },
        error: function (error) {
            $("#loader").hide();
            console.error('Error:', error.responseText);
        }
    });
}

function getSubCenters(villageId) {

    if ($('#cmbrPHCCenter').val() > 0 && villageId > 0) {
        $("#loader").show();
        $.ajax({
            url: '/SubCenterEmp/GetSubCenterList?Phcid=' + $('#cmbrPHCCenter').val() + '&VillageId=' + villageId,
            type: 'GET',
            contentType: 'application/json',
            success: function (result) {
                if (result && result.length > 0) {
                    $('#cmbSubCenter').empty();

                    if (result && result.length > 0) {
                        $('#cmbSubCenter').append('<option value="0">Please Select a Sub Center</option>');
                        result.forEach(function (subCenter) {
                            $('#cmbSubCenter').append('<option value="' + subCenter.SubCenterDetailsId + '">' + subCenter.SubCenterName + '</option>');
                        });
                    } else {
                        cmbTaluka.append('<option value="0">No Sub Center found</option>');
                    }

                    $('#cmbSubCenter').val(result.length > 0 ? result[0].VillageMasterId : '');

                    if ($('#hdnSubCenter').val()) {
                        $('#cmbSubCenter').val($('#hdnSubCenter').val());
                    }
                    $('#cmbSubCenter').trigger('change');
                    $("#loader").hide();
                } else {
                    $("#loader").hide();
                    console.log('No Sub Center found.');
                }
            },
            error: function (error) {
                $("#loader").hide();
                console.error('Error:', error.responseText);
            }
        });
    }

}

function getSubCenterEmpList(subCenterEmployeeId) {
    $("#loader").show();
    $.ajax({
        url: '/SubCenterEmp/GetSubCenterEmpList',
        type: 'GET',
        data: {
            subCenterEmployeeId: subCenterEmployeeId
        },
        success: function (result) {
            console.log(result);
            if (result && result.length > 0) {
                setHiddenForm(subCenterEmployeeId, result[0].VillageId, result[0].PHCId, result[0].DesgnationId, result[0].SubCenterDetailsId, result[0].EmployeeName);
            }
            $("#loader").hide();
        },
        error: function (error) {
            $("#loader").hide();
            console.error('Error:', error.responseText);
        }
    });
}

function deleteSubCenterEmployee(subCenterEmployeeId) {

    Swal.fire({
        title: "Are you sure? You Want to Delete this?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!"
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: '/SubCenterEmp/DeleteSubCenterEmployee',
                type: 'GET',
                data: {
                    SubCenterEmployeeId: subCenterEmployeeId
                },
                success: function (result) {
                    $("#loader").hide();
                    Swal.fire({
                        title: "Success",
                        text: "Employee Has Been Deleted",
                        icon: "success"
                    }).then((result) => {
                        location.reload();
                    });
                },
                error: function (error) {
                    $("#loader").hide();
                    console.error('Error:', error.responseText);
                }
            });
        }
    });

}

var Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000
});

function setHiddenForm(hdnSubCenterEmployeeId = 0, hdnvillageId = 0, hdnPHCCenter = 0, hdnDesignation = 0, hdnSubCenter = 0, txtEmployeeName = '') {
    if (hdnSubCenterEmployeeId != 0) {
        $('#hdnSubCenterEmployeeId').val(hdnSubCenterEmployeeId);
        $('#hdnvillageId').val(hdnvillageId);
        $('#hdnPHCCenter').val(hdnPHCCenter);        
        $('#hdnDesignation').val(hdnDesignation);
        $('#hdnSubCenter').val(hdnSubCenter);
        $('#txtEmployeeName').val(txtEmployeeName);

        $('#cmbrPHCCenter').val(hdnPHCCenter);
        $('#cmbrPHCCenter').trigger('change');

        $('#cmbvillagename').val(hdnvillageId);
        $('#cmbvillagename').trigger('change');

        $('#cmbrDesignation').val(hdnDesignation);
        $('#cmbrDesignation').trigger('change');

        $('#cmbSubCenter').val(hdnSubCenter);
        $('#cmbSubCenter').trigger('change');
    }
    else {
        $('#hdnSubCenterEmployeeId').val('');
        $('#hdnvillageId').val('');
        $('#hdnPHCCenter').val('');
        $('#hdnDesignation').val('');
        $('#hdnSubCenter').val('');
        $('#txtEmployeeName').val('');
    }
}



