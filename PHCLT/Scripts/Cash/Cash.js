jQuery(document).ready(function ($) {
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