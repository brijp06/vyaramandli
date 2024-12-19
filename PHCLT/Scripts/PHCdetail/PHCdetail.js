jQuery(document).ready(function ($) {
    $('.select2').select2();
    $('.select2').on('change', function () {
        if ($(this).val() === null) {
            $(this).addClass('is-invalid');
        } else {
            $(this).removeClass('is-invalid');
        }
    });
    var disid = $('#cmbrDistrict').val();
    if (disid != "") {

        getTalukaByDistrict(disid, 'cmbTaluka')
    }


});
function getTalukaByDistrict(districtId, cmbTaluka, updTalukaId) {

    $.ajax({
        url: '/PHCdetail/GetTalukasByDistinctId?distinctId=' + districtId,
        type: 'GET',
        contentType: 'application/json',
        success: function (result) {
            if (result && result.length > 0) {
                bindTalukas(result, cmbTaluka, updTalukaId);
            } else {
                console.log('No talukas found.');
            }
        },
        error: function (error) {
            console.error('Error:', error.responseText);
            // Handle the error here
        }
    });
}

function bindTalukas(result, talukaControl, updTalukaId) {


    var cmbTaluka = $('#' + talukaControl);
    cmbTaluka.empty();

    if (result && result.length > 0) {
        result.forEach(function (taluka) {
            cmbTaluka.append('<option value="' + taluka.Id + '">' + taluka.Talukaname + '</option>');
        });
    } else {
        cmbTaluka.append('<option value="">No talukas found</option>');
    }

    // Initialize/select the first option
    cmbTaluka.val(result.length > 0 ? result[0].Id : '');

    if (talukaControl == "cmbTaluka" && $('#hdnCmbTalukaId') && $('#hdnCmbTalukaId').val()) {
        cmbTaluka.val($('#hdnCmbTalukaId').val());
    }

    if (talukaControl == "cmbTalukaPr" && $('#hdnCmbTalukaPrId') && $('#hdnCmbTalukaPrId').val()) {
        cmbTaluka.val($('#hdnCmbTalukaPrId').val());
    }

    cmbTaluka.trigger('change');
}
$('#btnviewlist').click(function (e) {
    window.location.href = "PHCdetailList";
});
$('#btnsave').click(function (e) {
    $("#loader").show();
    var id = $("#Phcid").val();
    var phcname = $("#phcname").val();
    var disid = $('#cmbrDistrict').val();
    var talukaid = $('#cmbTaluka').val();
    var phccode = $('#phccode').val();
    var phcPopulation = $('#phcPopulation').val();
    $.ajax({
        type: 'POST',
        url: '/PHCdetail/AddPHCdetail',
        data: { id: id, phcname: phcname, disid: disid, talukaid: talukaid, phccode: phccode, phcPopulation: phcPopulation },
        success: function (result) {
            $("#loader").hide();
            Toast.fire({
                icon: 'success',
                title: 'Save.'
            })
            $("#phcname").val("");
            $('#cmbrDistrict').val("");
            $('#cmbTaluka').val("");
            $('#phccode').val("");
            $('#phcPopulation').val("");
            $("#Phcid").val(result.opmessage);
        },
        error: function (error) {
            // Handle the error response
            console.log(error);
        }
    });
});
var Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000
});
