$(document).ready(function () {
        $("#example1").DataTable({
            "responsive": true, "lengthChange": false, "autoWidth": false,
            "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

        var table = $('#example1').DataTable();

    // Get today's date
    var today = new Date();

    // Format today's date as yyyy-mm-dd
    var formattedDate = today.toISOString().substr(0, 10);

    // Set the value of the date picker input field
    $('#txtEntryDate').val(formattedDate);

    $('#saveDailyEntry').on('click', function () {      
        if ($('#hdnDailyCollectionEntryId').val() > 0) {
            updateDailyCollectionEntries();
        }
        else {
            saveDailyCollectionEntries();
        }
    });

    $('#btnReset').on('click', function () {
        location.reload();
    });

    $(document).on('input', 'input[type="text"][id^="txtDaily"], input[type="text"][id^="txtHours24"]', function () {
        var inputId = $(this).attr('id');
        var idNumber = inputId.split('-')[1];
        var txtDailyId = 'txtDaily-' + idNumber;
        var txtHours24Id = 'txtHours24-' + idNumber;
        var txtTotalId = 'txtTotal-' + idNumber;
        var dailyGrandTotal = 0;
        var hour24GrandTotal = 0;
        var totalGrandTotal = 0;

        var txtDailyVal = parseFloat($('#' + txtDailyId).val()) || 0;
        var txtHours24Val = parseFloat($('#' + txtHours24Id).val()) || 0;

        var total = 0;

        if (inputId.startsWith('txtDaily')) {
            total = txtDailyVal + txtHours24Val;
        } else if (inputId.startsWith('txtHours24')) {
            var txtDailyVal = parseFloat($('#' + txtDailyId).val()) || 0;
            total = txtDailyVal + txtHours24Val;
        }

        $('#' + txtTotalId).val(total.toFixed(2));

        $('.txtDaily, .txtHours24, .txtTotal').each(function () {
            var value = parseFloat($(this).val()) || 0;
            var classes = $(this).attr('class');

            if (classes.includes('txtDaily')) {
                dailyGrandTotal += value;
            } else if (classes.includes('txtHours24')) {
                hour24GrandTotal += value;
            } else if (classes.includes('txtTotal')) {
                totalGrandTotal += value;
            }
        });


        $('#txtDailyGrandTotal').val(dailyGrandTotal.toFixed(2));
        $('#txtHour24GrandTotal').val(hour24GrandTotal.toFixed(2));
        $('#txtGrandTotal').val(totalGrandTotal.toFixed(2));
    });

    function validateInput() {
        var isValid = true;

        $('.txtDaily').each(function () {
            if (!$(this).val()) {
                alert('Daily is required');
                isValid = false;
                return false; 
            }
        });

        if (!isValid) return isValid; 

        $('.txtHours24').each(function () {
            if (!$(this).val()) {
                alert('Hour24 is required');
                isValid = false;
                return false; 
            }
        });

        if (!isValid) return isValid; 

        $('.txtTotal').each(function () {
            if (!$(this).val()) {
                alert('Total is required');
                isValid = false;
                return false;
            }
        });

        return isValid;
    }



    function saveDailyCollectionEntries() {

        if ($("#collectionForm").children() && $("#collectionForm").children().length > 0) {
            if (validateInput()) {
                var entries = [];
                var entriesCount = $("#collectionForm").children().length / 6;

                for (let index = 0; index < entriesCount; index++) {
                    var entry = {
                        SubCenterEmployeeId: $('#collectionForm').find("#txtEmployee" + "-" + index).data().subcenteremployeeid,
                        EntryDate: $('#txtEntryDate').val(),
                        Daily: Number($("#txtDaily-" + index).val()) ,
                        Hour24: Number($("#txtHours24-" + index).val()),
                        Total: Number($("#txtTotal-" + index).val()) 
                    };
                    entries.push(entry);
                }

                if (entries.length > 0) {

                    $("#loader").show();
                    $.ajax({
                        url: '/Transaction/InsertDailyCollectionEntry',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(entries),
                        success: function (result) {
                            $("#loader").hide();
                            if (result && result == -1) {
                                Swal.fire({
                                    title: "Error",
                                    text: `Employee's Entry for specified date already exist, please choos another date`,
                                    icon: "error"
                                }).then((result) => {
                                });
                            }
                            else {
                                Swal.fire({
                                    title: "Success",
                                    text: `Data Collection Entries added successfully`,
                                    icon: "success"
                                }).then((result) => {
                                    location.reload();
                                });                                
                            }
                        },
                        error: function (error) {
                            $("#loader").hide();
                            console.error('Error:', error.responseText);
                        }
                    });
                }
            }

        }

     
    }

    function updateDailyCollectionEntries() {

        if ($("#collectionForm").children() && $("#collectionForm").children().length > 0) {
            if (validateInput()) {
                var entriesCount = $("#collectionForm").children().length / 6;
                var entry = {};               

                for (let index = 0; index < entriesCount; index++) {
                    entry = {
                        SubCenterEmployeeId: Number($('#collectionForm').find("#txtEmployee" + "-" + index).data().subcenteremployeeid) ,
                        EntryDate: $('#txtEntryDate').val(),
                        Daily: Number($("#txtDaily-" + index).val()),
                        Hour24: Number($("#txtHours24-" + index).val()),
                        Total: Number($("#txtTotal-" + index).val()),
                        DailyCollectionEntryId: Number($('#hdnDailyCollectionEntryId').val())
                    };
                }
                    $("#loader").show();
                    $.ajax({
                        url: '/Transaction/UpdateDailyCollectionEntry',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(entry),
                        success: function (result) {
                            $("#loader").hide();
                            if (result && result == -1) {
                                Swal.fire({
                                    title: "Error",
                                    text: `Employee's Entry for specified date already exist, please choos another date`,
                                    icon: "error"
                                }).then((result) => {
                                });
                            }
                            else {
                                Swal.fire({
                                    title: "Success",
                                    text: `Data Collection Entry Updated successfully`,
                                    icon: "success"
                                }).then((result) => {
                                    location.reload();
                                });
                            }
                        },
                        error: function (error) {
                            $("#loader").hide();
                            console.error('Error:', error.responseText);
                        }
                    });
            }

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
                    $('#collectionForm').empty();
                    $('#collectionForm').append(`<p>sub center employees details not found</p>`);                        
                    cmbTaluka.append('<option value="0">No Village found</option>');
                }

                $('#cmbvillagename').val(result.length > 0 ? result[0].VillageMasterId : '');

                if ($('#hdnvillageId').val()) {
                    $('#cmbvillagename').val($('#hdnvillageId').val());
                }

                $('#cmbvillagename').trigger('change');
                $("#loader").hide();
            } else {
                $('#collectionForm').empty();
                $('#collectionForm').append(`<p>sub center employees details not found</p>`);                        
                $("#loader").hide();
            }
        },
        error: function (error) {
            $("#loader").hide();
            console.error('Error:', error.responseText);
        }
    });
}

function getSubCenterEmployees(villageId) {

    if ($('#hdnDailyCollectionEntryId').val() > 0) {
        return false;
    }

    if ($('#cmbrPHCCenter').val() > 0 && villageId > 0) {
        $("#loader").show();
        $.ajax({
            url: '/Transaction/GetSubCenterEmployeeDetails?PHCId=' + $('#cmbrPHCCenter').val() + '&VillageId=' + villageId,
            type: 'GET',
            contentType: 'application/json',
            success: function (result) {
                if (result && result.length > 0) {
                    $('#collectionForm').empty();
                    if (result && result.length > 0) {
                        result.forEach(function (subCenter,index) {
                           
                            $('#collectionForm').append(`
                             <div class="col-md-2">
                                <label for="txtSubCenter">Sub Center</label>
                                <input type="text"  class="form-control" id="txtSubCenter" data-SubCenterId='${subCenter.SubCenterId}' value='${subCenter.SubCenterName}' readonly />
                            </div>
                            <div class="col-md-2">
                                <label for="txtEmployee">Sub Center Employee</label>
                                <input type="text" class="form-control" id="txtEmployee-${index}" data-SubCenterEmployeeId='${subCenter.SubCenterEmployeeId}' value='${subCenter.EmployeeName}' readonly />
                            </div>
                            <div class="col-md-2">
                                <label for="txtDesignation">Designation</label>
                                <input type="text" class="form-control" id="txtDesignation" data-DesgnationId='${subCenter.DesgnationId}' value='${subCenter.DesignationName}' readonly />
                            </div>
                            <div class="col-md-2">
                                <label for="txtDaily">Daily</label>
                                <input type="text" class="form-control txtDaily" id="txtDaily-${index}" />
                            </div>
                            <div class="col-md-2">
                                <label for="Hours24">24 Hours</label>
                                <input type="text" class="form-control txtHours24" id="txtHours24-${index}" />
                            </div>
                            <div class="col-md-2" id='txttotal'>
                                <label for="txtTotal">Total</label>
                                <input type="text" class="form-control txtTotal" id="txtTotal-${index}" readonly />
                            </div>
                            `);
                        });
                        $('#collectionForm').append(`                            
                            <div class="col-md-2" >                            
                            </div>
                            <div class="col-md-2" >                            
                            </div>
                            <div class="col-md-2" >                            
                            </div>
                            <div class="col-md-2" >
                                <label for="txtDailyGrandTotal">Daily Grand Total</label>
                                <input type="text" class="form-control" id="txtDailyGrandTotal" readonly />
                            </div>
                            <div class="col-md-2" >
                                <label for="txtHour24GrandTotal">24 Hours Grand Total</label>
                                <input type="text" class="form-control" id="txtHour24GrandTotal" readonly />
                            </div>
                            <div class="col-md-2" >
                                <label for="txtGrandTotal">Grand Total</label>
                                <input type="text" class="form-control" id="txtGrandTotal" readonly />
                            </div>
                            `);
                    } else {

                        $('#collectionForm').append(`<p>sub center employees details not found</p>`);                        
                    }                  
                    
                    $("#loader").hide();
                } else {
                    $('#collectionForm').empty();
                    $('#collectionForm').append(`<p>sub center employees details not found</p>`);                        

                    $("#loader").hide();
                }
            },
            error: function (error) {
                $("#loader").hide();
                console.error('Error:', error.responseText);
            }
        });
    }
 
}

function editDailyEntry(dailyCollectionEntryId) {
    $("#loader").show();
    $.ajax({
        url: '/Transaction/GetDailyEntryById',
        type: 'GET',
        data: {
            DailyCollectionEntryId: dailyCollectionEntryId
        },
        success: function (result) {
            if (result && result.length > 0) {
                $('#hdnDailyCollectionEntryId').val(result[0].DailyCollectionEntryId);
                $('#hdnvillageId').val(result[0].VillageId);
                $('#cmbrPHCCenter').val(result[0].PHCId);
                $('#cmbrPHCCenter').trigger('change');
                $('#saveDailyEntry').text('Update Details');
                $('#saveDailyEntry').addClass('btn-success');
                setDatefromAPI(result[0].EntryDate);

                $('#collectionForm').empty();

                // set the form 
                $('#collectionForm').append(`
                             <div class="col-md-2">
                                <label for="txtSubCenter">Sub Center</label>
                                <input type="text"  class="form-control" id="txtSubCenter" data-SubCenterId='${result[0].SubCenterId}' value='${result[0].SubCenterName}' readonly />
                            </div>
                            <div class="col-md-2">
                                <label for="txtEmployee">Sub Center Employee</label>
                                <input type="text" class="form-control" id="txtEmployee-${0}" data-SubCenterEmployeeId='${result[0].SubCenterEmployeeId}' value='${result[0].EmployeeName}' readonly />
                            </div>
                            <div class="col-md-2">
                                <label for="txtDesignation">Designation</label>
                                <input type="text" class="form-control" id="txtDesignation" data-DesgnationId='${result[0].DesgnationId}' value='${result[0].DesignationName}' readonly />
                            </div>
                            <div class="col-md-2">
                                <label for="txtDaily">Daily</label>
                                <input type="text" class="form-control txtDaily" value="${result[0].Daily}" id="txtDaily-${0}" />
                            </div>
                            <div class="col-md-2">
                                <label for="Hours24">24 Hours</label>
                                <input type="text" class="form-control txtHours24" value="${result[0].Hour24}" id="txtHours24-${0}" />
                            </div>
                            <div class="col-md-2" id='txttotal'>
                                <label for="txtTotal">Total</label>
                                <input type="text" class="form-control txtTotal" value="${result[0].Total}" id="txtTotal-${0}" readonly />
                            </div>
                            `);

            }
            $("#loader").hide();
        },
        error: function (error) {
            $("#loader").hide();
            console.error('Error:', error.responseText);
        }
    });
}



function deleteDailyEntry(dailyCollectionEntryId) {

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
                url: '/Transaction/DeleteDailyCollectionEntry',
                type: 'GET',
                data: {
                    DailyCollectionEntryId: dailyCollectionEntryId
                },
                success: function (result) {
                    $("#loader").hide();
                    Swal.fire({
                        title: "Success",
                        text: "Entry Has Been Deleted",
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

function setDatefromAPI(dateFromAPI) {
    var dateString = dateFromAPI;

    var parts = dateString.split('/');

    var formattedDate = parts[2] + '-' + parts[1] + '-' + parts[0];

    $('#txtEntryDate').val(formattedDate);
}
