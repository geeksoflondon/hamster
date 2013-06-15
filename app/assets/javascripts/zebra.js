idleTime = 0;

$(document).ready(function() {
  /*Auto Focus on login page*/
  $("input:password:visible:first").focus();

  /*Detect if the user is idle*/
  // var idleInterval = setInterval("timerIncrement()", 60000); // 1 minute

  // $(this).mousemove(function (e) {
  //     idleTime = 0;
  // });
  // $(this).keypress(function (e) {
  //     idleTime = 0;
  // });

  /*Setup table sorting*/
  if ($("#attendees").length ) {
    $("#attendees").tablesorter({
      cssAsc: "sort-asc",
      cssDesc: "sort-desc",
      headers: {
        4: { sorter: false }
      }
    });
  }

  /*Setup Autocomplete search*/
  $('#search-box').typeahead({
      source: function (query, process) {
          names = []
          map = {};
          $.getJSON('../js/test.json', function(data) {
            $.each(data, function (i, attendee) {
              attendee['name'] = attendee.first_name+" "+attendee.last_name;
              map[attendee.name] = attendee;
              names.push(attendee.name);
            });
            process(names);
          });
      },
      updater: function (item) {
        attendee = map[item];
        window.location.assign("detail.html?id="+attendee.ticket_id);
        return item;
      }
  });

});

// function timerIncrement() {
//     idleTime = idleTime + 1;
//     console.log(idleTime);
//     if (idleTime > 5) { // 3 minutes
//         $.ajax({
//             url: '/zebra/sessions',
//             type: 'DELETE',
//             success: function(result) {
//               window.location.assign("/zebra/sessions");
//             }
//         });
//     }
// }