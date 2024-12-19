$(document).ready(function () {

    var hdnVillageMasterId = $('#hdnVillageMasterId').val();
    
    $('#btnSaveVillage').on('click', function () {
        if (validateForm()) {
            if (hdnVillageMasterId && hdnVillageMasterId != '') {
                updateVillage();
            }
            else {
                saveVillage();
            }
        }
    });

    function saveVillage() {
        $("#loader").show();        
        const txtVillageName = $("#txtVillageName").val();
        const phcId = $('#cmbrPHCCenter').val();
        const VillagePopulation = $('#txtVillagePopulation').val();

        
        
        $.ajax({
            type: 'POST',
            url: '/PHCdetail/AddVillageDetails',
            data: { PHCId: phcId, VillageName: txtVillageName, VillagePopulation: VillagePopulation},
            success: function (result) {
                $("#loader").hide();
                Toast.fire({
                    icon: 'success',
                    title: 'Saved.'
                })
                const url = `/PHCdetail/VilageList`;
                window.location.href = url;
            },
            error: function (error) {
                // Handle the error response
                console.log(error);
            }
        });
    }

    function updateVillage() {
        $("#loader").show();
        const txtVillageName = $("#txtVillageName").val();
        const phcId = $('#cmbrPHCCenter').val();
        const villageMasterId = hdnVillageMasterId;
        const VillagePopulation = $('#txtVillagePopulation').val();


        $.ajax({
            type: 'POST',
            url: '/PHCdetail/UpdateVillageDetails',
            data: { PHCId: phcId, VillageName: txtVillageName, VillageMasterId: villageMasterId, VillagePopulation: VillagePopulation },
            success: function (result) {
                $("#loader").hide();
                Toast.fire({
                    icon: 'success',
                    title: 'Updated.'
                })
                const url = `/PHCdetail/VilageList`;
                window.location.href = url;
            },
            error: function (error) {
                // Handle the error response
                console.log(error);
            }
        });
    }

    function validateForm() {
        if ($('#cmbrPHCCenter').val() == undefined || $('#cmbrPHCCenter').val() == '' || $('#cmbrPHCCenter').val() == '0') {
            alert('Please Select a PHC Center');
            return false;
        }
        else if ($('#txtVillageName').val() == undefined || $('#txtVillageName').val() == '') {
            alert('Please Enter Village Name');
            return false;
        }

        return true;
    }

    var Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000
    });
});