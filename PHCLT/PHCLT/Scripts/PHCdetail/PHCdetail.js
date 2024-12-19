jQuery(document).ready(function ($) {
    $('.select2').select2();
    $('.select2').on('change', function () {
        if ($(this).val() === null) {
            $(this).addClass('is-invalid');
        } else {
            $(this).removeClass('is-invalid');
        }
    });

    

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
    if (isChecked) {
        var cmbTaluka = $("#cmbTaluka").val();
        $("#cmbTalukaPr").val(cmbTaluka);
        $("#cmbTalukaPr").trigger('change');
    }

}
