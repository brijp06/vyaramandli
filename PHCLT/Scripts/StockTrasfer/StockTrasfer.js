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

    $('#btnsave').on('click', function () {
        var Billno = $("#billno").val();
        var userid = $("#usermaster").val();
        var username = $('#usermaster option:selected').text();
        //var itemid = $("#cmbritemname").val();
        var billdate = $("#txtEntryDate").val();
        //var qty = $("#Qty").val();
        //var itemname = $('#cmbritemname option:selected').text();
        var products = [];
        $('#productTable tbody tr').each(function () {
            var ItemName = $(this).find('td:eq(1)').text();  // Item name (second column)
            var Qty = $(this).find('td:eq(2)').text();  // Qty (third column, editable)
            var Itemid = $(this).find('td:eq(0)').text();  // Item name (second column)
            // Add the product data to the array
            products.push({
                ItemName: ItemName,
                Qty: Qty,
                Itemid: Itemid
            });
        });
        $.ajax({
            type: 'POST',
            url: '/TransferStock/Addstock',
            data: { Billno: Billno, billdate: billdate, userid: userid, username: username, products: JSON.stringify(products) },
            success: function (result) {
                var msg = "તમારો Stock Trasfer નંબર છે :- " + result.opmessage + "";
                Swal.fire({
                    title: "તમારો Stock Trasfer ગયો છે.",
                    text: msg,
                    icon: "success"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = '/TransferStock/index';
                    }
                });
            },
            error: function (error) {
                // Handle the error response
                console.log(error);
            }
        });
    });

    $('#addProduct').on('click', function () {
        // Get values from input fields
        var itemcode = $('#cmbritemname').val();
        var itemName = $('#cmbritemname option:selected').text();
        var qty = $('#Qty').val();



        // Check if inputs are not empty
        if (itemName.trim() === '') {
            alert('કૃપા કરી વસ્તુ નું નામ નાખો');
            return;
        }
        if (qty.trim() === '') {
            alert('કૃપા કરી જથ્થો નાખો');
            return;
        }
        // Create a new table row with the input values
        var newRow = `
                <tr>
                    <td style="display:none">${itemcode}</td>
                    <td>${itemName}</td>
                   <td>
                        ${qty}
                    </td>
                    <td>
                        <button class="btn btn-danger btn-sm deleteRow">Delete</button>
                    </td>
                </tr>
            `;

        // Append the new row to the table body
        $('#productTable tbody').append(newRow);
        $('#cmbritemname').val('');
        $('#Qty').val('');

    });
    $(document).on('click', '.deleteRow', function () {
        // Remove the row of the clicked button
        $(this).closest('tr').remove();
        
    });
});