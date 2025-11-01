<div class="modal" id="contactModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <form id="contactForm" enctype="multipart/form-data">
      <div class="modal-content">
        <div class="modal-header"><h5 class="modal-title">Contact</h5></div>
        <div class="modal-body">
          <input type="hidden" name="contact_id" id="contact_id">
          <div class="form-group"><label>Name</label><input name="name" id="name" class="form-control" required></div>
          <div class="form-group"><label>Email</label><input name="email" id="email" class="form-control"></div>
          <div class="form-group"><label>Phone</label><input name="phone" id="phone" class="form-control"></div>
          <div class="form-group">
            <label>Gender</label>
            <select name="gender" id="gender" class="form-control">
              <option value="">Select</option>
              <option value="male">Male</option><option value="female">Female</option><option value="other">Other</option>
            </select>
          </div>

          <div class="form-group">
            <label>Profile Image</label>
            <input type="file" name="profile_image" id="profile_image" class="form-control">
          </div>
          <div class="form-group">
            <label>Additional File</label>
            <input type="file" name="additional_file" id="additional_file" class="form-control">
          </div>

          <hr>
          <h6>Custom Fields</h6>
          <div id="customFieldsContainer">
            @foreach($customFields as $field)
              <div class="form-group">
                <label>{{ $field->label }}</label>
                @if($field->type == 'text')
                  <input name="custom[{{ $field->field_key }}]" data-key="{{ $field->field_key }}" class="form-control">
                @elseif($field->type == 'textarea')
                  <textarea name="custom[{{ $field->field_key }}]" class="form-control"></textarea>
                @elseif($field->type == 'date')
                  <input type="date" name="custom[{{ $field->field_key }}]" class="form-control">
                @elseif($field->type == 'number')
                  <input type="number" name="custom[{{ $field->field_key }}]" class="form-control">
                @elseif($field->type == 'select')
                  <select name="custom[{{ $field->field_key }}]" class="form-control">
                    <option value="">--</option>
                    @foreach($field->options ?? [] as $opt)
                      <option value="{{ $opt }}">{{ $opt }}</option>
                    @endforeach
                  </select>
                @endif
              </div>
            @endforeach
          </div>

        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary" id="saveContact">Save</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </form>
  </div>
</div>
