idleTime = 0;

$(document).ready(function() {
  /*Auto Focus on login page*/
  $("input:password:visible:first").focus();

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
          $.getJSON('/zebra/attendees.json', function(data) {
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
        window.location.assign("/zebra/ticket/"+attendee.ticket_id);
        return item;
      }
  });
  
  /*Auto Focus on search box*/
  $("#search-box").focus();
  
  $('#ticketTab a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
  })

});