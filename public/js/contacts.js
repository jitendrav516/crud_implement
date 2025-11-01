$(function(){

  function loadContacts(params = {}) {
    $.ajax({
      url: '/contacts',
      method: 'GET',
      data: params,
      success: function(res){
        if (res.html) $('#contactsTable').html(res.html);
      },
      error: function(e){ alert('Failed to load contacts'); }
    });
  }

  // Filter button
  $('#btnFilter').on('click', function(){
    const params = {
      name: $('#filterName').val(),
      email: $('#filterEmail').val(),
      gender: $('#filterGender').val(),
    };
    loadContacts(params);
  });

  $('#btnReset').on('click', function(){
    $('#filterName,#filterEmail').val('');
    $('#filterGender').val('');
    loadContacts();
  });

  // Open New
  $('#btnNew').on('click', function(){
    $('#contactForm')[0].reset();
    $('#contact_id').val('');
    $('#contactModal').modal('show');
  });

  // Submit create/update
  $('#contactForm').on('submit', function(e){
    e.preventDefault();
    let form = document.getElementById('contactForm');
    let fd = new FormData(form);
    let contactId = $('#contact_id').val();
    let url = contactId ? '/contacts/' + contactId + '/update' : '/contacts/store';
    $.ajax({
      url: url,
      method: 'POST',
      data: fd,
      processData: false,
      contentType: false,
      success: function(res){
        if (res.success) {
          $('#contactModal').modal('hide');
          loadContacts();
          alert(res.message);
        }
      },
      error: function(xhr){
        let err = xhr.responseJSON;
        alert('Error: ' + (err?.message || 'Validation failed'));
      }
    });
  });

  // Edit click (delegated)
  $(document).on('click', '.btn-edit', function(){
    const id = $(this).data('id');
    // fetch contact details from DOM row or via AJAX endpoint (simpler: via AJAX)
    $.get('/contacts', { id: id }, function(){ /* no-op */ }); // not needed
    // We'll fetch full contact by route - create an endpoint if needed. For now assume table has data or create quick fetch:
    $.ajax({
      url: '/contacts/'+id+'/json', // you should make this route in controller to return JSON
      method: 'GET',
      success: function(res){
        const c = res.contact;
        $('#contact_id').val(c.id);
        $('#name').val(c.name);
        $('#email').val(c.email);
        $('#phone').val(c.phone);
        $('#gender').val(c.gender);
        // populate custom fields
        if (res.custom) {
          Object.keys(res.custom).forEach(function(k){
            $('[name="custom['+k+']"]').val(res.custom[k]);
          });
        }
        $('#contactModal').modal('show');
      }
    });
  });

  // Delete
  $(document).on('click', '.btn-delete', function(){
    if (!confirm('Delete contact?')) return;
    const id = $(this).data('id');
    $.ajax({
      url: '/contacts/' + id,
      method: 'DELETE',
      success: function(res){
        if (res.success) {
          loadContacts();
          alert(res.message);
        }
      },
      error: function(){ alert('Delete failed'); }
    });
  });

  // handle pagination links (delegated)
  $(document).on('click', '#contactsTable .pagination a', function(e){
    e.preventDefault();
    const href = $(this).attr('href');
    const params = {};
    // extract query string page=.. and current filters to pass to loadContacts
    const qs = href.split('?')[1] || '';
    qs.split('&').forEach(function(pair){
      if (!pair) return;
      var p = pair.split('=');
      params[decodeURIComponent(p[0])] = decodeURIComponent(p[1] || '');
    });
    // also include filter inputs
    params.name = $('#filterName').val();
    params.email = $('#filterEmail').val();
    params.gender = $('#filterGender').val();
    loadContacts(params);
  });

});


$(function(){
  // handle open merge modal
  $(document).on('click', '.btn-merge', function(){
    const secondaryId = $(this).data('id');
    $('#mergeContent').html('<div class="text-center">Loading...</div>');
    $('#mergeModal').modal('show');

    // fetch secondary contact basic data
    $.get('/contacts/'+secondaryId+'/merge-modal', function(res){
      const contact = res.contact;
      // fetch possible masters
      $.get('/contacts/'+secondaryId+'/possible-masters', function(mres){
         const masters = mres.masters;
         // build modal UI: dropdown for master + preview
         let html = '<p>Secondary contact: <strong>'+ (contact.name || '') +'</strong></p>';
         html += '<div class="mb-3">';
         html += '<label>Select Master Contact</label>';
         html += '<select id="masterSelect" class="form-control">';
         html += '<option value="">--Choose master--</option>';
         masters.forEach(function(m){
           html += '<option value="'+m.id+'">'+m.name+' — '+(m.email||'')+' '+(m.phone||'')+'</option>';
         });
         html += '</select></div>';

         // show secondary's emails, phones, custom fields
         html += '<h6>Secondary data preview</h6>';
         html += '<p><strong>Emails:</strong></p><ul>';
         if (contact.emails && contact.emails.length) {
            contact.emails.forEach(function(e){ html += '<li>'+e.email+'</li>'; });
         } else {
            html += '<li>' + (contact.email||'No emails') + '</li>';
         }
         html += '</ul>';

         html += '<p><strong>Phones:</strong></p><ul>';
         if (contact.phones && contact.phones.length) {
            contact.phones.forEach(function(p){ html += '<li>'+p.phone+'</li>'; });
         } else {
            html += '<li>' + (contact.phone||'No phones') + '</li>';
         }
         html += '</ul>';

         html += '<p><strong>Custom Fields:</strong></p><ul>';
         if (contact.custom_values && contact.custom_values.length) {
            contact.custom_values.forEach(function(cv){
                // note: if server returns nested structure, adjust accordingly
                const def = cv.definition || cv.definition;
                html += '<li>' + (def ? def.label : cv.field_definition_id) + ': ' + (cv.value||'') + '</li>';
            });
         } else {
           html += '<li>No custom fields</li>';
         }
         html += '</ul>';

         $('#mergeContent').html(html);
         // attach secondary id to confirm button
         $('#confirmMerge').data('secondary', contact.id);
      });
    });
  });

  // confirm merge click
  $('#confirmMerge').on('click', function(){
    const masterId = $('#masterSelect').val();
    const secondaryId = $(this).data('secondary');
    if (!masterId) { alert('Select a master contact'); return; }
    if (!confirm('Are you sure you want to merge this contact into the selected master?')) return;

    $.ajax({
      url: '/contacts/merge',
      method: 'POST',
      data: { master_id: masterId, secondary_id: secondaryId, _token: $('meta[name="csrf-token"]').attr('content') },
      success: function(res){
        if (res.success) {
          $('#mergeModal').modal('hide');
          alert(res.message);
          // optionally reload contact list
          loadContacts(); // assuming loadContacts exists
        } else {
          alert(res.message || 'Merge failed');
        }
      },
      error: function(xhr){
        let msg = 'Merge failed';
        if (xhr.responseJSON && xhr.responseJSON.message) msg = xhr.responseJSON.message;
        alert(msg);
      }
    });
  });
});
