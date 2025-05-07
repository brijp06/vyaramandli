jQuery(document).ready(function ($) {
    validateSelection();

    function validateSelection() {
        var selectedValue = $('#usermaster').val();
        if (!selectedValue) {
            $('#btnsave').prop('disabled', true);
            $('#errorMsg').show();
        } else {
            $('#btnsave').prop('disabled', false);
            $('#errorMsg').hide();
        }
    }
    $('#usermaster').on('change', function () {
        validateSelection();
    });
    $('#Qty').on('input', function () {
        //var enteredQty = parseFloat($(this).val());
        //var labelText = $('#lblTotal').text();
        //var totalAmt = parseFloat(labelText.replace(/[^0-9.]/g, ''));

        //if (!isNaN(enteredQty) && enteredQty >= totalAmt) {
        //    $('#errorMsg').show();
        //    $('#btnsave').prop('disabled', true);
        //} else {
        //    $('#errorMsg').hide();
        //    $('#btnsave').prop('disabled', false);
        //}
        var enteredQty = parseFloat($(this).val());
        var labelText = $('#lblTotal').text();
        var totalAmt = parseFloat(labelText.replace(/[^0-9.,]/g, '').replace(/,/g, ''));

        console.log("enteredQty:", enteredQty, "totalAmt:", totalAmt); // Debugging line

        if (!isNaN(enteredQty) && enteredQty > totalAmt) {
            $('#errorMsg').show();
            $('#btnsave').prop('disabled', true);
        } else {
            $('#errorMsg').hide();
            $('#btnsave').prop('disabled', false);
        }
    });
    $('#btnsave').on('click', function () {
        var Billno = $("#billno").val();
        var userid = $("#usermaster").val();
        var billdate = $("#txtEntryDate").val();
        var qty = $("#Qty").val();
        var nname = $('#usermaster option:selected').text();
        $.ajax({
            type: 'POST',
            url: '/Cash/Addpayment',
            data: { Billno: Billno, billdate: billdate, userid: userid, qty: qty, nname: nname },
            success: function (result) {
                var msg = "તમારો રસીદ નંબર છે :- " + result.opmessage + "";
                Swal.fire({
                    title: "તમારી રકમ " + nname + " ને જમા આપ્યા.",
                    text: msg,
                    icon: "success"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = '/cash/index';
                    }
                });
            },
            error: function (error) {
                // Handle the error response
                console.log(error);
            }
        });
    });
});