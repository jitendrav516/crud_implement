<table class="table">
  <thead>
    <tr>
      <th>Name</th><th>Email</th><th>Phone</th><th>Gender</th><th>Custom Fields</th><th>Actions</th>
    </tr>
  </thead>
  <tbody>
    @foreach($contacts as $c)
      <tr data-id="{{ $c->id }}">
        <td>{{ $c->name }}</td>
        <td>{{ $c->email }}</td>
        <td>{{ $c->phone }}</td>
        <td>{{ $c->gender }}</td>
        <td>
          @foreach($c->customValues as $cv)
            <strong>{{ $cv->definition->label }}:</strong> {{ Str::limit($cv->value,40) }}<br>
          @endforeach
        </td>
        <td>
          <button class="btn btn-sm btn-primary btn-edit" data-id="{{ $c->id }}">Edit</button>
          <button class="btn btn-sm btn-danger btn-delete" data-id="{{ $c->id }}">Delete</button>
            <button class="btn btn-sm btn-warning btn-merge" data-id="{{ $c->id }}">Merge</button>
        </td>

       @if($c->is_merged)
  <span class="badge bg-secondary">Merged into #{{ $c->merged_into }}</span>
@endif
   
</td>


      </tr>
    @endforeach
  </tbody>
</table>

<div id="pagination">
  {!! $contacts->links() !!}
</div>
