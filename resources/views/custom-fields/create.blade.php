@extends('layouts.app')

@section('content')
<div class="container">
    <h2>Add Custom Field</h2>

    <form action="{{ route('custom-fields.store') }}" method="POST">
        @csrf
        <div class="mb-3">
            <label>Label</label>
            <input type="text" name="label" class="form-control" required placeholder="e.g. Birthday">
        </div>

        <div class="mb-3">
            <label>Field Key (no spaces)</label>
            <input type="text" name="field_key" class="form-control" required placeholder="e.g. birthday">
        </div>

        <div class="mb-3">
            <label>Type</label>
            <select name="type" class="form-control" id="fieldType" required>
                <option value="text">Text</option>
                <option value="textarea">Textarea</option>
                <option value="date">Date</option>
                <option value="number">Number</option>
                <option value="select">Select</option>
            </select>
        </div>

        <div class="mb-3" id="optionsBox" style="display:none;">
            <label>Options (comma separated)</label>
            <input type="text" name="options" class="form-control" placeholder="e.g. High, Medium, Low">
        </div>

        <button class="btn btn-primary">Save</button>
        <a href="{{ route('custom-fields.index') }}" class="btn btn-secondary">Back</a>
    </form>
</div>

<script>
document.getElementById('fieldType').addEventListener('change', function(){
    document.getElementById('optionsBox').style.display =
        this.value === 'select' ? 'block' : 'none';
});
</script>
@endsection
